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
            NSArray *record=@[key,[tornei lastObject],@0,@0];
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
                NSArray *record=@[key,[tornei lastObject],[NSNumber numberWithInt:x],[NSNumber numberWithInt:y]];
                [torneiPrecedenti addObject:record];
            } else {
                NSArray *record=@[key,[tornei lastObject],[NSNumber numberWithInt:x],[NSNumber numberWithInt:y]];
                [torneiPrecedentiEOdierni addObject:record];
            }
        }
        }
    }
    NSLog(@"Fine");
}

@end
