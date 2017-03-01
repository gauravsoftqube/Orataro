//
//  ProfilePhotoShowVc.m
//  orataro
//
//  Created by MAC008 on 27/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfilePhotoShowVc.h"

@interface ProfilePhotoShowVc ()

@end

@implementation ProfilePhotoShowVc
@synthesize aInnerView,aOuterView,saveBtn;
int d =0;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [aInnerView.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
    [aInnerView.layer setBorderWidth:2];
    
    aOuterView.hidden = YES;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SaveBtnClicked:(UIButton *)sender
{
    if (d == 0)
    {
        aOuterView.hidden = NO;
        [self.view bringSubviewToFront:aOuterView];
        d =1;
    }
    else
    {
        aOuterView.hidden = YES;
        d =0;
    }
    
}
- (IBAction)OnSaveClicked:(UIButton *)sender
{
    aOuterView.hidden = YES;
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
