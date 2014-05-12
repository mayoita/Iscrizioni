//
//  BCRCreateList.m
//  BarCodeReader
//
//  Created by Massimo Moro on 12/05/14.
//  Copyright (c) 2014 MassimoMoro. All rights reserved.
//

#import "BCRCreateList.h"

@implementation BCRCreateList

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
- (IBAction)createList:(id)sender {
    NSEnumerator *enumerator = [self.iscrizioni keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        NSArray *tornei = [self.iscrizioni objectForKey:key];
        if ([tornei count]==1) {
            NSLog(@"Prima iscrizione");
        } else {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSInteger comps = (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit);
            
            NSDateComponents *date1Components = [calendar components:comps
                                                            fromDate: [NSDate date]];
            NSDateComponents *date2Components = [calendar components:comps
                                                            fromDate: [tornei lastObject]];
            
            NSDate *date1 = [calendar dateFromComponents:date1Components];
            NSDate *date2 = [calendar dateFromComponents:date2Components];
            
            NSComparisonResult result = [date1 compare:date2];
            if (result == NSOrderedAscending) {
                NSLog(@"sopra");
            } else if (result == NSOrderedDescending) {
                NSLog(@"sotto");
            }  else {
                //the same
                NSLog(@"ugualli");
                for (int i=0; i<[tornei count]; i++) {
                    NSDateComponents *date3Components = [calendar components:comps
                                                                    fromDate: tornei[i]];
                    NSDate *date3 = [calendar dateFromComponents:date3Components];
                    
                    if ([date1 compare:date3] == NSOrderedSame) {
                       NSLog(@"uno");
                    }
                }
            }
        }
    }
}

@end
