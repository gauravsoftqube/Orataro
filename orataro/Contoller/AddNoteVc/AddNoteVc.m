//
//  AddNoteVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AddNoteVc.h"

@interface AddNoteVc ()

@end

@implementation AddNoteVc
@synthesize aPhoto,aDescTextview,aTitleTextfield,aStandardTextfield,aEnddateTextfield,aShortDescTextfield,aStartdateTextfield,aViewWidth,aViewHeight,aScrollview;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [aScrollview setContentSize:CGSizeMake(self.view.frame.size.width, 2000)];
    [aViewHeight setConstant:750];
    [aViewWidth setConstant:self.view.frame.size.width];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aTitleTextfield.leftView = paddingView;
    aTitleTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aStandardTextfield.leftView = paddingView1;
    aStandardTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aEnddateTextfield.leftView = paddingView2;
    aEnddateTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aShortDescTextfield.leftView = paddingView3;
    aShortDescTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aStartdateTextfield.leftView = paddingView4;
    aStartdateTextfield.leftViewMode = UITextFieldViewModeAlways;

    aDescTextview.textContainerInset = UIEdgeInsetsMake(10, 17, 0, 0);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - textview delegate

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (aDescTextview.text.length == 0)
    {
        aDescTextview.text = @"";
        aDescTextview.textColor = [UIColor blackColor];
    }
    if ([aDescTextview.text isEqualToString:@"Description"])
    {
        aDescTextview.text = @"";
        aDescTextview.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(aDescTextview.text.length == 0){
        aDescTextview.textColor = [UIColor lightGrayColor];
        aDescTextview.text = @"Description";
        [aDescTextview resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(aDescTextview.text.length == 0){
            aDescTextview.textColor = [UIColor lightGrayColor];
            aDescTextview.text = @"Desciption";
            [aDescTextview resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}


#pragma mark - button action

- (IBAction)BackBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)SelectPhotoBtnClicked:(id)sender
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
    
    [aPhoto setBackgroundImage:img forState:UIControlStateNormal];
    
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
