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
{
    NSString *strImageAry;
    NSMutableArray *imgAry;
    NSMutableArray *imgaryTemp;
}
@end

@implementation AddAlbumVCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     //AlbumCell
    
    imgAry =[[NSMutableArray alloc]init];
    imgaryTemp = [[NSMutableArray alloc]init];
    
    _imgFriend.image = [_imgFriend.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_imgFriend setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    _imgFriend.contentMode = UIViewContentModeScaleAspectFit;
    
    _viewAddOuter.layer.cornerRadius = 20.0;
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

#pragma mark - COLLECTIONVIEW DELEGATE

#pragma mark - COLLECTIONVIEW DELEGATE

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return imgaryTemp.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerNib:[UINib nibWithNibName:@"PhotoalbumCell" bundle:nil] forCellWithReuseIdentifier:@"PhotosCell"];
        
        PhotoalbumCell *cell2 = (PhotoalbumCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotosCell" forIndexPath:indexPath];
        
        if (cell2 == nil)
        {
            NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"PhotoalbumCell" owner:self options:nil];
            cell2 = [xib objectAtIndex:0];
        }
        cell2.aOuterView.layer.cornerRadius = 3.0;
        cell2.aOuterView.layer.borderWidth = 1.0;
        cell2.aOuterView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [NSString stringWithFormat: @"%@",[imgaryTemp objectAtIndex:indexPath.row]]];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    //imgShowImage
    cell2.imgPhoto.image = image;
    //imgaryTemp
    
    cell2.activityIndicator.hidden = YES;

    return cell2;

}
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionVie
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float f = collectionView.bounds.size.width/2;
    return CGSizeMake(f, f);
}
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0, 0, 0);
}

#pragma mark - ActionSheet delegates

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex == 0 )
    {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
            pickerView.allowsEditing = YES;
            pickerView.delegate = self;
            pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:pickerView animated:true];
        }
        
    }
    else if( buttonIndex == 1)
    {
        
        UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
        pickerView.allowsEditing = YES;
        pickerView.delegate = self;
        [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentModalViewController:pickerView animated:YES];
        
    }
}

#pragma mark - PickerDelegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
    
   // UIImage *image = [UIImage imageNamed:@"Image.jpg"];
    
    
    
    [self api_uploadImage:img];
   
}


#pragma mark- button action

- (IBAction)btnAddClicked:(id)sender
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Add Photo!" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Liabrary", nil];
    
    [action showInView:self.view];
}

- (IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSaveClicked:(id)sender
{
    NSLog(@"str=%@",strImageAry);
    
    if([_txtAlbumName.text isEqualToString:@""])
    {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please Enter Album Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
    }
    if ([strImageAry isEqualToString:@"(null)"] || [strImageAry isEqual: [NSNull null]]|| strImageAry.length == 0)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please select at least one image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    [self api_AddAlbum];
}

#pragma mark - Upload image

-(void)api_uploadImage : (UIImage *)img
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_post,apk_UploadFile];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    NSString *strFileName = [NSString stringWithFormat:@"%@.png",[Utility randomImageGenerator]];
    
    NSData *pngData = UIImagePNGRepresentation(img);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:strFileName]; //Add the file name
    [pngData writeToFile:filePath atomically:YES]; //Write the file
    
    
    [param setValue:strFileName forKey:@"FileName"];
    NSData *data = UIImagePNGRepresentation(img);
    const unsigned char *bytes = [data bytes];
    NSUInteger length = [data length];
    NSMutableArray *byteArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < length; i++)
    {
        [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
    }
    [param setValue:byteArray forKey:@"File"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    [param setValue:@"IMAGE" forKey:@"FileType"];
    //IMAGE
    [ProgressHUB showHUDAddedTo:self.view];
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
          [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"no image upload" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     NSLog(@"Arr=%@",arrResponce);
                    
                     NSString *str2 = [[arrResponce objectAtIndex:0]objectForKey:@"message"];
                     NSArray *ary1 = [str2 componentsSeparatedByString:@" "];
                     NSString *secondObject = [ary1 objectAtIndex:1];
                     [imgAry addObject:secondObject];
                     strImageAry = [imgAry componentsJoinedByString:@"#"];
                     
                     NSString *nameofImg = [ary1 objectAtIndex:0];
                     [imgaryTemp addObject:nameofImg];
                     
                     [_collectionView reloadData];
                    
                     //imgaryTemp
                 }
             }
             else
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
             }
         }
         else
         {
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alrt show];
         }
     }];

}

#pragma mark - save Image to album

-(void)api_AddAlbum
{
     NSLog(@"Ary=%@",imgAry);
    
//    <InstituteID>guid</InstituteID>
//    <ClientID>guid</ClientID>
//    <WallID>guid</WallID>
//    <MemberID>guid</MemberID>
//    <UserID>guid</UserID>
//    <MemberID>guid</BeachID>
    
//    <AlbumShareType>string</AlbumShareType>
//    <ImagesPath>string</ImagesPath>
//    <AlbumDetails>string</AlbumDetails>
//    <AlbumTitle>string</AlbumTitle>
//    <Places>string</Places>
//    <PostByType>string</PostByType>
//    <approved>boolean</approved>
    
    //apk_apk_Post
    //apk_AddAlbum
    
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_post,apk_AddAlbum];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
    [param setValue:@"PUBLIC" forKey:@"AlbumShareType"];
   
    [param setValue:strImageAry forKey:@"ImagesPath"];
    [param setValue:@"" forKey:@"AlbumDetails"];
    [param setValue:_txtAlbumName.text forKey:@"AlbumTitle"];
    [param setValue:@"" forKey:@"Places"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"PostByType"]] forKey:@"PostByType"];
     [param setValue:@"true" forKey:@"approved"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"no add to album list" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                    [self.navigationController popViewControllerAnimated:NO];
                     
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                    
                 }
             }
             else
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
             }
         }
         else
         {
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alrt show];
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
