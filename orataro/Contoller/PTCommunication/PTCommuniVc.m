//
//  PTCommuniVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "PTCommuniVc.h"

@interface PTCommuniVc ()

@end

@implementation PTCommuniVc
@synthesize aAddBtnouterView,aSearchTextField,noPtCommunLb;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    aAddBtnouterView.layer.cornerRadius = 30.0;
    aAddBtnouterView.layer.masksToBounds = YES;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aSearchTextField.leftView = paddingView;
    aSearchTextField.leftViewMode = UITextFieldViewModeAlways;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

- (IBAction)BackBntClicked:(id)sender
{
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
