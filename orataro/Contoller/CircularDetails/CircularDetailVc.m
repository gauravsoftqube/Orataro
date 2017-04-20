//
//  CircularDetailVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 31/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CircularDetailVc.h"
#import "Global.h"

@interface CircularDetailVc ()

@end

@implementation CircularDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [_viewUserBorder.layer setCornerRadius:40];
    [_viewUserBorder.layer setBorderWidth:1];
    [_viewUserBorder.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
    
    
    [_imgUser.layer setCornerRadius:35];
    _imgUser.clipsToBounds=YES;
    
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)commonData
{
    [self.lblTitle setText:[NSString stringWithFormat:@"%@",[[self.dicSelect_Circular objectForKey:@"CircularTitle"] capitalizedString]]];
    [self.lblDetail setText:[NSString stringWithFormat:@"%@",[[self.dicSelect_Circular objectForKey:@"CircularDetails"] capitalizedString]]];
    [self.lblUserName setText:[NSString stringWithFormat:@"%@",[[self.dicSelect_Circular objectForKey:@"TeacherName"] capitalizedString]]];

    if ([Utility isInterNetConnectionIsActive] == true)
    {
        NSString *strURLForHomeWork=[NSString stringWithFormat:@"%@",[self.dicSelect_Circular objectForKey:@"Photo"]];
        if(![strURLForHomeWork isKindOfClass:[NSNull class]] && ![strURLForHomeWork isEqual:@"<null>"])
        {
            strURLForHomeWork=[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[self.dicSelect_Circular objectForKey:@"Photo"]];
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
                                       self.imgCircular.image = [UIImage imageWithData:imageData];
                                   }
                                   else
                                   {
                                       self.imgCircular.image = [UIImage imageNamed:@"no_img"];
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

-(void)getUserImage
{
    if ([Utility isInterNetConnectionIsActive] == true)
    {
        NSString *strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@",[self.dicSelect_Circular objectForKey:@"ProfilePic"]];
        if(![strURLForTeacherProfilePicture isKindOfClass:[NSNull class]])
        {
            strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[self.dicSelect_Circular objectForKey:@"ProfilePic"]];
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

#pragma mark - UIButton Action

- (IBAction)BackbtnClicked:(id)sender
{
    
}

- (IBAction)BackBtnClicked:(id)sender
{
}

- (IBAction)BackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
