//
//  AboutUsVc.m
//  orataro
//
//  Created by MAC008 on 10/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AboutUsVc.h"

#import "Global.h"

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
    
    [self.viewTYPlayer loadWithVideoId:YouTubeVideo_Key];
    
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        self.lblTitleHeader.text=[NSString stringWithFormat:@"About Orataro (%@)",[arr objectAtIndex:0]];
    }else{
        self.lblTitleHeader.text=[NSString stringWithFormat:@"About Orataro"];
    }
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


@end
