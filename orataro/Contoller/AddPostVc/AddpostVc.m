//
//  AddpostVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 30/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AddpostVc.h"
#import "SWRevealViewController.h"
#import "WallVc.h"
#import "RightVc.h"

@interface AddpostVc ()

@end

@implementation AddpostVc
@synthesize aView1Width,aView2Width,aView3Width,PostImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [aView1Width setConstant:self.view.frame.size.width/3];
    [aView2Width setConstant:self.view.frame.size.width/3];
    [aView3Width setConstant:self.view.frame.size.width/3];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

- (IBAction)BackBtnClicked:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // here you need to create storyboard ID of perticular view where you need to navigate your app
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"WallVc"];
    UIViewController *vc1 = [mainStoryboard instantiateViewControllerWithIdentifier:@"RightVc"];
    [self.revealViewController setFrontViewController:vc animated:YES];
    [self.revealViewController setRightViewController:vc1 animated:YES];
    [self.navigationController popToViewController:self.revealViewController animated:YES];
}

- (IBAction)SaveBtnClicked:(UIButton *)sender
{
}

- (IBAction)AddPhotoBtnClicked:(id)sender
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Add Photo!" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Liabrary", nil];
    
    [action showInView:self.view];
}
#pragma mark - ActionSheet delegates

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex == 0 )
    {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
            pickerView.allowsEditing = YES;
            pickerView.delegate = self;
            pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:pickerView animated:true];
        }
        
    }
    else if( buttonIndex == 1)
    {
        
        UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
        pickerView.allowsEditing = YES;
        pickerView.delegate = self;
        [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentModalViewController:pickerView animated:YES];
        
    }
}

#pragma mark - PickerDelegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
  //  [self dismissModalViewControllerAnimated:true];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
    
    PostImageView.image = img;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
