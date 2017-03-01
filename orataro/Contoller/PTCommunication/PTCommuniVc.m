//
//  PTCommuniVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "PTCommuniVc.h"
#import "ChatVc.h"
@interface PTCommuniVc ()

@end

@implementation PTCommuniVc
@synthesize aAddBtnouterView,aSearchTextField,noPtCommunLb,aTableView,ACloseImageView,aTextField,aPopupMainView,aSaveInnerView,aSaveOuterView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    aAddBtnouterView.layer.cornerRadius = 30.0;
    aAddBtnouterView.layer.masksToBounds = YES;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aSearchTextField.leftView = paddingView;
    aSearchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    aTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    aSaveOuterView.layer.cornerRadius = 30.0;
    aSaveInnerView.layer.cornerRadius = 25.0;
    
    
    ACloseImageView.image = [ACloseImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [ACloseImageView setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Taptohide:)];
    [aPopupMainView addGestureRecognizer:tap];
    
    aPopupMainView.hidden = YES;
     
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(5, aTextField.frame.size.height - 1, aTextField.frame.size.width-50, 1.0f);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [aTextField.layer addSublayer:bottomBorder];
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aTextField.leftView = paddingView1;
    aTextField.leftViewMode = UITextFieldViewModeAlways;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunicationCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommunicationCell"];
    }
    if (indexPath.row % 2 ==0)
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    
    //cell.textLabel.text = [stuAry objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatVc  *c = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ChatVc"];
    [self.navigationController pushViewController:c animated:YES];
}



#pragma mark - button action
-(void)Taptohide:(UIGestureRecognizer *)tap
{
    aPopupMainView.hidden = YES;
}
- (IBAction)AddBtnClicked:(id)sender
{
    aPopupMainView.hidden = NO;
    [self.view bringSubviewToFront:aPopupMainView];
}


- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)CloseBtnClicked:(id)sender
{
     aPopupMainView.hidden = YES;
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
