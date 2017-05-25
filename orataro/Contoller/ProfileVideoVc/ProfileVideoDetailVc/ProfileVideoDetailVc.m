//
//  ProfileVideoDetailVc.m
//  orataro
//
//  Created by Softqube on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileVideoDetailVc.h"
#import "Global.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "MBProgressHUD.h"

@interface ProfileVideoDetailVc ()
{
    AVPlayerViewController *playerViewController;
    
}
@end

@implementation ProfileVideoDetailVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Video(Gaurav)
    
    _lbHeaderTitle.text = [NSString stringWithFormat:@"Video (%@)",[Utility getCurrentUserName]];
    
    playerViewController = [[AVPlayerViewController alloc] init];
    
    // Do any additional setup after loading the view.
    [self commonData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(void)viewWillAppear:(BOOL)animated
{
    //NSLog(@"Dic=%@",_dicVideo);
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    MBProgressHUD *hud1 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Set the label text.
    hud1.label.text = NSLocalizedString(@"loading....", @"");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //  NSLog(@"Downloading Started");
        
        
        //  MBProgressHUD *hud2 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set the label text.
        // hud2.label.text = NSLocalizedString(@"Downloading....", @"");
        
        
        
        NSString *urlToDownload = [NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[_dicVideo objectForKey:@"Photo"]];
        
        NSURL  *url = [NSURL URLWithString:urlToDownload];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if ( urlData )
        {
            // [ProgressHUB showHUDAddedTo:self.view];
            
            [hud1 hideAnimated:YES];
            
            AVURLAsset *asset = [AVURLAsset assetWithURL: url];
            AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
            
            AVPlayer * player = [[AVPlayer alloc] initWithPlayerItem: item];
            playerViewController.player = player;
            
            [playerViewController.view setFrame:CGRectMake(0, 115, self.view.bounds.size.width, self.view.bounds.size.width)];
            
            playerViewController.showsPlaybackControls = YES;
            
            [self.view addSubview:playerViewController.view];
            
            
            [player play];
            
            
        }
        //[ProgressHUB showHUDAddedTo:self.view];
        // MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set the label text.
        //hud.label.text = NSLocalizedString(@"Downloading....", @"");
    });
    
    // });
    
    
    ///////////////////////
    
    
    
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
    [self.view bringSubviewToFront:_viewPopup];
    
}
- (IBAction)btnPopuBack:(id)sender
{
    [self PopupHidden];
}
- (IBAction)btnBackHeader:(id)sender
{
    [self PopupHidden];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnMenuHeader:(id)sender
{
    [self PopupShow];
}
- (IBAction)btnSaveMenu:(id)sender
{
    //NSLog(@"Download");
    
    [self PopupHidden];
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = NSLocalizedString(@"Downloading....", @"");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *urlToDownload = [NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[_dicVideo objectForKey:@"Photo"]];
        
        if([urlToDownload length] != 0)
        {
            NSURL* url =[NSURL URLWithString:urlToDownload];
            NSData *data = [NSData dataWithContentsOfURL:url];
            
            // Write it to cache directory
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"file.mov"];
            [data writeToFile:path atomically:YES];
            
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            
            [library saveVideo:[NSURL fileURLWithPath:path] toAlbum:@"Orataro" completion:^(NSURL *assetURL, NSError *error)
             {
                 //NSLog(@"Completed...........");
                 [hud hideAnimated:YES];
                 
             } failure:^(NSError *error)
             {
                 NSLog(@"Error=%@",error.description);
                 
             }];
        }
        
    });
    
   
}

@end
