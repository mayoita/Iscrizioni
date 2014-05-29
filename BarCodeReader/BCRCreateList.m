//
//  BCRCreateList.m
//  BarCodeReader
//
//  Created by Massimo Moro on 12/05/14.
//  Copyright (c) 2014 MassimoMoro. All rights reserved.
//
#import <MessageUI/MessageUI.h>
#import "BCRCreateList.h"
#import "RSworkBook.h"
#import "RSCell.h"
#import "TTCounterLabel.h"

typedef NS_ENUM(NSInteger, kTTCounter){
    kTTCounterRunning = 0,
    kTTCounterStopped,
    kTTCounterReset,
    kTTCounterEnded
};

@interface BCRCreateList ()<MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>
@property(strong,nonatomic)NSMutableArray *lista;
@property (nonatomic, weak) IBOutlet UILabel *feedbackMsg;
@property (strong,nonatomic)NSString *nomeLista;
@property (strong,nonatomic)NSString *pathDir;
@end

@implementation BCRCreateList
@synthesize lista=_lista;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _lista=[[NSMutableArray alloc] init];
    self.iscrizioni=[[NSMutableDictionary alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
    [self loadPlist];
    [self createList];
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
- (IBAction)sendExcelFile:(id)sender {
     [self sendEmail];
}
- (void)createList {
    
    NSMutableArray *primaIscrizione=[[NSMutableArray alloc] init];
    NSMutableArray *torneiPrecedenti=[[NSMutableArray alloc] init];
    NSMutableArray *torneiPrecedentiEOdierni=[[NSMutableArray alloc] init];
    
    NSEnumerator *enumerator = [self.iscrizioni keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        NSArray *tornei = [self.iscrizioni objectForKey:key];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSInteger comps = (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit);
        
        NSDateComponents *date1Components = [calendar components:comps
                                                        fromDate: [NSDate date]];
        NSDateComponents *date2Components = [calendar components:comps
                                                        fromDate: [tornei lastObject]];
        
        NSDate *date1 = [calendar dateFromComponents:date1Components];
        NSDate *date2 = [calendar dateFromComponents:date2Components];
        if ([date1 compare:date2] == NSOrderedSame) {
        //Controlla prima se l'ultima data registrata corrisponde alla data odierna
        if ([tornei count]==1) {
            NSLog(@"Prima iscrizione");
            NSDictionary *record=@{
                                   @"Codice":key,
                                   @"Data":[tornei lastObject],
                                   @"NumeroTorneiOdierni":@0,
                                   @"NumeroTorneiPrecedenti":@0};
            [primaIscrizione addObject:record];
            
        } else {
            NSInteger x=0;
            NSInteger y=0;
            for (int i=0; i<[tornei count]; i++) {
                NSDateComponents *date3Components = [calendar components:comps
                                                                fromDate: tornei[i]];
                NSDate *date3 = [calendar dateFromComponents:date3Components];
                
                if ([date1 compare:date3] == NSOrderedSame) {
                    //Conta quanti tornei ha già fatto oggi
                    x++;
                } else {
                    //Conta quanti tornei ha già fatto precedentemente
                    y++;
                }
            }
            if (x==1) {
               
                NSDictionary *record=@{
                                       @"Codice":key,
                                       @"Data":[tornei lastObject],
                                       @"NumeroTorneiOdierni":[NSNumber numberWithInt:x],
                                       @"NumeroTorneiPrecedenti":[NSNumber numberWithInt:y]
                                       };
                [torneiPrecedenti addObject:record];
            } else {
                NSDictionary *record=@{
                                       @"Codice":key,
                                       @"Data":[tornei lastObject],
                                       @"NumeroTorneiOdierni":[NSNumber numberWithInt:x],
                                       @"NumeroTorneiPrecedenti":[NSNumber numberWithInt:y]
                                       };
                [torneiPrecedentiEOdierni addObject:record];
            }
        }
        }
    }
    NSLog(@"Fine");
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Data" ascending:TRUE];
    NSSortDescriptor *sortDescriptorTornei = [[NSSortDescriptor alloc] initWithKey:@"NumeroTorneiPrecedenti" ascending:TRUE];
    
    //Ordinamento in base all'ora di iscrizione
    [primaIscrizione sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [torneiPrecedenti sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    //A parità di tornei odierni viene privilegiato chi ha fatto meno tornei in passato
    [torneiPrecedentiEOdierni sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptorTornei]];
    
    _lista=(NSMutableArray *)[[primaIscrizione arrayByAddingObjectsFromArray:torneiPrecedenti] arrayByAddingObjectsFromArray:torneiPrecedentiEOdierni];
    NSLog(@"Fine");
    [self.listaIscritti reloadData];
    [self creaFoglioExcel];
   // [self sendEmail];
}


//table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_lista count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cliente"];
    
    /*
     *   If the cell is nil it means no cell was available for reuse and that we should
     *   create a new one.
     */
    if (cell == nil) {
        
        /*
         *   Actually create a new cell (with an identifier so that it can be dequeued).
         */
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cliente"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    /*
     *   Now that we have a cell we can configure it to display the data corresponding to
     *   this row/section
     */
    
    NSDictionary *item = (NSDictionary *)[self.lista objectAtIndex:indexPath.row];
    UILabel *cliente=(UILabel *)[cell viewWithTag:1];
    cliente.text = [item objectForKey:@"Codice"];
    
    UILabel *data=(UILabel *)[cell viewWithTag:2];
    data.text =[NSDateFormatter localizedStringFromDate:[item objectForKey:@"Data"]
                                              dateStyle:NSDateFormatterShortStyle
                                              timeStyle:NSDateFormatterShortStyle];
    
   
    
    UILabel *odierni=(UILabel *)[cell viewWithTag:3];
    odierni.text = [[item objectForKey:@"NumeroTorneiOdierni"] stringValue];

    UILabel *precedenti=(UILabel *)[cell viewWithTag:4];
    precedenti.text = [[item objectForKey:@"NumeroTorneiPrecedenti"] stringValue];
    
    if ([[[item objectForKey:@"NumeroTorneiOdierni"] stringValue]  isEqual: @"0"] ) {
        cell.backgroundColor=[UIColor colorWithRed:0.552 green:0.861 blue:0.901 alpha:1.000];
    } else if ([[[item objectForKey:@"NumeroTorneiOdierni"] stringValue]  isEqual: @"1"]) {
        cell.backgroundColor=[UIColor colorWithRed:1.000 green:0.917 blue:0.678 alpha:1.000];
    } else {
        cell.backgroundColor=[UIColor colorWithRed:1.000 green:0.678 blue:0.678 alpha:1.000];
    }
    return cell;
}

-(void)creaFoglioExcel {
    RSworkBook * folder = [ [RSworkBook alloc] init];
    folder.author = @"Massimo Moro";
    folder.version = 1.2;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH_mm"];
    NSDate *date = [NSDate date];
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    NSString *nomeLista=[NSString stringWithFormat:@"ListaIscritti_%@",formattedDateString];
    self.nomeLista=nomeLista;
    RSworkSheet * sheet = [[RSworkSheet alloc] initWithName:@"ListaIscritti"];
    sheet.columnWidth=150;
    RSworkSheetRow * row = [[RSworkSheetRow alloc] initWithHeight:20];
    
    RSStyle * styleRow = [[RSStyle alloc] init];
    styleRow.font = [UIFont systemFontOfSize:14];
    styleRow.size = 14;
    styleRow.color = [UIColor redColor];
    styleRow.backgroundColor=[UIColor colorWithRed:0.988 green:0.327 blue:0.351 alpha:1.000];
    styleRow.alignmentV = RSStyleTopAlign;
    styleRow.alignmentH = RSStyleMiddleAlign;
    row.style=styleRow;
    [row addCellString:@"Codice cliente" withStyle:styleRow];
    [row addCellString:@"Ora iscrizione" withStyle:styleRow];
    [row addCellString:@"n° tornei odierni" withStyle:styleRow];
    [row addCellString:@"n° tornei precedenti" withStyle:styleRow];
    [sheet addWorkSheetRow:row];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"dd-MM-yyyy HH:mm"];
   
 
    for (int i=0; i<[_lista count]; i++) {
         NSDictionary *item = (NSDictionary *)self.lista[i];
        
        RSworkSheetRow * row2 = [[RSworkSheetRow alloc] initWithHeight:20];
 
        
       if ([[[item objectForKey:@"NumeroTorneiOdierni"] stringValue]  isEqual: @"0"]) {
           RSStyle * styleCell1 = [[RSStyle alloc] init];
           styleCell1.font = [UIFont systemFontOfSize:14];
           styleCell1.size = 14;
           styleCell1.color = [UIColor blackColor];
           styleCell1.backgroundColor=[UIColor colorWithRed:0.689 green:0.999 blue:0.679 alpha:1.000];
           styleCell1.alignmentV = RSStyleTopAlign;
           styleCell1.alignmentH = RSStyleMiddleAlign;
           row2.style=styleCell1;
        
        [row2 addCellString:[item objectForKey:@"Codice"] withStyle:styleCell1];
        [row2 addCellString:[dateFormatter2 stringFromDate:[item objectForKey:@"Data"]] withStyle:styleCell1];
        [row2 addCellNumber:[[item objectForKey:@"NumeroTorneiOdierni"] floatValue] withStyle:styleCell1];
        [row2 addCellNumber:[[item objectForKey:@"NumeroTorneiPrecedenti"] floatValue] withStyle:styleCell1];
       } else if ([[[item objectForKey:@"NumeroTorneiOdierni"] stringValue]  isEqual: @"1"]) {
           
           RSStyle * styleCell2 = [[RSStyle alloc] init];
           styleCell2.font = [UIFont systemFontOfSize:14];
           styleCell2.size = 14;
           styleCell2.color = [UIColor blackColor];
           styleCell2.backgroundColor=[UIColor colorWithRed:0.628 green:1.000 blue:0.989 alpha:1.000];
           styleCell2.alignmentV = RSStyleTopAlign;
           styleCell2.alignmentH = RSStyleMiddleAlign;
           row2.style=styleCell2;
           
           [row2 addCellString:[item objectForKey:@"Codice"] withStyle:styleCell2];
           [row2 addCellString:[dateFormatter2 stringFromDate:[item objectForKey:@"Data"]] withStyle:styleCell2];
           [row2 addCellNumber:[[item objectForKey:@"NumeroTorneiOdierni"] floatValue] withStyle:styleCell2];
           [row2 addCellNumber:[[item objectForKey:@"NumeroTorneiPrecedenti"] floatValue] withStyle:styleCell2];
       } else {
           
           RSStyle * styleCell3 = [[RSStyle alloc] init];
           styleCell3.font = [UIFont systemFontOfSize:14];
           styleCell3.size = 14;
           styleCell3.color = [UIColor blackColor];
           styleCell3.backgroundColor=[UIColor colorWithRed:0.616 green:0.629 blue:0.998 alpha:1.000];
           styleCell3.alignmentV = RSStyleTopAlign;
           styleCell3.alignmentH = RSStyleMiddleAlign;
           row2.style=styleCell3;
           
           [row2 addCellString:[item objectForKey:@"Codice"] withStyle:styleCell3];
           [row2 addCellString:[dateFormatter2 stringFromDate:[item objectForKey:@"Data"]] withStyle:styleCell3];
           [row2 addCellNumber:[[item objectForKey:@"NumeroTorneiOdierni"] floatValue] withStyle:styleCell3];
           [row2 addCellNumber:[[item objectForKey:@"NumeroTorneiPrecedenti"] floatValue] withStyle:styleCell3];
       }
     
        [sheet addWorkSheetRow:row2];
    }
    
    
    [folder addWorkSheet:sheet];
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    [folder writeWithName:nomeLista toPath:documentsDir];
    NSString *pathFinal = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@/", self.nomeLista, @".xls"]];
    self.pathDir=pathFinal;
}

-(void)sendEmail {
    // You must check that the current device can send email messages before you
    // attempt to create an instance of MFMailComposeViewController.  If the
    // device can not send email messages,
    // [[MFMailComposeViewController alloc] init] will return nil.  Your app
    // will crash when it calls -presentViewController:animated:completion: with
    // a nil view controller.
    if ([MFMailComposeViewController canSendMail])
        // The device can send email.
    {
        [self displayMailComposerSheet];
    }
    else
        // The device can not send email.
    {
        self.feedbackMsg.hidden = NO;
		self.feedbackMsg.text = @"Device not configured to send mail.";
    }
}

#pragma mark - Compose Mail/SMS

// -------------------------------------------------------------------------------
//	displayMailComposerSheet
//  Displays an email composition interface inside the application.
//  Populates all the Mail fields.
// -------------------------------------------------------------------------------
- (void)displayMailComposerSheet
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:self.nomeLista];
	
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"mayoita@hotmail.com"];
	NSArray *ccRecipients = [NSArray arrayWithObjects:@"massimo.moro72@gmail.com", @"mmoro@casinovenezia.it", nil];
	
	
	[picker setToRecipients:toRecipients];
	[picker setCcRecipients:ccRecipients];
	
	
	// Attach an image to the email
	NSData *myData = [NSData dataWithContentsOfFile:self.pathDir];
	[picker addAttachmentData:myData mimeType:@"application/excel" fileName:[NSString stringWithFormat:@"%@%@", self.nomeLista, @".xls"]];
	
	// Fill out the email body text
	NSString *emailBody = @"In allegato la lista degli iscritti";
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - Delegate Methods

// -------------------------------------------------------------------------------
//	mailComposeController:didFinishWithResult:
//  Dismisses the email composition interface when users tap Cancel or Send.
//  Proceeds to update the message field with the result of the operation.
// -------------------------------------------------------------------------------
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	self.feedbackMsg.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			self.feedbackMsg.text = @"Email annullata";
			break;
		case MFMailComposeResultSaved:
			self.feedbackMsg.text = @"Result: Mail saved";
			break;
		case MFMailComposeResultSent:
            
			self.feedbackMsg.text = @"Email inviata !!!";
			break;
		case MFMailComposeResultFailed:
			self.feedbackMsg.text = @"Result: Mail sending failed";
			break;
		default:
			self.feedbackMsg.text = @"Result: Mail not sent";
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)exit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
