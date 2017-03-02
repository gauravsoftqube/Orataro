//
//  CreateReminderVc.m
//  orataro
//
//  Created by MAC008 on 21/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CreateReminderVc.h"
#import "REFrostedViewController.h"
#import "ReminderVc.h"

@interface CreateReminderVc ()
{
int c2;
}
@end

@implementation CreateReminderVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _aCalenderView.layer.cornerRadius = 50.0;
    _aCalenderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _aCalenderView.layer.borderWidth = 2.0;
    
    
    _aView1.layer.cornerRadius = 30.0;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

- (IBAction)MenuBtnClicked:(id)sender
{
     if (c2==0)
    {
        self.frostedViewController.direction = REFrostedViewControllerDirectionRight;
        self.frostedViewController.panGestureEnabled = NO;
        [self.frostedViewController presentMenuViewController];
        c2=1;
    }
    else
    {
        [self.frostedViewController hideMenuViewController];
        self.frostedViewController.panGestureEnabled = NO;
        c2 =0;
    }
}
- (IBAction)AddBtnClicked:(UIButton *)sender
{
    ReminderVc *r = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ReminderVc"];
    [self.navigationController pushViewController:r animated:YES];
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
