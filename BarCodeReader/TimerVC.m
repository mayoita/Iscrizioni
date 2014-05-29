#import "TimerVC.h"

@implementation TimerVC

@synthesize counterLabel;
@synthesize counterValue;
@synthesize timer;

- (void)viewDidLoad {
    [super viewDidLoad];
	counterValue = 0;
	self.counterLabel.text = [NSString stringWithFormat:@"%d", counterValue];
}

- (void)updateLabel:(id)sender{
	if(counterValue >= MAX_VALUE){
		[self killTimer];
	}
	
	self.counterLabel.text = [NSString stringWithFormat:@"%d", counterValue];
	counterValue++;
}

- (IBAction)startTimer:(id)sender{
	self.counterValue = 0;
	
	[self killTimer];
	timer = [NSTimer scheduledTimerWithTimeInterval:1.0
						target:self 
						selector:@selector(updateLabel:) 
						userInfo:nil 
						repeats:YES ];
	
	[self updateLabel:timer];
}

- (void)killTimer{
	if(timer){
		[timer invalidate];
		timer = nil;
	}
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[self killTimer];
	counterLabel = nil;
}

@end
