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
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([_passVal isEqualToString:@"Homework"])
    {
        [self.lblTitleHeader setText:[NSString stringWithFormat:@"%@",[self.dicSelect_detail objectForKey:@"SubjectName"]]];
        [self.lblTitle setText:[NSString stringWithFormat:@"%@",[self.dicSelect_detail objectForKey:@"Title"]]];
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
                
                [_imgHomework sd_setImageWithURL:[NSURL URLWithString:strURLForHomeWork] placeholderImage:[UIImage imageNamed:@"no_img"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    
                    _imgHomework.image = image;
                    
                    [self getUserImage : @"Homework"];
                    
                }];
                
            }
            else
            {
                _imgHomework.image = [UIImage imageNamed:@"no_img"];
                [self getUserImage : @"Homework"];
            }
        }
    }
    
    if ([_passVal isEqualToString:@"Classwork"])
    {
        [self.lblTitleHeader setText:[[NSString stringWithFormat:@"%@",[self.dicSelect_detail objectForKey:@"SubjectName"]] capitalizedString]];
        [self.lblTitle setText:[[NSString stringWithFormat:@"%@",[self.dicSelect_detail objectForKey:@"ClassWorkTitle"]] capitalizedString]];
        [self.lblGradeDivision setText:[NSString stringWithFormat:@"%@ %@",[self.dicSelect_detail objectForKey:@"GradeName"],[self.dicSelect_detail objectForKey:@"DivisionName"]]];
        [self.lblDetail setText:[[NSString stringWithFormat:@"%@",[self.dicSelect_detail objectForKey:@"ClassWorkDetails"]] capitalizedString]];
        NSString *StartTime=[self.dicSelect_detail objectForKey:@"StartTime"];
        StartTime = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:StartTime];
        
        [self.lblDate setText:[NSString stringWithFormat:@"%@",StartTime]];
        
        [self.lblUserName setText:[NSString stringWithFormat:@"%@",[self.dicSelect_detail objectForKey:@"UserName"]]];
        
        NSLog(@"Data%@",_dicSelect_detail);
        
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            NSString *strURLForHomeWork=[NSString stringWithFormat:@"%@",[self.dicSelect_detail objectForKey:@"Photo"]];
            
            if(![strURLForHomeWork isKindOfClass:[NSNull class]] && ![strURLForHomeWork isEqual:@"<null>"])
            {
                strURLForHomeWork=[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[self.dicSelect_detail objectForKey:@"Photo"]];
                
                [_imgHomework sd_setImageWithURL:[NSURL URLWithString:strURLForHomeWork] placeholderImage:[UIImage imageNamed:@"no_img"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    
                    _imgHomework.image = image;
                    
                    [self getUserImage : @"Classwork"];
                    
                }];
                
                
            }
            else
            {
                _imgHomework.image = [UIImage imageNamed:@"no_img"];
                [self getUserImage : @"Classwork"];
            }
        }
    }
}

-(void)getUserImage : (NSString *)strCheck
{
    if ([Utility isInterNetConnectionIsActive] == true)
    {
        //Homework
        //Classwork
        
        NSLog(@"Dic=%@",_dicSelect_detail);
        
        if ([strCheck isEqualToString:@"Homework"])
        {
            NSString *strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@",[self.dicSelect_detail objectForKey:@"TeacherProfilePicture"]];
            
            if(![strURLForTeacherProfilePicture isKindOfClass:[NSNull class]])
            {
                strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[self.dicSelect_detail objectForKey:@"TeacherProfilePicture"]];
                
                
                [_imgUser sd_setImageWithURL:[NSURL URLWithString:strURLForTeacherProfilePicture] placeholderImage:[UIImage imageNamed:@"no_img"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    
                    _imgUser.image = image;
                }];
                
            }
        }
        else
        {
                NSString *strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@",[self.dicSelect_detail objectForKey:@"ProfilePicture"]];
                if(![strURLForTeacherProfilePicture isKindOfClass:[NSNull class]])
                {
                    strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[self.dicSelect_detail objectForKey:@"ProfilePicture"]];
                    
                    
                    [_imgUser sd_setImageWithURL:[NSURL URLWithString:strURLForTeacherProfilePicture] placeholderImage:[UIImage imageNamed:@"no_img"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                        
                        _imgUser.image = image;
                    }];
                    
                }
        }
    }
}
- (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }
    
    - (IBAction)BackBtn1Clicked:(id)sender
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    @end
