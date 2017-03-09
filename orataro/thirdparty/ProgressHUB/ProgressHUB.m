//
//  ProgressHUB.m
//  ProgressHUB
//
//  Created by Softqube on 07/03/17.
//  Copyright © 2017 me. All rights reserved.
//

#import "ProgressHUB.h"

@interface ProgressHUB ()

@end

@implementation ProgressHUB

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSArray *imageNames = @[@"loader_01.png", @"loader_02.png", @"loader_03.png", @"loader_04.png",@"loader_05.png", @"loader_06.png", @"loader_07.png", @"loader_08.png",@"loader_09.png", @"loader_10.png", @"loader_11.png", @"loader_12.png"];
//    
//    NSMutableArray *images = [[NSMutableArray alloc] init];
//    for (int i = 0; i < imageNames.count; i++)
//    {
//        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
//    }
//    
//    // Normal Animation
//    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.origin.y+100,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    
//    view1.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5f];
//    
//    UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 50, [UIScreen mainScreen].bounds.size.height/2 - 40, 100, 80)];
//    animationImageView.animationImages = images;
//    animationImageView.animationDuration = 2.0;
//    
//    //animationImageView.backgroundColor=[UIColor whiteColor];
//    //animationImageView.layer.cornerRadius=8;
//    
//    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 55, [UIScreen mainScreen].bounds.size.height/2 - 45, 110, 90)];
//    
//    view2.backgroundColor=[UIColor whiteColor];
//    view2.layer.cornerRadius=8;
//   
//    [view1 addSubview:view2];
//    [view1 addSubview:animationImageView];
//    
//    [self.view addSubview:view1];
//    [animationImageView startAnimating];

}

+(UIView *)showHUDAddedTo:(UIView *)view
{
    UIView *viewAddSubView = [view viewWithTag:1010];
    if(viewAddSubView == nil)
    {
        [view endEditing:YES];
        NSArray *imageNames = @[@"loader_01.png", @"loader_02.png", @"loader_03.png", @"loader_04.png",@"loader_05.png", @"loader_06.png", @"loader_07.png", @"loader_08.png",@"loader_09.png", @"loader_10.png", @"loader_11.png", @"loader_12.png"];
        
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (int i = 0; i < imageNames.count; i++)
        {
            [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
        }
        
        // Normal Animation
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.origin.y,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        view1.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5f];
        view1.tag=1010;
        
        UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 50, [UIScreen mainScreen].bounds.size.height/2 - 40, 100, 80)];
        animationImageView.animationImages = images;
        animationImageView.animationDuration = 2.0;
        
        
        UIView *view2=[[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 55, [UIScreen mainScreen].bounds.size.height/2 - 45, 110, 90)];
        
        view2.backgroundColor=[UIColor whiteColor];
        view2.layer.cornerRadius=8;
        
        [view1 addSubview:view2];
        [view1 addSubview:animationImageView];
        
        [view addSubview:view1];
        [animationImageView startAnimating];
    }
    return view;
}

+(UIView *)hideenHUDAddedTo:(UIView *)view
{
    UIView *viewAddSubView = [view viewWithTag:1010];
    [viewAddSubView removeFromSuperview];
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
