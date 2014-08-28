//
//  AddMediaViewController.m
//  MyTimeCapsule
//
//  Created by Nicolas Semenas on 25/08/14.
//  Copyright (c) 2014 Nicolas Semenas. All rights reserved.
//

#import "AddMediaViewController.h"
#import "ReadyToSaveViewController.h"

@interface AddMediaViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageButton;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;
@property (nonatomic, strong) NSData * image;
@property (nonatomic,strong) UIImagePickerController *picker;

@end

@implementation AddMediaViewController


- (IBAction)onNext:(id)sender {
    
    if (([self.messageBody length] > 0 ) || (self.image != nil) ){
        [self performSegueWithIdentifier:@"readyToSaveSegue" sender:self];
        
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setTabBarColor{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];

}


#pragma mark -- UIImagePickerController Delegates
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //PFObject *feedItem = [PFObject objectWithClassName:@"FeedItem"];
    // [info objectForKey:UIImagePickerControllerOriginalImage];
    self.image = UIImagePNGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage]);
    self.selectedImage.image = [UIImage imageWithData:self.image];
    self.selectedImage.hidden = NO;
    
//    PFFile *imageFile = [PFFile fileWithName:@"feedPhoto" data:imageData];
//    feedItem[@"feedPhoto"] = imageFile;
//    feedItem[@"user"] = [PFUser currentUser].objectId;
//    feedItem[@"description"] = self.photoDescription.text;
//    [feedItem saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (error) {
//            NSLog(@"%@", [error userInfo]);
//        } else {
//            [self dismissViewControllerAnimated:YES completion:nil];
//            self.photoDescription.text = @"";
//        }
//    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    double delayInSeconds = 0.75;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [self performSegueWithIdentifier:@"readyToSaveSegue" sender:self];
//    });
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTabBarColor];
    
    self.picker = [UIImagePickerController new];
    self.picker.delegate = self;
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [self.imageButton setUserInteractionEnabled:YES];
    [self.imageButton addGestureRecognizer:singleTap];
    
}

-(void)tapDetected{
    
[self presentViewController:self.picker animated:YES completion:nil];
}
    


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"readyToSaveSegue"])
        
        [[segue destinationViewController] setMessageBody:self.messageBody];
        [[segue destinationViewController] setMessageImage:self.image];
    
}


@end
