//
//  ReminderVc.m
//  orataro
//
//  Created by MAC008 on 09/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ReminderVc.h"

@interface ReminderVc ()

@end

@implementation ReminderVc
@synthesize aTitleTextfield,aCancelTextField,aEnddateTextfield,aImportantTextField,aSatrtDateTextField,aDescriptionTextview;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
     aTitleTextfield.leftView = paddingView;
     aTitleTextfield.leftViewMode = UITextFieldViewModeAlways;
     
     UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
     aCancelTextField.leftView = paddingView1;
     aCancelTextField.leftViewMode = UITextFieldViewModeAlways;
     
     UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
     aEnddateTextfield.leftView = paddingView2;
     aEnddateTextfield.leftViewMode = UITextFieldViewModeAlways;
     
     UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
     aImportantTextField.leftView = paddingView3;
     aImportantTextField.leftViewMode = UITextFieldViewModeAlways;
     
     UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
     aSatrtDateTextField.leftView = paddingView4;
     aSatrtDateTextField.leftViewMode = UITextFieldViewModeAlways;
     
     aDescriptionTextview.textContainerInset = UIEdgeInsetsMake(10, 17, 0, 0);
     
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textview delegate

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (aDescriptionTextview.text.length == 0)
    {
        aDescriptionTextview.text = @"";
        aDescriptionTextview.textColor = [UIColor blackColor];
    }
    if ([aDescriptionTextview.text isEqualToString:@"Description"])
    {
        aDescriptionTextview.text = @"";
        aDescriptionTextview.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(aDescriptionTextview.text.length == 0){
        aDescriptionTextview.textColor = [UIColor lightGrayColor];
        aDescriptionTextview.text = @"Description";
        [aDescriptionTextview resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(aDescriptionTextview.text.length == 0){
            aDescriptionTextview.textColor = [UIColor lightGrayColor];
            aDescriptionTextview.text = @"Desciption";
            [aDescriptionTextview resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
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
