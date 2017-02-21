//
//  WallVc.m
//  orataro
//
//  Created by harikrishna patel on 27/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "WallVc.h"
#import "WallCustomeCell.h"
#import "SWRevealViewController.h"
#import "AddpostVc.h"

@interface WallVc ()

@end

@implementation WallVc
@synthesize aWallTableView,aTableHeaderView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [aWallTableView registerNib:[UINib nibWithNibName:@"WallCustomeCell" bundle:nil] forCellReuseIdentifier:@"WallCustomeCell"];
    
    aWallTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    aWallTableView.tableHeaderView = aTableHeaderView;
    
    aWallTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WallCustomeCell *cell = (WallCustomeCell *)[tableView dequeueReusableCellWithIdentifier:@"WallCustomeCell"];
    
    [cell.aLikeViewWidth setConstant:self.view.frame.size.width/4];
    [cell.aCommentViewWidth setConstant:self.view.frame.size.width/4];
    [cell.aShareViewWidth setConstant:self.view.frame.size.width/4];
    [cell.aUnlikeViewWidth setConstant:self.view.frame.size.width/4];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSIndexPath * indexPath1=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
    
 //  WallCustomeCell *cell1 = (WallCustomeCell *)[self.aWallTableView dequeueReusableCellWithIdentifier:@"WallCustomeCell"];
    
  //  WallCustomeCell *cell = (WallCustomeCell *)[aWallTableView cellForRowAtIndexPath:indexPath];
    
    //NSLog(@"height=%f",(float)cell1.aFirstViewheight);
    
    
    //cell1.aFirstView.frame.size.height
    
   // CGRect frame = view.frame;
    

//     MyCustomCell *cell1 = (MyCustomCell *) [[self.aWallTableView cellForRowAtIndexPath:indexPath1];
//    
//    MyCustomCell *cell1 = (MyCustomCell *)[[aWallTableView dequeueReusableCellWithIdentifier:@"WallCustomeCell"];
    
    //NSIndexPath *path in [tableView indexPathsForVisibleRows]
    
    // MyCustomCell *cell = (MyCustomCell *)[self.tableView cellForRowAtIndexPath:path];
    
    return 288;
}

#pragma mark - button action

- (IBAction)MenuBtnClicked:(id)sender
{
    self.revealViewController.shouldUseFrontViewOverlay = YES;
    [self.revealViewController rightRevealToggle:nil];
}

- (IBAction)WhatsyourmindBtnClicked:(id)sender
{
    AddpostVc *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddpostVc"];
    
    //[self.navigationController pushViewController:wc animated:YES];
    
    //[self performSegueWithIdentifier:@"Showaddpost" sender:self];
    [self.revealViewController pushFrontViewController:wc animated:YES];
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
