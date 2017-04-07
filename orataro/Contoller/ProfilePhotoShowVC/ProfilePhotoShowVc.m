//
//  ProfilePhotoShowVc.m
//  orataro
//
//  Created by MAC008 on 27/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfilePhotoShowVc.h"
#import "Global.h"


@interface ProfilePhotoShowVc ()

@end

@implementation ProfilePhotoShowVc
@synthesize aInnerView,aOuterView,saveBtn;
int d =0;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [aInnerView.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
    [aInnerView.layer setBorderWidth:2];
    
    aOuterView.hidden = YES;
    
    
    NSLog(@"image=%@",_imagename);

    
    if([_strOfflineOnline isEqualToString:@"Offline"])
    {
        
        UIImage *image=[UIImage imageWithContentsOfFile:_imagename];
         _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.image = image;
        
        CGDataProviderRef provider = CGImageGetDataProvider(_imgView.image.CGImage);
        NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
        
        if (data.length == 0)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"No image available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
   
        }
        
    }
    else
    {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_imagename]];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        //CGDataProviderRef provider = CGImageGetDataProvider(_imgView.image.CGImage);
       // NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
        
       // if (data.length == 0)
       // {
           // UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"No image available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           // [alrt show];
            
       // }
        //else
        //{
            [_imgView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
             {
                 NSLog(@"Error");
             }];

        //}
    }
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SaveBtnClicked:(UIButton *)sender
{
    if (d == 0)
    {
        aOuterView.hidden = NO;
        [self.view bringSubviewToFront:aOuterView];
        d =1;
    }
    else
    {
        aOuterView.hidden = YES;
        d =0;
    }
    
}
- (IBAction)OnSaveClicked:(UIButton *)sender
{
    aOuterView.hidden = YES;
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeImageToSavedPhotosAlbum:[_imgView.image CGImage] orientation:(ALAssetOrientation)[_imgView.image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error)
     {
         if (error)
         {
             // TODO: error handling
             //  NSLog(@"Not handle");
         }
         else
         {
             // TODO: success handling
             //   NSLog(@"Success");
             
         }
     }];

    
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
