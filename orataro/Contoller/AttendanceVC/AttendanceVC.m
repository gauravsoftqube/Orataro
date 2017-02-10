//
//  AttendanceVC.m
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AttendanceVC.h"
#import "AttendanceTableViewCell.h"
#import "ClassVcCell.h"

@interface AttendanceVC ()
{
    NSMutableArray *classTableDataAry;
}
@end

@implementation AttendanceVC
@synthesize AttendanceTableView,aClasstableView,aClassMAinView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    classTableDataAry = [[NSMutableArray alloc]initWithObjects:@"Class A",@"Class B",@"Class C",@"Class D",@"Class E", nil];
    
      [AttendanceTableView registerNib:[UINib nibWithNibName:@"AttendanceTableViewCell" bundle:nil] forCellReuseIdentifier:@"AttendanceCell"];
    AttendanceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [aClasstableView registerNib:[UINib nibWithNibName:@"ClassVcCell" bundle:nil] forCellReuseIdentifier:@"ClassCell"];
    aClasstableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    aClassMAinView.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TaptoHideView:)];
    
    [aClassMAinView addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tap to hide view

-(void)TaptoHideView :(UIGestureRecognizer *)tap
{
    aClassMAinView.hidden = YES;
}
#pragma mark - tabelview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == AttendanceTableView)
    {
        AttendanceTableViewCell *cell = (AttendanceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AttendanceCell"];
        
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AttendanceTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }

        if (indexPath.row % 2 ==0)
        {
            cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
        }
        else
        {
            cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    if (tableView == aClasstableView)
    {
        ClassVcCell *cell = (ClassVcCell *)[tableView dequeueReusableCellWithIdentifier:@"ClassCell"];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ClassVcCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

//        NSString *yourText = [yourArray objectAtIndex:indexPath.row];
//
//        CGSize labelWidth = CGSizeMake(300, CGFLOAT_MAX); // 300 is fixed width of label. You can change this value
//        CGRect textRect = [visitorsPerRegion boundingRectWithSize:labelWidth options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16.0]} context:nil];
//
//        int calculatedHeight = textRect.size.height+10;
//        return (float)calculatedHeight;

    if (tableView == AttendanceTableView)
    {
        return 59;
    }
    
    if (tableView == aClasstableView)
    {
        return 64;
    }

    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
#pragma mark - button action

- (IBAction)ClassBtnClicked:(id)sender
{
    aClassMAinView.hidden = NO;
    [self.view bringSubviewToFront:aClassMAinView];
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
