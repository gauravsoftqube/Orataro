//
//  RegisterVc.m
//  orataro
//
//  Created by harikrishna patel on 25/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "RegisterVc.h"
#import "AppDelegate.h"
#import "Global.h"

@interface RegisterVc ()

@end

@implementation RegisterVc
@synthesize aPhonenumOuterView,aMobTextField,BAckBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BAckBtn.transform=CGAffineTransformMakeRotation(M_PI / -4);
    
    aPhonenumOuterView.layer.cornerRadius = 1.0;
    aPhonenumOuterView.layer.masksToBounds =  YES;
    aPhonenumOuterView.layer.borderWidth = 2.0;
    aPhonenumOuterView.layer.borderColor =([UIColor colorWithRed:128.0/255.0 green:163.0/255.0 blue:81.0/255.0 alpha:1.0]).CGColor;
    
// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
//    if ([[AppDelegate maindelegate]CheckInternetRechability])
//    {
//        
//    }
//    else
//    {
//        [self GetMyOrder];
//    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

- (IBAction)VerifyBtnClicked:(id)sender
{
    RegisterOtpVc *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"RegisterOtpVc"];
    [self.navigationController pushViewController:wc animated:YES];
}

- (IBAction)BackBtnClicked:(id)sender
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
