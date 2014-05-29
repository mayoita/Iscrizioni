#import <UIKit/UIKit.h>

@interface TimerVC : UIViewController 

#define MAX_VALUE 10

@property (assign, nonatomic) IBOutlet UILabel *counterLabel;
@property int counterValue;
@property (copy) NSTimer *timer;

- (IBAction)startTimer:(id)sender;
- (void)killTimer;
- (void)updateLabel:(id)sender;

@end
