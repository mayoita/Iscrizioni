//
//  BCRFinishViewController.m
//  BarCodeReader
//
//  Created by Massimo Moro on 16/05/14.
//  Copyright (c) 2014 MassimoMoro. All rights reserved.
//

#import "BCRFinishViewController.h"

@interface BCRFinishViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation BCRFinishViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.label.lineBreakMode=NSLineBreakByWordWrapping;
    self.label.numberOfLines=0;
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    paragrapStyle.alignment = NSTextAlignmentCenter;
    self.label.attributedText=[[NSAttributedString alloc]
                              initWithString:@"Le iscrizioni sono chiuse"
                              attributes:@{
                                           NSFontAttributeName:[UIFont fontWithName:@"CooperBT-Bold" size:55.0],
                                           NSForegroundColorAttributeName:[UIColor colorWithRed:0.902 green:0.676 blue:0.135 alpha:1.000],
                                           NSStrokeWidthAttributeName: [NSNumber numberWithFloat:-3.0],
                                           NSStrokeColorAttributeName:[UIColor colorWithRed:0.642 green:0.021 blue:0.082 alpha:1.000],
                                           NSParagraphStyleAttributeName: paragrapStyle
                                           
                                           }
                              ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
