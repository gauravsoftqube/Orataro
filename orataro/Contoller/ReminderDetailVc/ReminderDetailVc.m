//
//  ReminderDetailVc.m
//  orataro
//
//  Created by Softqube on 19/04/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ReminderDetailVc.h"
#import "Global.h"

@interface ReminderDetailVc ()

@end

@implementation ReminderDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSelected_Value];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSelected_Value
{
    NSString *strTitle=[self.dicSelected objectForKey:@"Title"];
    NSString *Details=[self.dicSelected objectForKey:@"Details"];
    
    self.lbltitle.text = [strTitle capitalizedString];
    self.lblDetail.text = [Details capitalizedString];
    
    NSString *TypeTerm=[self.dicSelected objectForKey:@"TypeTerm"];
    NSString *Status=[self.dicSelected objectForKey:@"Status"];
    
    self.lblType.text= TypeTerm;
    if([Status isKindOfClass:[NSNull class]])
    {
        self.lblStatus.text=@"InCompleted";
    }
    else
    {
        self.lblStatus.text = Status;
    }
    NSString *CreateOn=[self.dicSelected objectForKey:@"CreateOn"];
    CreateOn = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:CreateOn];
    NSString *EndDate=[self.dicSelected objectForKey:@"EndDate"];
    EndDate = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:EndDate];
    
    self.lblStartDate.text=CreateOn;
    self.lblEndDate.text= EndDate;

}

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
