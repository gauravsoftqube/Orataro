//
//  AboutOrataroVc.m
//  orataro
//
//  Created by MAC008 on 09/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AboutOrataroVc.h"
#import "AboutUsVc.h"
#import "HelpDeskVc.h"
#import "ContactUsVc.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"
#import "Global.h"

@interface AboutOrataroVc ()
{
    NSArray *dispary,*imgary;
    int c2;
    AppDelegate *app;
}
@end

@implementation AboutOrataroVc
@synthesize AboutTableView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.automaticallyAdjustsScrollViewInsets = NO;

    dispary = [[NSMutableArray alloc]initWithObjects:@"Share App",@"Rate App",@"Our other Free Apps",@"Facebook",@"Twitter",@"Linkin",@"Google+",@"About Us",@"Contact US",@"Help Desk", nil];
    
    imgary = [[NSMutableArray alloc]initWithObjects:@"share",@"star",@"more23",@"facebook",@"twitter",@"linkdin",@"googleplus",@"user",@"phone",@"customersupport", nil];
    
    AboutTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    AboutTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //AboutCell
    
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"About Orataro (%@)",[arr objectAtIndex:0]];
    }
    else
    {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"About Orataro"];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AboutCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AboutCell"];
    }
    
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    UILabel *lb = [cell.contentView viewWithTag:2];
    lb.text = [dispary objectAtIndex:indexPath.row];
    
    if (indexPath.row %2 ==0)
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    }
    
    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:1];
    
    img1.image = [UIImage imageNamed:[imgary objectAtIndex:indexPath.row]];
    
    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    img1.contentMode = UIViewContentModeScaleAspectFit;
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dispary.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     AboutUsVc *a = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AboutUsVc"];
    
     ContactUsVc *c = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ContactUsVc"];
    
    HelpDeskVc *h = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"HelpDeskVc"];
    
    switch (indexPath.row)
    {
        case 0:
        {
            NSString *url=@"";
            NSMutableArray *sharingItems = [NSMutableArray new];
            
            if (url) {
                [sharingItems addObject:url];
            }
            
            UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
            [self presentViewController:activityController animated:YES completion:nil];
        }
            break;
            
        case 1:
        {
            NSString *iTunesLink = @"http://itunes.com/apps/orataro";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
        }
            break;
            
        case 2:
        {
            NSString *iTunesLink = @"http://itunes.com/apps/orataro";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
        }
            break;
            
        case 3:
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]])
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://page/890013191086690"]];
            }
            else
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/ORATARO/"]];
            }
        }
            break;
            
        case 4:
        {
             if ([self schemeAvailable:@"twitter://"])
             {
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://orataroapp"]];
             }
             else
             {
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/orataroapp"]];
             }

        }
            break;
            
        case 5:
        {
            if ([self schemeAvailable:@"linkedin://"])
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"linkedin://orataro"]];
            }
            else
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.linkedin.com/company/orataro"]];
            }
        }
            break;
            
        case 6:
            
        {
            if ([self schemeAvailable:@"plus.google.com://"])
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"plus.google.com://106006930296339413383"]];
            }
            else
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://plus.google.com/106006930296339413383"]];
            }
        }
            break;
            
        case 7:
            
           
            [self.navigationController pushViewController:a animated:YES];
            
            break;
            
        case 8:
            
            [self.navigationController pushViewController:c animated:YES];
            
            break;
            
        case 9:
            
            [self.navigationController pushViewController:h animated:YES];
            
            break;
            
            
        default:
            break;
    }
}

- (BOOL)schemeAvailable:(NSString *)scheme {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:scheme];
    return [application canOpenURL:URL];
}


#pragma mark - button action

- (IBAction)MenuBtnClicked:(id)sender
{
    self.frostedViewController.direction = REFrostedViewControllerDirectionRight;
    
    if (app.checkview == 0)
    {
        [self.frostedViewController presentMenuViewController];
        app.checkview = 1;
        
    }
    else
    {
        [self.frostedViewController hideMenuViewController];
        app.checkview = 0;
    }
}
- (IBAction)btnHomeClicked:(id)sender
{
     [self.frostedViewController hideMenuViewController];
    
    UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
    
    [self.navigationController pushViewController:wc animated:NO];
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
