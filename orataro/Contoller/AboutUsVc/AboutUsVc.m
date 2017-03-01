//
//  AboutUsVc.m
//  orataro
//
//  Created by MAC008 on 10/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AboutUsVc.h"

@interface AboutUsVc ()

@end

@implementation AboutUsVc
@synthesize aTextview,aTableView,aTableHeaderView,aVideoView,aTextviewHeight;

- (void)viewDidLoad
{
        [super viewDidLoad];
    
        self.automaticallyAdjustsScrollViewInsets = NO;

        [aTextview sizeToFit];
        [aTextview layoutIfNeeded];
    
        CGFloat fixedWidth = aTextview.frame.size.width;
    
        CGSize newSize = [aTextview sizeThatFits:CGSizeMake(fixedWidth, aTextview.contentSize.height)];
    
        CGRect newFrame = aTextview.frame;
        newFrame.size = CGSizeMake(fixedWidth, newSize.height);
    
        aTextview.frame = newFrame;
    
        CGRect newFrame1 = aTableHeaderView.frame;
        newFrame1.size.height = aVideoView.frame.origin.y + aVideoView.frame.size.height+aTextview.frame.origin.y+aTextview.contentSize.height;
    
        aTableHeaderView.frame = newFrame1;
    
        aTableView.tableHeaderView = aTableHeaderView;

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [aTextview setContentOffset:CGPointZero animated:NO];
}

#pragma mark - button action

- (IBAction)BackBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
