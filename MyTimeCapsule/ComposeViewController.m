//
//  NewMessageViewController.m
//  MyTimeCapsule
//
//  Created by Nicolas Semenas on 25/08/14.
//  Copyright (c) 2014 Nicolas Semenas. All rights reserved.
//

#import "ComposeViewController.h"
#import "AddMediaViewController.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *messageBody;

@property CGPoint textViewOrigin;
@property CGSize textViewSize;

@end

@implementation ComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTabBarColor];
    
    self.textView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"ResetMessage"
                                               object:nil];

    
}



- (void) receiveTestNotification:(NSNotification *) notification
{

    
    if ([[notification name] isEqualToString:@"ResetMessage"])
      self.messageBody.text = @"";
}



-(void)reset{
    self.messageBody.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textView endEditing:YES];
}






#pragma mark - Helper Methods

-(void)setTabBarColor{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
}


#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"addMediaSegue"])
        
        [[segue destinationViewController] setMessageBody:self.messageBody.text];
        [self.textView endEditing:YES];

    
}

#pragma mark - TUIextView Delegate

- (void)textViewDidChangeSelection:(UITextView *)textView {
    [textView scrollRangeToVisible:textView.selectedRange];
}



- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    self.textViewOrigin = self.textView.frame.origin;
    self.textViewSize = self.textView.frame.size;
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationTransitionNone | UIViewAnimationOptionCurveLinear animations:^(void){
        
        [self.textView setFrame:CGRectMake(self.textViewOrigin.x, self.textViewOrigin.y, self.textViewSize.width, self.textViewSize.height-90)];
    }
                     completion:^(BOOL finished){
                     }];
    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationTransitionNone | UIViewAnimationOptionCurveLinear animations:^(void){
        
        [self.textView setFrame:CGRectMake(self.textViewOrigin.x, self.textViewOrigin.y, self.textViewSize.width, self.textViewSize.height)];
    }
                     completion:^(BOOL finished){
                     }];
    
}


@end
