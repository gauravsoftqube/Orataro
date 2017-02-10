//
//  OrataroVc.m
//  orataro
//
//  Created by MAC008 on 08/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "OrataroVc.h"
#import "OrataroCell.h"

@interface OrataroVc ()<UIScrollViewDelegate>
{
    UICollectionView *coll;
    NSMutableArray *ary;
    NSMutableArray *aimageary;
}
@end

@implementation OrataroVc
@synthesize aCollectionView,aHeaderView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
   // String[] colorlist = { "#2D2079", "#582388", "#741A87", "#DC55A1",
      //  "#2D288A", "#2D68A0", "#6E649E", "#B089A9", "#E487A5", "#40AD9F",
       // "#6BBE95", "#582388", "#741A87","#E487A5","#2D288A" , "#6E649E","#DC55A1", "#741A87","#582388"};
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
     ary = [[NSMutableArray alloc]initWithObjects:@"Profile",@"Circular",@"Wall",@"Homework",@"ClassWork",@"Attendance",@"PT Communication",@"School Timing",@"Time Table",@"Notes",@"Holiday",@"Calender",@"Poll",@"Notification",@"Reminder",@"About Orataro",@"Settings",@"FAQ", nil];
    
    
    self.headerImageViewHeight.constant = 250;
    [self adjustContentViewHeight];
    
    NSLog(@"data=%lu",(unsigned long)ary.count);
    
    for (int i=0; i<ary.count; i++)
    {
        
        if (ary.count % 3 == 0)
        {
            NSLog(@"val=%d ary count=%lu",i,ary.count/3);
        }
        else
        {
            NSLog(@"val1 is=%d",i);
        }
    }
    
    NSLog(@"ary count=%lu",ary.count/3);
    
    //[self.contentView setBackgroundColor:[UIColor orangeColor]];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(coll.frame.size.width/3, coll.frame.size.width/3)];
    [layout setMinimumLineSpacing:0];
    [layout setMinimumInteritemSpacing:0];
    
    coll = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    
    CGFloat f = coll.frame.size.width/3;
    
    NSLog(@"data=%f",f);
    
    CGFloat cal = (f * ary.count/3);
    
    NSLog(@"data=%f",cal);
    
    NSLog(@"data=%f",(f*ary.count));
    
    
    self.contentViewHeight.constant = (f*ary.count)/3;
    [coll setFrame:CGRectMake(0, 0, self.view.frame.size.width, f*ary.count/3)];
    
    [coll setScrollEnabled:NO];
    [coll setBounces:NO];
    
    [coll setDataSource:self];
    [coll setDelegate:self];
    
    [coll registerClass:[OrataroCell class] forCellWithReuseIdentifier:@"OrataroCell"];
    [coll setBackgroundColor:[UIColor clearColor]];
    
    [coll registerNib:[UINib nibWithNibName:@"OrataroCell" bundle:nil] forCellWithReuseIdentifier:@"OrataroCell"];
    
    [self.contentView addSubview:coll];;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OrataroCell *cell = (OrataroCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"OrataroCell" forIndexPath:indexPath];
    
    cell.aLable.text = [ary objectAtIndex:indexPath.row];
    
    switch (indexPath.row)
    {
        case 0:
            
            //2D2079 ,45,32,121
            
            cell.aView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:32.0/255.0 blue:121.0/255.0 alpha:1.0];
            
            break;
        case 1:
            
            //582388 88,35,136
            
            cell.aView.backgroundColor = [UIColor colorWithRed:88.0/255.0 green:35.0/255.0 blue:136.0/255.0 alpha:1.0];
            
            //cell.aView.backgroundColor = [UIColor colorWithRed:87.0/255.0 green:40.0/255.0 blue:134.0/255.0 alpha:1.0];
            
            break;
        case 2:
            
            //,116,26,135
            
            cell.aView.backgroundColor = [UIColor colorWithRed:116.0/255.0 green:26.0/255.0 blue:135.0/255.0 alpha:1.0];
            
            break;
        case 3:
            
            //220,85,161
            
            cell.aView.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:85.0/255.0 blue:161.0/255.0 alpha:1.0];
            
            break;
        case 4:
            
            //45,40,138
            
            cell.aView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:40.0/255.0 blue:138.0/255.0 alpha:1.0];
            
            break;
        case 5:
            
            //45,104,160
            
            cell.aView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:104.0/255.0 blue:160.0/255.0 alpha:1.0];
            
            break;
        case 6:
            
            //110,100,158
            
            cell.aView.backgroundColor = [UIColor colorWithRed:110.0/255.0 green:100.0/255.0 blue:158.0/255.0 alpha:1.0];
            
            break;
        case 7:
            
            //B089A9 176,137,169
            
            cell.aView.backgroundColor = [UIColor colorWithRed:176.0/255.0 green:137.0/255.0 blue:169.0/255.0 alpha:1.0];
            
            break;
        case 8:
            
            //228,135,165
            
            cell.aView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:135.0/255.0 blue:165.0/255.0 alpha:1.0];
            
            break;
        case 9:
            
            //64,173,159
            
            cell.aView.backgroundColor = [UIColor colorWithRed:64.0/255.0 green:173.0/255.0 blue:159.0/255.0 alpha:1.0];
            
            break;
        case 10:
            
            //107,190,149
            
            cell.aView.backgroundColor = [UIColor colorWithRed:107.0/255.0 green:190.0/255.0 blue:149.0/255.0 alpha:1.0];
            
            break;
        case 11:
            
            //8835136
            cell.aView.backgroundColor = [UIColor colorWithRed:88.0/255.0 green:35.0/255.0 blue:136.0/255.0 alpha:1.0];
            
            break;
        case 12:
            
            //116,26,135
            
            cell.aView.backgroundColor = [UIColor colorWithRed:116.0/255.0 green:26.0/255.0 blue:135.0/255.0 alpha:1.0];
            
            break;
        case 13:
            
            //,228,135,165
            cell.aView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:135.0/255.0 blue:134.0/165.0 alpha:1.0];
            
            break;
        case 14:
            //,45,40,138
            
            cell.aView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:40.0/255.0 blue:138.0/255.0 alpha:1.0];
            
            break;
        case 15:
            
            //,110,100,158
            
            cell.aView.backgroundColor = [UIColor colorWithRed:110.0/255.0 green:100.0/255.0 blue:158.0/255.0 alpha:1.0];
            
            break;
        case 16:
            
            //220,85,161
            
            cell.aView.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:85.0/255.0 blue:161.0/255.0 alpha:1.0];
            
            break;
        case 17:
            
            //741A87 116,26,135
            cell.aView.backgroundColor = [UIColor colorWithRed:116.0/255.0 green:26.0/255.0 blue:135.0/255.0 alpha:1.0];
            
            break;
            
        default:
            break;
    }
    //OrataroCell
    
    // UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    //recipeImageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];
    
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ary.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat f = coll.frame.size.width/3;
    
    //  self.contentViewHeight.constant = f*ary.count;
    
    NSLog(@"ary count=%lu",(unsigned long)ary.count);
    
    NSLog(@"view width=%f",f);
    
    return CGSizeMake(f, f);
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
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
