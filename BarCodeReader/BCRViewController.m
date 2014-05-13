//
//  BCRViewController.m
//  BarCodeReader
//
//  Created by Massimo Moro on 09/05/14.
//  Copyright (c) 2014 MassimoMoro. All rights reserved.
//

#import "BCRViewController.h"
#define TorneoPomeridiano 18
#define TorneoSerale 19
#define TorneoNotturno 24

@interface BCRViewController ()
@property(strong,nonatomic)UIAlertView *alertView;
@end

@implementation BCRViewController
@synthesize resultImage, resultText;
static BOOL pressed;
- (IBAction) scanButtonTapped
{
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
//    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//    if (UIDeviceOrientationLandscapeLeft == orientation) {
//        //Rotate 90
//        reader.cameraViewTransform = CGAffineTransformMakeRotation (3*M_PI/2.0);
//    } else if (UIDeviceOrientationLandscapeRight == orientation) {
//        //Rotate 270
//        reader.cameraViewTransform = CGAffineTransformMakeRotation (M_PI/2.0);
//    }
    //reader.cameraDevice=UIImagePickerControllerCameraDeviceFront;
  
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    [self presentViewController:reader animated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Pressed");
    pressed=FALSE;
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // EXAMPLE: do something useful with the barcode data
    if (!pressed) {
        resultText.text = symbol.data;
        NSLog(@"Codice: %@", symbol.data);
        [self findDuplicate: symbol dataTorneo:[NSDate date]];
        pressed=FALSE;
        
    }
    pressed=YES;
    
    
    
    
    
    // EXAMPLE: do something useful with the barcode image
    resultImage.image =
    [info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
   // [reader dismissModalViewControllerAnimated: YES];
}

-(void)findDuplicate:(ZBarSymbol *) symbol dataTorneo:(NSDate *)dataTorneo {
    if ([self.iscrizioni objectForKey:symbol.data]) {
    
        NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
        NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:[[self.iscrizioni objectForKey:symbol.data] lastObject]];
       // NSDate* lastTournament = [[NSDate alloc] initWithTimeInterval:-destinationGMTOffset sinceDate:[[self.iscrizioni objectForKey:symbol.data] lastObject]];
        NSDate* lastTournament=[[self.iscrizioni objectForKey:symbol.data] lastObject];
       
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:lastTournament];
         NSDateComponents *componentsNow = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[NSDate date]];
        NSInteger hour = [components hour];
        NSInteger hourNow = [componentsNow hour];

        
        //Controlla se si è già iscritto oggi
        if ([lastTournament compare:[NSDate date]]) {
            if ((hour<TorneoPomeridiano) && (hourNow<TorneoPomeridiano)) {
                self.alertView= [[UIAlertView alloc] initWithTitle:@"Ciao! "
                                                           message:@"Ti sei già registrato per il torneo pomeridiano!"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
                
                [self.alertView show];
              //aggiungere QUI controllo con l'ora attuale e sotto
            } else if((TorneoPomeridiano<hour && hour<TorneoSerale) && (TorneoPomeridiano<hourNow && hourNow<TorneoSerale)) {
                NSLog(@"Sera");
                self.alertView= [[UIAlertView alloc] initWithTitle:@"Ciao! "
                                                           message:@"Ti sei già registrato per il torneo serale!"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
                
                [self.alertView show];
            } else if(TorneoSerale<hour<TorneoNotturno) {
                 NSLog(@"Notte");
            }
        } else {
            //Ha già partecipato a tornei ma non a quello odierno, quindi lo iscrivo
            NSMutableArray *torneo=[self.iscrizioni objectForKey:symbol.data];
            [torneo addObject:[NSDate date]];
            [self.iscrizioni setObject:torneo  forKey:symbol.data];
            [self salvaDati:symbol];
            self.alertView= [[UIAlertView alloc] initWithTitle:@"Ciao! "
                                                       message:@"Sei stato aggiunto alla lista di attesa notturna."
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
            
            [self.alertView show];
        }
        
    } else {
        //È la prima volta che si iscrive alla lista di attesa
        [self.iscrizioni setObject:@[[NSDate date]]  forKey:symbol.data];
        [self salvaDati:symbol];
        self.alertView= [[UIAlertView alloc] initWithTitle:@"Ciao! "
                                                   message:@"Sei stato aggiunto alla lista di attesa."
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
        
        [self.alertView show];
    }

}

-(void)salvaDati:(ZBarSymbol *)symbol {
    NSString *error;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Tornei.plist"];

    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:self.iscrizioni
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
    }
    else {
        NSLog(error);
        //[error release];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //iPad
    
    NSMutableArray *a=[[NSMutableArray alloc] init];
    [a addObject:[NSDate date]];
    NSDate *b=a[0];
    
    self.iscrizioni=[[NSMutableDictionary alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
    [self loadPlist];
}

-(void)loadPlist {
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"Tornei.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"Tornei" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
//    NSString *plistName = [NSString stringWithFormat:@"Tornei"];
//    NSMutableArray *contentArray = [[NSMutableArray alloc] initWithContentsOfFile:
//                             [[NSBundle mainBundle] pathForResource:plistName
//                                                             ofType:@"plist"]];
    self.iscrizioni=temp;
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation
{
    return(YES);
}

@end
