//
//  ProfileVideoDetailVc.m
//  orataro
//
//  Created by Softqube on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileVideoDetailVc.h"

@interface ProfileVideoDetailVc ()

@end

@implementation ProfileVideoDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

-(void)commonData
{
[self.viewPopupBorder.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
[self.viewPopupBorder.layer setBorderWidth:2];
[self PopupHidden];
}

-(void)PopupHidden
{
    [self.btnPopuBack setHidden:YES];
    [self.viewPopup setHidden:YES];
}

-(void)PopupShow
{
    [self.btnPopuBack setHidden:NO];
    [self.viewPopup setHidden:NO];
}
- (IBAction)btnPopuBack:(id)sender {
    [self PopupHidden];
}
- (IBAction)btnBackHeader:(id)sender
{
    [self PopupHidden];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnMenuHeader:(id)sender {
    [self PopupShow];
}
- (IBAction)btnSaveMenu:(id)sender {
    [self PopupHidden];
}
@end
