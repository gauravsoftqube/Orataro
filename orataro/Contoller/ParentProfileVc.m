//
//  ParentProfileVc.m
//  orataro
//
//  Created by MAC008 on 05/05/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ParentProfileVc.h"
#import "Global.h"

@interface ParentProfileVc ()

@end

@implementation ParentProfileVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrAddFourView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, [UIScreen mainScreen].bounds.size.height-64);
    
    [self oneView];
    [self twoView];
    [self threeView];
    [self fourView];
    
    _scrAddFourView.pagingEnabled = YES;
    
    //checkboxunselected
    
    [self segmentData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)segmentData
{
//    CGRect basketTopFrame = cell.viewLine.frame;
//    basketTopFrame.origin.x = 0;
//    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{ cell.viewLine.frame = basketTopFrame; } completion:^(BOOL finished){ }];
}


-(void)oneView
{
    CGFloat originWidth = [[UIScreen mainScreen]bounds].size.width;
    CGFloat originHeight = [[UIScreen mainScreen]bounds].size.height-110;
    _viewFirst.translatesAutoresizingMaskIntoConstraints=YES;
    _viewFirst.frame=CGRectMake(0,0,originWidth, originHeight);
    _scrAddFourView.delegate = self;
    [_scrAddFourView addSubview:_viewFirst];
}
-(void)twoView
{
    CGFloat originWidth = [[UIScreen mainScreen]bounds].size.width;
    CGFloat originHeight = [[UIScreen mainScreen]bounds].size.height-110;
    _viewSecond.translatesAutoresizingMaskIntoConstraints=YES;
    _viewSecond.frame=CGRectMake(originWidth,0,originWidth, originHeight);
    _scrAddFourView.delegate = self;
    [_scrAddFourView addSubview:_viewSecond];
}

-(void)threeView
{
    CGFloat originWidth = [[UIScreen mainScreen]bounds].size.width;
    CGFloat originHeight = [[UIScreen mainScreen]bounds].size.height-110;
    _viewThird.translatesAutoresizingMaskIntoConstraints=YES;
    _viewThird.frame=CGRectMake(originWidth*2,0,originWidth, originHeight);
    // NSLog(@"VIEW2%f",originWidth*2);
    _scrAddFourView.delegate = self;
    [_scrAddFourView addSubview:_viewThird];
}

-(void)fourView
{
    CGFloat originWidth = [[UIScreen mainScreen]bounds].size.width;
    CGFloat originHeight = [[UIScreen mainScreen]bounds].size.height-110;
    _viewFourth.translatesAutoresizingMaskIntoConstraints=YES;
    _viewFourth.frame=CGRectMake(originWidth*3,0,originWidth, originHeight);
    _scrAddFourView.delegate = self;
    [_scrAddFourView addSubview:_viewFourth];
}


#pragma mark - UIScrollViewDelegate

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    CGFloat pageWidth = scrollView.frame.size.width;
//    NSInteger page = scrollView.contentOffset.x / pageWidth;
//    
//    NSLog(@"Page=%ld",(long)page);
//   // [self.segmentedControl4 setSelectedSegmentIndex:page animated:YES];
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    //CGFloat pageFraction = _scrAddFourView.contentOffset.x / pageWidth;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
  //  NSLog(@"Page=%ld",(long)page);
    
    if(page == 0)
    {
    }
    if(page == 1)
    {
    }
    if(page == 2)
    {
    }
    if(page == 3)
    {
    }

}



#pragma mark - button action


- (IBAction)btnBackClicked:(id)sender
{
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[MyProfileVc class]])
        {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
    
}

- (IBAction)btnStudentProfileClicked:(id)sender {
}

- (IBAction)btnFatherProfileClicked:(id)sender {
}

- (IBAction)btnMotherProfileClicked:(id)sender {
}

- (IBAction)btnGuardianClicked:(id)sender {
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
