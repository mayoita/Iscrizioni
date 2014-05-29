//
//  CustomAlertViewController.m
//  BarCodeReader
//
//  Created by Massimo Moro on 29/05/14.
//  Copyright (c) 2014 MassimoMoro. All rights reserved.
//

#import "CustomAlertViewController.h"

#define ANIMATION_DURATION  0.25
@interface CustomAlertViewController ()

@end

@implementation CustomAlertViewController
@synthesize test=_test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:0.0]];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showCustomAlertInView:(UIView *)targetView withMessage:(NSString *)message{

 
    [targetView addSubview:self.view];
    
    [self.test setText:message];
}
- (IBAction)understand:(id)sender {
    NSLog(@"a");
}

-(void)removeCustomAlertFromView{
    // Animate the message view dissapearing.
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [self.viewMessage setFrame:CGRectMake(0.0, -self.viewMessage.frame.size.height, self.viewMessage.frame.size.width, self.viewMessage.frame.size.height)];
    [UIView commitAnimations];
    
    // Remove the main view from the super view as well after the animation is finished.
    [self.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:ANIMATION_DURATION];
}

-(void)removeCustomAlertFromViewInstantly{
    [self.view removeFromSuperview];
}


@end
