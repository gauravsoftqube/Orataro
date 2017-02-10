//
//  PollVc.m
//  orataro
//
//  Created by MAC008 on 08/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "PollVc.h"

@interface PollVc ()

@end

@implementation PollVc
@synthesize aFirstImage,aBottomView1,aBottomView2,aSecondImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //pollico
    //voting_shoe
    //voting
    //pollico_shiw
    
    aBottomView1.hidden = NO;
    [aFirstImage setImage:[UIImage imageNamed:@"pollico_shiw"]];
    
    aBottomView2.hidden = YES;
    [aSecondImage setImage:[UIImage imageNamed:@"voting"]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

- (IBAction)aFirstBtnClicked:(id)sender
{
    aBottomView1.hidden = NO;
    [aFirstImage setImage:[UIImage imageNamed:@"pollico_shiw"]];
    
    aBottomView2.hidden = YES;
    [aSecondImage setImage:[UIImage imageNamed:@"voting"]];
}
- (IBAction)aSeconBtnClicked:(id)sender
{
    aBottomView1.hidden = YES;
    [aFirstImage setImage:[UIImage imageNamed:@"pollico"]];
    
    aBottomView2.hidden = NO;
    [aSecondImage setImage:[UIImage imageNamed:@"voting_shoe"]];
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
