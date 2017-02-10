//
//  AddCircularVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 30/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AddCircularVc.h"
#import "RightVc.h"
#import "SWRevealViewController.h"
#import "SAMTextView.h"

@interface AddCircularVc ()
{
    
}
@end

@implementation AddCircularVc
@synthesize aViewHeight,aScrollview,aViewwidth,aDescLb,aDescTextView,aTitleTextfield,selectTypeTextfield,standardTextfield,endDateTextfield,PhotoBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // [aScrollview setContentSize:CGSizeMake(self.view.frame.size.width, 2000)];
    [aViewHeight setConstant:750];
    [aViewwidth setConstant:self.view.frame.size.width];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    selectTypeTextfield.leftView = paddingView;
    selectTypeTextfield.leftViewMode = UITextFieldViewModeAlways;

    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aTitleTextfield.leftView = paddingView1;
    aTitleTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    standardTextfield.leftView = paddingView2;
    standardTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    endDateTextfield.leftView = paddingView3;
    endDateTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    aDescTextView.textContainerInset = UIEdgeInsetsMake(10, 20, 0, 0);
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textview delegate

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (aDescTextView.text.length == 0)
    {
        aDescTextView.text = @"";
        aDescTextView.textColor = [UIColor blackColor];
    }
    if ([aDescTextView.text isEqualToString:@"Description"])
    {
        aDescTextView.text = @"";
        aDescTextView.textColor = [UIColor blackColor];
    }

    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(aDescTextView.text.length == 0){
        aDescTextView.textColor = [UIColor lightGrayColor];
        aDescTextView.text = @"Description";
        [aDescTextView resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(aDescTextView.text.length == 0){
            aDescTextView.textColor = [UIColor lightGrayColor];
            aDescTextView.text = @"Desciption";
            [aDescTextView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
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
- (IBAction)addPhotoBtnClicked:(id)sender
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
    
    [PhotoBtn setBackgroundImage:img forState:UIControlStateNormal];
    
   // PostImageView.image = img;
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
