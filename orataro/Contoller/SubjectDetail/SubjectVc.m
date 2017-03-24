//
//  SubjectVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 31/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "SubjectVc.h"
#import "Global.h"

@interface SubjectVc ()

@end

@implementation SubjectVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [_vewUserImage.layer setCornerRadius:40];
    [_vewUserImage.layer setBorderWidth:1];
    [_vewUserImage.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
    
    
    [_imgUser.layer setCornerRadius:35];
    _imgUser.clipsToBounds=YES;
    // Do any additional setup after loading the view.
}



-(void)viewWillAppear:(BOOL)animated
{
    if ([_passVal isEqualToString:@"Homework"])
    {
        [self.lblTitle setText:[NSString stringWithFormat:@"%@",[self.dicSelect_detail objectForKey:@"SubjectName"]]];
        [self.lblGradeDivision setText:[NSString stringWithFormat:@"%@ %@",[self.dicSelect_detail objectForKey:@"GradeName"],[self.dicSelect_detail objectForKey:@"DivisionName"]]];
        [self.lblDetail setText:[NSString stringWithFormat:@"%@",[self.dicSelect_detail objectForKey:@"HomeWorksDetails"]]];
        [self.lblDate setText:[NSString stringWithFormat:@"%@",[self.dicSelect_detail objectForKey:@"DateOfHomeWork"]]];
        
        [self.lblUserName setText:[NSString stringWithFormat:@"%@",[self.dicSelect_detail objectForKey:@"TeacherName"]]];
        
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            NSString *strURLForHomeWork=[NSString stringWithFormat:@"%@",[self.dicSelect_detail objectForKey:@"Photo"]];
            if(![strURLForHomeWork isKindOfClass:[NSNull class]] && ![strURLForHomeWork isEqual:@"<null>"])
            {
                strURLForHomeWork=[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[self.dicSelect_detail objectForKey:@"Photo"]];
                [ProgressHUB showHUDAddedTo:self.view];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                               ^{
                                   NSURL *imageURL = [NSURL URLWithString:strURLForHomeWork];
                                   NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                                   dispatch_sync(dispatch_get_main_queue(), ^{
                                       [ProgressHUB hideenHUDAddedTo:self.view];
                                       
                                       UIImage *img = [UIImage imageWithData:imageData];
                                       if (img != nil)
                                       {
                                           self.imgHomework.image = [UIImage imageWithData:imageData];
                                       }
                                       else
                                       {
                                           self.imgHomework.image = [UIImage imageNamed:@"no_img"];
                                       }
                                       
                                       [self getUserImage];
                                       
                                   });
                               });
            }
            else
            {
                [self getUserImage];
            }
        }
        
        
    }
    if ([_passVal isEqualToString:@"Classwork"])
    {
        
    }
}

-(void)getUserImage
{
    if ([Utility isInterNetConnectionIsActive] == true)
    {
        NSString *strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@",[self.dicSelect_detail objectForKey:@"TeacherProfilePicture"]];
        if(![strURLForTeacherProfilePicture isKindOfClass:[NSNull class]])
        {
            strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[self.dicSelect_detail objectForKey:@"TeacherProfilePicture"]];
            [ProgressHUB showHUDAddedTo:self.view];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                           ^{
                               
                               NSURL *imageURL = [NSURL URLWithString:strURLForTeacherProfilePicture];
                               NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                               
                               //This is your completion handler
                               dispatch_sync(dispatch_get_main_queue(), ^{
                                   [ProgressHUB hideenHUDAddedTo:self.view];
                                    UIImage *img = [UIImage imageWithData:imageData];
                                   if (img != nil)
                                   {
                                       self.imgUser.image = [UIImage imageWithData:imageData];
                                   }
                                   else
                                   {
                                       self.imgUser.image = [UIImage imageNamed:@"dash_profile"];
                                   }
                                   
                               });
                           });
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)BackBtn1Clicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
