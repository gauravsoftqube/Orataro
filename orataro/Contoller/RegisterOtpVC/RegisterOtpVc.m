//
//  RegisterOtpVc.m
//  orataro
//
//  Created by MAC008 on 20/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "RegisterOtpVc.h"
#import "Global.h"
#import "WallVc.h"
#import "AppDelegate.h"

@interface RegisterOtpVc ()
{
    AppDelegate *app;
}
@end

@implementation RegisterOtpVc
@synthesize hideShowBtn,aOtpTextfield,aPasswordTextField,BackBtn;
int show =0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    BackBtn.transform=CGAffineTransformMakeRotation(M_PI / -4);
    
    //show_pass
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

- (IBAction)LoginBtnClicked:(id)sender
{
    //WallVc
   // WallVc *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
   // [self.navigationController pushViewController:wc animated:YES];
    
    WallVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
   // [self.revealViewController pushFrontViewController:vc animated:YES];
    
    vc.checkscreen = @"FromLogin";
    app.checkview = 0;
    [self performSegueWithIdentifier:@"ShowWall" sender:self];
}

- (IBAction)hidePaswordBtnclicked:(id)sender
{
    if (show == 0)
    {
        [hideShowBtn setBackgroundImage:[UIImage imageNamed:@"show_pass"] forState:UIControlStateNormal];
        aPasswordTextField.secureTextEntry = NO;
        show =1;
    }
    else
    {
         [hideShowBtn setBackgroundImage:[UIImage imageNamed:@"hide_pass"] forState:UIControlStateNormal];
        aPasswordTextField.secureTextEntry = YES;
        show =0;
    }
}
- (IBAction)BackbtnClicked:(id)sender {
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
