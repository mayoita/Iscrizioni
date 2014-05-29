//
//  CustomAlertViewController.h
//  BarCodeReader
//
//  Created by Massimo Moro on 29/05/14.
//  Copyright (c) 2014 MassimoMoro. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomAlertViewControllerDelegate
-(void)customAlertOK;
-(void)customAlertCancel;
@end
@interface CustomAlertViewController : UIViewController

@property (nonatomic, retain) id<CustomAlertViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *viewMessage;
@property (weak, nonatomic) IBOutlet UILabel *test;
@property (weak, nonatomic) IBOutlet UIButton *understand;


-(void)showCustomAlertInView:(UIView *)targetView withMessage:(NSString *)message;
-(void)removeCustomAlertFromView;
-(void)removeCustomAlertFromViewInstantly;

@end
