//
//  BCRViewController.m
//  BarCodeReader
//
//  Created by Massimo Moro on 09/05/14.
//  Copyright (c) 2014 MassimoMoro. All rights reserved.
//

#import "BCRViewController.h"
#import "ZBarReaderViewController.h"
#import "TTCounterLabel.h"
#import "BCRArtView.h"
#import "BCRFinishViewController.h"
#import "BCRCreateList.h"

typedef NS_ENUM(NSInteger, kTTCounter){
    kTTCounterRunning = 0,
    kTTCounterStopped,
    kTTCounterReset,
    kTTCounterEnded
};

#define TorneoPomeridiano @"13:30"
#define TorneoSerale @"21:15"
#define TorneoNotturno @"23:15"

@interface BCRViewController ()<TTCounterLabelDelegate>
@property(strong,nonatomic)UIAlertView *alertView;
@property(strong,nonatomic)TTCounterLabel *timerLabel;
@property(strong, nonatomic)NSString *tipo;
@property(strong,nonatomic)NSString *torneo;
@property (nonatomic, strong) CustomAlertViewController *customAlert;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker2;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker3;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@end

@implementation BCRViewController
@synthesize resultImage, resultText;
BOOL toggle1IsOn;
static BOOL pressed;
- (IBAction) scanButtonTapped
{
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.showsCameraControls = NO;  // for UIImagePickerController
    reader.showsZBarControls = NO;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    BCRArtView *timerView=[[BCRArtView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 1024, 200)];
    self.timerLabel=[[TTCounterLabel alloc] initWithFrame:CGRectMake(810, 115, 200, 80)];
    self.timerLabel.countdownDelegate=self;
    UILabel *textLabel=[[UILabel alloc] initWithFrame:CGRectMake(40, 20, 960, 150)];
    //textLabel.text=@"Iscrizioni torneo slot pomeridiano";
    //textLabel.textAlignment = NSTextAlignmentCenter;
   // textLabel.font=[UIFont fontWithName:@"CooperBT-Bold" size:55.0];
    textLabel.lineBreakMode=NSLineBreakByWordWrapping;
    textLabel.numberOfLines=0;
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    paragrapStyle.alignment = NSTextAlignmentCenter;
    textLabel.attributedText=[[NSAttributedString alloc]
                               initWithString:[NSString stringWithFormat:@"Iscrizioni torneo slot %@", self.tipo]
                               attributes:@{
                                            NSFontAttributeName:[UIFont fontWithName:@"CooperBT-Bold" size:55.0],
                                            NSForegroundColorAttributeName:[UIColor colorWithRed:0.902 green:0.676 blue:0.135 alpha:1.000],
                                            NSStrokeWidthAttributeName: [NSNumber numberWithFloat:-3.0],
                                            NSStrokeColorAttributeName:[UIColor colorWithRed:0.642 green:0.021 blue:0.082 alpha:1.000],
                                            NSParagraphStyleAttributeName: paragrapStyle
                                            
                                            }
                               ];
    
   // textLabel.textColor=[UIColor colorWithRed:0.902 green:0.676 blue:0.135 alpha:1.000];
    [timerView addSubview:self.timerLabel];
    [timerView addSubview:textLabel];
    
    [self customiseAppearance];
    self.timerLabel.countDirection=kCountDirectionDown;
    
    self.timerLabel.startValue=[self calcolaTimer];
    [self.timerLabel start];
    reader.cameraOverlayView = timerView;

  
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    [self presentViewController:reader animated:YES completion:nil];
}

-(NSInteger )calcolaTimer {
    

    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSDate *date = [dateFormat dateFromString:self.torneo];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit) fromDate:[NSDate date]];
    NSDateComponents *components2 = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit ) fromDate:date];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    NSInteger hour=[components2 hour];
    NSInteger minute=[components2 minute];
    
    NSCalendar *calendarForNewDate = [NSCalendar currentCalendar];
   
    NSDateComponents *components5 = [[NSDateComponents alloc] init];
    [components5 setYear:year];
    [components5 setMonth:month];
    [components5 setDay:day];
    [components5 setHour:hour];
    [components5 setMinute:minute];
    NSDate *newDate=[calendarForNewDate dateFromComponents:components5];
  
    
    
    NSTimeInterval interval = [newDate timeIntervalSinceDate: [NSDate date]];//[date1 timeIntervalSince1970] - [date2 timeIntervalSince1970];
//    int hour2 = interval / 3600;
//    int minute2 = (int)interval % 3600 / 60;
//    
//    NSLog(@"%@ %dh %dm", interval<0?@"-":@"+", ABS(hour2), ABS(minute2));
    return interval*1000;
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

-(double)hourAndMinuteToSecondsConvert:(NSString *)string {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSDate *date = [dateFormat dateFromString:string];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components2 = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit ) fromDate:date];
 
    NSInteger hours=[components2 hour];
    NSInteger minutes=[components2 minute];
    
      return (hours * 60 * 60) + (minutes * 60) ;
}

-(void)findDuplicate:(ZBarSymbol *) symbol dataTorneo:(NSDate *)dataTorneo {
    if ([self.iscrizioni objectForKey:symbol.data]) {

        NSDate* lastTournament=[[self.iscrizioni objectForKey:symbol.data] lastObject];
       
        NSCalendar *calendar = [NSCalendar currentCalendar];

        NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit |NSDayCalendarUnit |NSMonthCalendarUnit) fromDate:lastTournament];
        NSDateComponents *componentsNow = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSMinuteCalendarUnit) fromDate:[NSDate date]];
        NSInteger hour = [components hour];
        NSInteger minute=[components minute];
        NSInteger day=[components day];
        NSInteger month=[components month];
        
        NSInteger hourNow = [componentsNow hour];
        NSInteger dayNow=[componentsNow day];
        NSInteger monthNow=[componentsNow month];
        NSInteger minuteNow=[componentsNow minute];
        double currentSeconds=(hourNow * 60 * 60) + (minuteNow * 60) ;
        double secondsForLastObject =(hour * 60 * 60) + (minute * 60) ;
        
        //Controlla se si è già iscritto oggi
        NSLog(@"Data: %@", [NSDate date]);
        if (day==dayNow && month==monthNow) {
            if (currentSeconds<[self hourAndMinuteToSecondsConvert:self.label2.text]) {
                if (secondsForLastObject<[self hourAndMinuteToSecondsConvert:self.label2.text]) {
                    [self showAlert:@"pomeridiano!"];
                } else {
                    NSLog(@"Maybe there is a serious problem...");
                }
              //aggiungere QUI controllo con l'ora attuale e sotto
            } else if(currentSeconds>=[self hourAndMinuteToSecondsConvert:self.label2.text] && currentSeconds<[self hourAndMinuteToSecondsConvert:self.label4.text]) {
                if (secondsForLastObject>=[self hourAndMinuteToSecondsConvert:self.label2.text] && secondsForLastObject<[self hourAndMinuteToSecondsConvert:self.label4.text]) {
                    [self showAlert:@"serale!"];
                } else {
                    [self aggiungiALista:symbol];
                }
            } else if(currentSeconds>=[self hourAndMinuteToSecondsConvert:self.label4.text] && currentSeconds<[self hourAndMinuteToSecondsConvert:self.label6.text]) {
                if (secondsForLastObject>=[self hourAndMinuteToSecondsConvert:self.label4.text] && secondsForLastObject<[self hourAndMinuteToSecondsConvert:self.label6.text]) {
                    [self showAlert:@"notturno!"];
                } else {
                    [self aggiungiALista:symbol];
                }
            }
        } else {
            //Ha già partecipato a tornei ma non a quello odierno, quindi lo iscrivo
            [self aggiungiALista:symbol];

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
-(double)currentSeconds {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *componentsNow = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSMinuteCalendarUnit) fromDate:[NSDate date]];
    
    NSInteger hourNow = [componentsNow hour];
    NSInteger minuteNow=[componentsNow minute];
    
    return (hourNow * 60 * 60) + (minuteNow * 60) ;;
}
-(void)showAlert:(NSString *)withString {
    self.alertView= [[UIAlertView alloc] initWithTitle:@"Ciao! "
                                               message:[NSString stringWithFormat:@"Ti sei già registrato per il torneo %@", withString]
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
    
    [self.alertView show];
}

-(void)aggiungiALista:(ZBarSymbol *) symbol {
    NSMutableArray *torneo=[self.iscrizioni objectForKey:symbol.data];
    [torneo addObject:[NSDate date]];
    [self.iscrizioni setObject:torneo  forKey:symbol.data];
    [self salvaDati:symbol];
    self.alertView= [[UIAlertView alloc] initWithTitle:@"Ciao! "
                                               message:@"Sei stato aggiunto alla lista di attesa."
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
    
    [self.alertView show];
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
    
    self.datePicker.datePickerMode = UIDatePickerModeTime;
    self.datePicker2.datePickerMode = UIDatePickerModeTime;
    self.datePicker3.datePickerMode = UIDatePickerModeTime;
    [self.datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"it_IT"]];
    [self.datePicker2 setLocale:[NSLocale localeWithLocaleIdentifier:@"it_IT"]];
    [self.datePicker3 setLocale:[NSLocale localeWithLocaleIdentifier:@"it_IT"]];
   
    
    self.button1.titleLabel.numberOfLines=0;
    self.iscrizioni=[[NSMutableDictionary alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
    [self loadPlist];
    
    if ([self currentSeconds]<[self hourAndMinuteToSecondsConvert:self.label2.text]) {
        self.torneo=self.label2.text;
        self.tipo=@"pomeridiano";
    } else if ([self currentSeconds]>=[self hourAndMinuteToSecondsConvert:self.label2.text] && [self currentSeconds]<[self hourAndMinuteToSecondsConvert:self.label4.text]) {
        self.torneo=self.label4.text;
        self.tipo=@"serale";
    } else if ([self currentSeconds]>=[self hourAndMinuteToSecondsConvert:self.label4.text] && [self currentSeconds]<[self hourAndMinuteToSecondsConvert:self.label6.text]) {
        self.torneo=self.label6.text;
        self.tipo=@"notturno";
    }
}
- (IBAction)setTorneo1:(id)sender {
    [self dateChanged:self.label1 andLabel:self.label2 andButton:self.button1];
}
- (IBAction)setTorneo2:(id)sender {
    [self dateChanged:self.label3 andLabel:self.label4 andButton:self.button2];
}
- (IBAction)setTorneo3:(id)sender {
    [self dateChanged:self.label5 andLabel:self.label6 andButton:self.button3];
}

- (void)dateChanged:(UILabel *)label1 andLabel:(UILabel *)label2 andButton:(UIButton *)button {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *currentTime = [dateFormatter stringFromDate:self.datePicker.date];
    
    if(toggle1IsOn){
        [button setTitle:@"Imposta Ora fine" forState:UIControlStateNormal];
        label1.text = currentTime;
    }
    else {
        [button setTitle:@"Imposta Ora inizio" forState:UIControlStateNormal];
        label2.text = currentTime;
    }
    toggle1IsOn = !toggle1IsOn;
    
}

-(void)customAlertOK{
    
        
        [_customAlert removeCustomAlertFromViewInstantly];
    
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

#pragma mark - TTCounterLabelDelegate

- (void)countdownDidEndForSource:(TTCounterLabel *)source {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"] bundle:[NSBundle mainBundle]];
    BCRCreateList *presentingViewController=  [storyboard instantiateViewControllerWithIdentifier:@"list"];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self presentViewController:presentingViewController animated:YES completion:nil];
}

- (void)updateUIForState:(NSInteger)state withSource:(TTCounterLabel *)label {
    switch (state) {
            //        case kTTCounterRunning:
            //            [_startStopButton setTitle:NSLocalizedString(@"Stop", @"Stop") forState:UIControlStateNormal];
            //            _resetButton.hidden = YES;
            //            break;
            //
            //        case kTTCounterStopped:
            //            [_startStopButton setTitle:NSLocalizedString(@"Resume", @"Resume") forState:UIControlStateNormal];
            //            _resetButton.hidden = NO;
            //            break;
            //
            //        case kTTCounterReset:
            //            [_startStopButton setTitle:NSLocalizedString(@"Start", @"Start") forState:UIControlStateNormal];
            //            _resetButton.hidden = YES;
            //            _startStopButton.hidden = NO;
            //            break;
            //
            //        case kTTCounterEnded:
            //            _startStopButton.hidden = YES;
            //            _resetButton.hidden = NO;
            //            break;
            
        default:
            break;
    }
}

- (void)customiseAppearance {
    [self.timerLabel setBoldFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:35]];
    [self.timerLabel setRegularFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:35]];
    
    // The font property of the label is used as the font for H,M,S and MS
    [self.timerLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15]];
    
    // Default label properties
    self.timerLabel.textColor = [UIColor whiteColor];
    
    // After making any changes we need to call update appearance
    [self.timerLabel updateApperance];
}

- (IBAction)iscritti:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"] bundle:[NSBundle mainBundle]];
    BCRCreateList *presentingViewController=  [storyboard instantiateViewControllerWithIdentifier:@"list"];
    
    [self presentViewController:presentingViewController animated:YES completion:nil];
}


@end
