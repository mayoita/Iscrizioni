//
//  BCRViewController.h
//  BarCodeReader
//
//  Created by Massimo Moro on 09/05/14.
//  Copyright (c) 2014 MassimoMoro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertViewController.h"
@interface BCRViewController : UIViewController<ZBarReaderDelegate,UIAlertViewDelegate,CustomAlertViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *resultText;
@property (weak, nonatomic) IBOutlet UIImageView *resultImage;
@property(strong,nonatomic)NSMutableDictionary *iscrizioni;
- (IBAction) scanButtonTapped;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@end
