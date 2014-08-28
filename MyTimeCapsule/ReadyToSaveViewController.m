//
//  ReadyToSaveViewController.m
//  MyTimeCapsule
//
//  Created by Nicolas Semenas on 26/08/14.
//  Copyright (c) 2014 Nicolas Semenas. All rights reserved.
//

#import "ReadyToSaveViewController.h"

@interface ReadyToSaveViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageButton;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;


@end

@implementation ReadyToSaveViewController

- (IBAction)onSave:(id)sender {
    [self saveToParse];
}


-(void) saveToParse {
    
    PFObject *message = [PFObject objectWithClassName:@"Message"];
    message[@"body"] = self.messageBody;
    
        PFFile *imageFile = [PFFile fileWithName:@"messagePhoto" data:self.messageImage];
        message[@"media"] = imageFile;

    
    [self showSpinner];
    
    [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (!error) {
        
        [self.spinner removeFromSuperview];
        [self performSegueWithIdentifier:@"doneSegue" sender:self];

        // NSString *successMsg = [NSString stringWithFormat:@"Welcome user %@ !. Now try login with your username and password",self.usernameField.text];
        // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
        //                                                            message:successMsg
        //                                                           delegate:self
        //                                                  cancelButtonTitle:@"Cool!"
        //                                                  otherButtonTitles:nil];
        // [alert show];
        
    } else {
        [self.spinner removeFromSuperview];
//        NSString *errorString = [error userInfo][@"error"];
//        NSString *errorMsg = [NSString stringWithFormat:@"%@",errorString];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something went wrong!"
//                                                        message:errorMsg
//                                                       delegate:nil
//                                              cancelButtonTitle:@"Cancel"
//                                              otherButtonTitles:nil];
//        [alert show];
    }
    }];
    
}



-(void) showSpinner{
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.spinner.hidesWhenStopped = YES;
    
    [self.spinner.layer setBackgroundColor:[[UIColor colorWithWhite: 0.0 alpha:1.0] CGColor]];
    CGPoint center = self.view.center;
    center.y = center.y + 25;
    self.spinner.center = center;
    
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
}




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
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [self.imageButton setUserInteractionEnabled:YES];
    [self.imageButton addGestureRecognizer:singleTap];
    
}

-(void)tapDetected{
    
    [self saveToParse];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//#pragma mark - Navigation
//
//
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    
//    if ([[segue identifier] isEqualToString:@"doneSegue"])
//        
//        [[segue destinationViewController] setMessageBody:self.messageBody];
//    [[segue destinationViewController] setMessageImage:self.image];
//    
//}


@end
