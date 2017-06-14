//
//  NoteDecsVc.m
//  orataro
//
//  Created by MAC008 on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "NoteDecsVc.h"
#import "Global.h"

@interface NoteDecsVc ()

@end

@implementation NoteDecsVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_viewUserBorder.layer setCornerRadius:40];
    [_viewUserBorder.layer setBorderWidth:1];
    [_viewUserBorder.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
    
    _imgUser.layer.cornerRadius = 35.0;
    _imgUser.clipsToBounds = YES;

    // Do any additional setup after loading the view.
    [self setSelectedValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSelectedValue
{
    NSString *NoteTitle=[self.dicSelectNotes objectForKey:@"NoteTitle"];
    NSString *NoteDetails=[self.dicSelectNotes objectForKey:@"NoteDetails"];
    NSString *DressCode=[self.dicSelectNotes objectForKey:@"DressCode"];
    NSString *ActionStartDate=[self.dicSelectNotes objectForKey:@"ActionStartDate"];
    NSString *ActionEndDate=[self.dicSelectNotes objectForKey:@"ActionEndDate"];
    
    _lblTitle.text=[NoteTitle capitalizedString];
    _lblDesc.text=[NoteDetails capitalizedString];
    _lblDressCode.text=[DressCode capitalizedString];
    
    ActionStartDate=[Utility convertMiliSecondtoDate:@"dd/MM/yyyy" date:ActionStartDate];
    ActionEndDate=[Utility convertMiliSecondtoDate:@"dd/MM/yyyy" date:ActionEndDate];
    
    _lblStartDate.text=ActionStartDate;
    _lblEndDate.text=ActionEndDate;
    
    NSString *UserName=[self.dicSelectNotes objectForKey:@"UserName"];
    _lblUserName.text=UserName;
    
    if ([Utility isInterNetConnectionIsActive] == true)
    {
        NSString *strURLForHomeWork=[NSString stringWithFormat:@"%@",[self.dicSelectNotes objectForKey:@"Photo"]];
        if(![strURLForHomeWork isKindOfClass:[NSNull class]] && ![strURLForHomeWork isEqual:@"<null>"])
        {
            strURLForHomeWork=[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[self.dicSelectNotes objectForKey:@"Photo"]];
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
                                       self.imgNote.image = [UIImage imageWithData:imageData];
                                   }
                                   else
                                   {
                                       self.imgNote.image = [UIImage imageNamed:@"no_img"];
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
        NSString *strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@",[self.dicSelectNotes objectForKey:@"ProfilePicture"]];
        
        if(![strURLForTeacherProfilePicture isKindOfClass:[NSNull class]])
        {
            strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[self.dicSelectNotes objectForKey:@"ProfilePicture"]];
            
            NSMutableDictionary *dic = [Utility getCurrentUserDetail];
            
             strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[dic objectForKey:@"ProfilePicture"]];
            
            [ProgressHUB showHUDAddedTo:self.view];
            
          //  [NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[dic objectForKey:@"ProfilePicture"]];
            
            NSURL *imageURL = [NSURL URLWithString:strURLForTeacherProfilePicture];
            
            [_imgUser sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"dash_profile"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
            {
                
                [ProgressHUB hideenHUDAddedTo:self.view];
                _imgUser.image = image;
                               
            }];
            
//            [_imgUser sd_setImageWithURL:imageURL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
//             {
//                
//             }];
            
           /* dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
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
                           });*/
        }
    }
    
}

#pragma mark - button action

- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
