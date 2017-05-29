//
//  AddAlbumVCViewController.m
//  orataro
//
//  Created by MAC008 on 27/05/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AddAlbumVCViewController.h"
#import "Global.h"

@interface AddAlbumVCViewController ()

@end

@implementation AddAlbumVCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _imgFriend.image = [_imgFriend.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_imgFriend setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    _imgFriend.contentMode = UIViewContentModeScaleAspectFit;
    
    _viewAddOuter.layer.cornerRadius = 30.0;
    _viewAddOuter.clipsToBounds = YES;
    
    _txtAlbumName.layer.cornerRadius = 3.0;
    _txtAlbumName.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _txtAlbumName.layer.borderWidth = 1.0;
    
     [Utility setLeftViewInTextField:_txtAlbumName imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- button action

- (IBAction)btnAddClicked:(id)sender
{
    
}

- (IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSaveClicked:(id)sender
{
    
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
