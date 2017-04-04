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

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    _lblTitle.text=NoteTitle;
    _lblDesc.text=NoteDetails;
    _lblDressCode.text=DressCode;
    
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
                                       self.imgUser.image = [UIImage imageWithData:imageData];
                                   }
                                   else
                                   {
                                       self.imgUser.image = [UIImage imageNamed:@"no_img"];
                                   }
                                   
                                   
                               });
                           });
        }
        else
        {
        }
    }
}

#pragma mark - button action

- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
