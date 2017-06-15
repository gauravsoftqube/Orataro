
//
//  AddpostVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 30/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AddpostVc.h"
#import "REFrostedViewController.h"
#import "WallVc.h"
#import "RightVc.h"
#import "Global.h"

@interface AddpostVc ()
{
    NSMutableArray *arrPopup;
    NSMutableArray *arrCollectionList;
    NSMutableArray *arrResponceImagePath;
    NSIndexPath *indexPathTemp;
    
    //STT
    SFSpeechRecognizer * speechRecognizer;
    SFSpeechAudioBufferRecognitionRequest * speechRecognitionRequest;
    SFSpeechRecognitionTask * speechRecognitionTask;
    AVAudioEngine * audioEngine;
    // The command execution boolean.
    Boolean _commandExecuted;
    
    
}
@end

@implementation AddpostVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self commonData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    //view Delete conf
    [self.viewDelete_Conf setHidden:YES];
    _viewSave.layer.cornerRadius = 30.0;
    _viewInnerSave.layer.cornerRadius = 25.0;
    _imgCancel.image = [_imgCancel.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_imgCancel setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    //alloc
    arrCollectionList  = [[NSMutableArray alloc]init];
    arrResponceImagePath = [[NSMutableArray alloc]init];
    
    // set STT
    [self.viewSTT_Poppup setHidden:YES];
    [self allocSTT];
    
    //set Edit Post Detail
    if(self.dicSelect_Edit_Delete_Post != nil)
    {
        [self.txtView_PostText setText:[NSString stringWithFormat:@"%@",[self.dicSelect_Edit_Delete_Post objectForKey:@"PostCommentNote"]]];
   
        //
        self.ViewTo_Height.constant=0;
        self.viewAddPhotoVideo_Height.constant=0;
        
        //set Header Title
        NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
        if (arr.count != 0) {
            self.lblheaderTitle.text=[NSString stringWithFormat:@"Edit Post (%@)",[arr objectAtIndex:0]];
            [self getCurrentUserImage:[Utility getCurrentUserDetail]];
        }
        else
        {
            self.lblheaderTitle.text=[NSString stringWithFormat:@"Edit Post"];
        }
    }
    else
    {
        //
        self.ViewTo_Height.constant=40;
        self.viewAddPhotoVideo_Height.constant=35;
        
        NSString *IsAllowUserToPostStatus=[[Utility getCurrentUserDetail]objectForKey:@"IsAllowUserToPostStatus"];
        NSString *IsAllowUserToPostPhoto=[[Utility getCurrentUserDetail]objectForKey:@"IsAllowUserToPostPhoto"];
        NSString *IsAllowUserToPostVideo=[[Utility getCurrentUserDetail]objectForKey:@"IsAllowUserToPostVideo"];
        
        
        if ([_checkscreen isEqualToString:@"Institute"] ||
            [_checkscreen isEqualToString:@"Standard"] ||
            [_checkscreen isEqualToString:@"Division"] ||
            [_checkscreen isEqualToString:@"Subject"] ||
            [_checkscreen isEqualToString:@"Group"] ||
            [_checkscreen isEqualToString:@"Project"])
        {
            if([IsAllowUserToPostStatus integerValue] == 1)
            {
                NSString *IsAdmin=[[self.arrDynamicWall_Setting objectAtIndex:0] objectForKey:@"IsAdmin"];
                if ([IsAdmin integerValue] == 1)
                {
                    NSString *IsAllowPostStatus=[[self.arrDynamicWall_Admin_Setting objectAtIndex:0]objectForKey:@"IsAllowPostStatus"];
                   
                    if([IsAllowPostStatus integerValue] == 1)
                    {
                        self.viewAddText_Height.constant=50;
                    }
                    else
                    {
                        self.viewAddText_Height.constant=0;
                    }
                }
                else
                {
                    NSString *IsAllowPeopleToPostStatus=[[self.arrDynamicWall_Setting objectAtIndex:0]objectForKey:@"IsAllowPeopleToPostStatus"];
                   
                    if([IsAllowPeopleToPostStatus integerValue] == 1)
                    {
                        self.viewAddText_Height.constant=50;
                    }
                    else
                    {
                        self.viewAddText_Height.constant=0;
                    }
                    
                }
            }
            else
            {
                self.viewAddText_Height.constant=0;
            }
            
            if([IsAllowUserToPostPhoto integerValue] == 1)
            {
                NSString *IsAdmin=[[self.arrDynamicWall_Setting objectAtIndex:0] objectForKey:@"IsAdmin"];
                if ([IsAdmin integerValue] == 1)
                {
                  
                    NSString *IsAllowPostPhoto=[[self.arrDynamicWall_Admin_Setting objectAtIndex:0]objectForKey:@"IsAllowPostPhoto"];
                    
                    long width=[[UIScreen mainScreen]bounds].size.width/2;
                    if([IsAllowPostPhoto integerValue] == 1)
                    {
                        self.viewAddPhoto_width.constant=width;
                    }
                    else
                    {
                        self.viewAddPhoto_width.constant=0;
                    }
                }
                else
                {
                    NSString *IsAllowPeopleToUploadAlbum=[[self.arrDynamicWall_Setting objectAtIndex:0]objectForKey:@"IsAllowPeopleToUploadAlbum"];
                    long width=[[UIScreen mainScreen]bounds].size.width/2;
                    if([IsAllowPeopleToUploadAlbum integerValue] == 1)
                    {
                        self.viewAddPhoto_width.constant=width;
                    }
                    else
                    {
                        self.viewAddPhoto_width.constant=0;
                    }
                }
            }
            else
            {
                self.viewAddText_Height.constant=0;
            }
            
            if([IsAllowUserToPostVideo integerValue] == 1)
            {
                NSString *IsAdmin=[[self.arrDynamicWall_Setting objectAtIndex:0] objectForKey:@"IsAdmin"];
                if ([IsAdmin integerValue] == 1)
                {
                    NSString *IsAllowPostVideo=[[self.arrDynamicWall_Admin_Setting objectAtIndex:0]objectForKey:@"IsAllowPostVideo"];
                    
                    long width=[[UIScreen mainScreen]bounds].size.width/2;
                    
                    if([IsAllowPostVideo integerValue] == 1)
                    {
                        self.viewAddVideo_Width.constant=width;
                    }
                    else
                    {
                        self.viewAddVideo_Width.constant=0;
                    }
                }
                else
                {
                    NSString *IsAllowPeopleToPostVideos=[[self.arrDynamicWall_Setting objectAtIndex:0]objectForKey:@"IsAllowPeopleToPostVideos"];
                    
                    long width=[[UIScreen mainScreen]bounds].size.width/2;
                    
                    if([IsAllowPeopleToPostVideos integerValue] == 1)
                    {
                        self.viewAddVideo_Width.constant=width;
                    }
                    else
                    {
                        self.viewAddVideo_Width.constant=0;
                    }
                }
            }
            else
            {
                self.viewAddText_Height.constant=0;
            }
        }
        else if ([_checkscreen isEqualToString:@"MyWall"])
        {
            if([IsAllowUserToPostStatus integerValue] == 1)
            {
                self.viewAddText_Height.constant=50;
            }
            else
            {
                self.viewAddText_Height.constant=0;
            }
            
            long width=[[UIScreen mainScreen]bounds].size.width/2;
            if([IsAllowUserToPostPhoto integerValue] == 1)
            {
                self.viewAddPhoto_width.constant=width;
            }
            else
            {
                self.viewAddPhoto_width.constant=0;
            }
            
            if([IsAllowUserToPostVideo integerValue] == 1)
            {
                self.viewAddVideo_Width.constant=width;
            }
            else
            {
                self.viewAddVideo_Width.constant=0;
            }

        }
        else
        {
            if([IsAllowUserToPostStatus integerValue] == 1)
            {
                self.viewAddText_Height.constant=50;
            }
            else
            {
                self.viewAddText_Height.constant=0;
            }
            
            long width=[[UIScreen mainScreen]bounds].size.width/2;
            if([IsAllowUserToPostPhoto integerValue] == 1)
            {
                self.viewAddPhoto_width.constant=width;
            }
            else
            {
                self.viewAddPhoto_width.constant=0;
            }
            
            if([IsAllowUserToPostVideo integerValue] == 1)
            {
                self.viewAddVideo_Width.constant=width;
            }
            else
            {
                self.viewAddVideo_Width.constant=0;
            }
        }

        //set Header Title
        NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
        if (arr.count != 0) {
            self.lblheaderTitle.text=[NSString stringWithFormat:@"Add Post (%@)",[arr objectAtIndex:0]];
            [self getCurrentUserImage:[Utility getCurrentUserDetail]];
        }
        else
        {
            self.lblheaderTitle.text=[NSString stringWithFormat:@"Add Post"];
        }
    }
}

-(void)allocSTT
{
    speechRecognizer = [[SFSpeechRecognizer alloc] init];
    audioEngine = [[AVAudioEngine alloc] init];
    // self.btnSpeechToText.enabled = true;
    
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        switch (status) {
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                // self.btnSpeechToText.enabled = true;
                break;
            case SFSpeechRecognizerAuthorizationStatusDenied:
                [self updateText:@"User denied access to the microphone." forUIElement:PartialResultTextView];
                break;
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                [self updateText:@"There is rescricted access to the microphone on this device." forUIElement:PartialResultTextView];
                break;
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                [self updateText:@"Could not determine status for microphone." forUIElement:PartialResultTextView];
                break;
            default:
                break;
        }
    }];
    
}

-(void)getCurrentUserImage :(NSMutableDictionary *)dic
{
    if ([Utility isInterNetConnectionIsActive] == true)
    {
        NSString *strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@",[dic objectForKey:@"ProfilePicture"]];
        if(![strURLForTeacherProfilePicture isKindOfClass:[NSNull class]])
        {
            strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[dic objectForKey:@"ProfilePicture"]];
            //[ProgressHUB showHUDAddedTo:self.view];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                           ^{
                               
                               NSURL *imageURL = [NSURL URLWithString:strURLForTeacherProfilePicture];
                               NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                               
                               //This is your completion handler
                               dispatch_sync(dispatch_get_main_queue(), ^{
                                   [ProgressHUB hideenHUDAddedTo:self.view];
                                   UIImage *img = [UIImage imageWithData:imageData];
                                   if (img != nil)
                                   {
                                       self.imgUser.image = [UIImage imageWithData:imageData];
                                   }
                                   else
                                   {
                                       self.imgUser.image = [UIImage imageNamed:@"user"];
                                   }
                                   
                               });
                           });
        }
    }
    
}

#pragma mark - apiCall

-(void)apiCallFor_newPost:(NSString *)strInternet FileType:(NSString *)FileType
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_post,apk_Post_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    
    if ([_checkscreen isEqualToString:@"Institute"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstitutionWallID"]] forKey:@"WallID"];
    }
    else if ([_checkscreen isEqualToString:@"Standard"] ||
             [_checkscreen isEqualToString:@"Division"] ||
             [_checkscreen isEqualToString:@"Subject"] ||
             [_checkscreen isEqualToString:@"Group"] ||
             [_checkscreen isEqualToString:@"Project"])
    {
         [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    else if ([_checkscreen isEqualToString:@"MyWall"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@""] forKey:@"BeachID"];
    
    
    if([self.lblTo.text isEqualToString:@"Friends"])
    {
        [param setValue:[NSString stringWithFormat:@"Friend"] forKey:@"PostShareType"];
    }
    else if([self.lblTo.text isEqualToString:@"Public"])
    {
        [param setValue:[NSString stringWithFormat:@"Public"] forKey:@"PostShareType"];
    }
    else if([self.lblTo.text isEqualToString:@"Only Me"])
    {
        [param setValue:[NSString stringWithFormat:@"Only Me"] forKey:@"PostShareType"];
    }
    
    [param setValue:[NSString stringWithFormat:@"%@",self.txtView_PostText.text] forKey:@"PostCommentNote"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"PostByType"]] forKey:@"PostByType"];
    
    if([FileType isEqualToString:@"IMAGE"])
    {
        NSString *ImagePath=[arrResponceImagePath componentsJoinedByString:@","];
        [param setValue:[NSString stringWithFormat:@"%@",ImagePath] forKey:@"ImagePath"];
    }
    if([FileType isEqualToString:@"VIDEO"])
    {
        NSString *VideoPath=[arrResponceImagePath componentsJoinedByString:@","];
        [param setValue:[NSString stringWithFormat:@"%@",VideoPath] forKey:@"ImagePath"];
    }
    if([FileType isEqualToString:@"Text"])
    {
        [param setValue:[NSString stringWithFormat:@""] forKey:@"ImagePath"];
    }

    
    [param setValue:[NSString stringWithFormat:@"%@",FileType] forKey:@"FileType"];
    
    [param setValue:[NSString stringWithFormat:@"%@",FileType] forKey:@"FileMineType"];
    
    [param setValue:[NSString stringWithFormat:@"true"] forKey:@"approved"];
    
    
//    if([strInternet isEqualToString:@"1"])
//    {
//        [ProgressHUB showHUDAddedTo:self.view];
//    }
    
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
                    // UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:POSTCREATE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                   //  [alrt show];
                     [WToast showWithText:POSTCREATE];
                 }
                 else if([strStatus isEqualToString:@"Post Added successfully."])
                 {
                     //UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    // [alrt show];
                      [self.navigationController popViewControllerAnimated:YES];
                     [WToast showWithText:[dic objectForKey:@"message"]];
                    
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


-(void)apiCallFor_UploadFile:(NSString *)strInternet FileType:(NSString *)FileType FileName:(NSString *)FileName imageSelect:(UIImage*)imageSelect videoURL:(NSString *)strvideoURL
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    [ProgressHUB showHUDAddedTo:self.view];
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_post,apk_UploadFile_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",FileName] forKey:@"FileName"];
    
    if([FileType isEqualToString:@"IMAGE"])
    {
        NSData *data = UIImagePNGRepresentation(imageSelect);
        const unsigned char *bytes = [data bytes];
        NSUInteger length = [data length];
        NSMutableArray *byteArray = [NSMutableArray array];
        for (NSUInteger i = 0; i < length; i++)
        {
            [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
        }
        [param setValue:byteArray forKey:@"File"];
    }
    if([FileType isEqualToString:@"VIDEO"])
    {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectoryPath = [paths objectAtIndex:0];
        
        NSURL *videoNSURL = [NSURL fileURLWithPath:[documentsDirectoryPath stringByAppendingPathComponent:strvideoURL]];
        NSData *data = [NSData dataWithContentsOfURL:videoNSURL];
        
        const unsigned char *bytes = [data bytes];
        NSUInteger length = [data length];
        NSMutableArray *byteArray = [NSMutableArray array];
        for (NSUInteger i = 0; i < length; i++)
        {
            [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
        }
        [param setValue:byteArray forKey:@"File"];
    }
    
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",FileType] forKey:@"FileType"];
    
    if([strInternet isEqualToString:@"1"])
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
        
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
                    // UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:POSTIMAGE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    // [alrt show];
                     [WToast showWithText:POSTIMAGE];
                 }
                 else
                 {
                     NSString *message=[dic objectForKey:@"message"];
                     NSArray *arrMessage=[message componentsSeparatedByString:@" "];
                     if([arrMessage count] > 0)
                     {
                         message=[arrMessage objectAtIndex:1];
                     }
                     [arrResponceImagePath addObject:message];
                     
                     NSArray *arrVideo=[arrCollectionList valueForKey:@"videoSelect"];
                     NSArray *arrImage=[arrCollectionList valueForKey:@"imageSelect"];
                     
                     NSNull *strNull=[[NSNull alloc]init];
                     if ([Utility isInterNetConnectionIsActive] == true)
                     {
                         if([arrVideo count] == 0 || [arrVideo containsObject:strNull])
                         {
                             if([arrCollectionList count] == [arrResponceImagePath count])
                             {
                                 [self apiCallFor_newPost:@"1" FileType:@"IMAGE"];
                             }
                         }
                         else if([arrImage count] == 0 || [arrImage containsObject:strNull])
                         {
                             [self apiCallFor_newPost:@"1" FileType:@"VIDEO"];
                         }
                         else
                         {
                             [self apiCallFor_newPost:@"1" FileType:@"Text"];
                         }
                     }
                     else
                     {
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alrt show];
                     }
                     
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

#pragma mark - Edit post apiCall

-(void)apiCallFor_editPostDetail:(NSString *)strInternet
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_generalwall,apk_EditPostDetails_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_Edit_Delete_Post objectForKey:@"PostCommentID"]] forKey:@"PostID"];
    [param setValue:[NSString stringWithFormat:@"%@",self.txtView_PostText.text] forKey:@"PostCommentNote"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    
    if([strInternet isEqualToString:@"1"])
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    
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
                   //  UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:POSTADD delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    // [alrt show];
                      [WToast showWithText:POSTADD];
                 }
                 else  if([strStatus isEqualToString:@"Record update successfully"])
                 {
                  //   UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:strStatus /delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    // [alrt show];
                     [WToast showWithText:strStatus];
                     
                     [self.navigationController popViewControllerAnimated:YES];
                 }
                 else
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:strStatus delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                     [self.navigationController popViewControllerAnimated:YES];
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


#pragma mark - set Local Databse post detail

-(void)post_ImageIn_LocalDB
{
    NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSMutableArray *arrRandonImageName=[[NSMutableArray alloc]init];
    for (NSMutableDictionary *dic in arrCollectionList)
    {
        NSString *imgName=[NSString stringWithFormat:@"/%@.png",[Utility randomImageGenerator]];
        [arrRandonImageName addObject:imgName];
        
        NSString *fileName = [stringPath stringByAppendingFormat:@"%@",imgName];
        NSData *data = UIImageJPEGRepresentation([dic objectForKey:@"imageSelect"], 1.0);
        [data writeToFile:fileName atomically:YES];
    }
    
    [self postNew_Image_LocalDB:arrRandonImageName];
}

-(void)postNew_Image_LocalDB:(NSMutableArray*)arrImageName
{
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSString *WallID;
    if ([_checkscreen isEqualToString:@"Institute"])
    {
        WallID = [NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstitutionWallID"]];
    }
    else if ([_checkscreen isEqualToString:@"Standard"] ||
             [_checkscreen isEqualToString:@"Division"] ||
             [_checkscreen isEqualToString:@"Subject"] ||
             [_checkscreen isEqualToString:@"Group"] ||
             [_checkscreen isEqualToString:@"Project"])
    {
        WallID = [NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]];
    }
    else if ([_checkscreen isEqualToString:@"MyWall"])
    {
        WallID = [NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]];
    }
    else
    {
        WallID = [NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]];
    }
    NSString *PostShareType=[self.lblTo text];
    NSString *PostCommentNote=[self.txtView_PostText text];
    NSString *FileType;
    
    FileType=@"IMAGE";
    
    NSString *FileMineType;
    
    FileMineType= @"IMAGE";
    
    NSString *approved;
    
    approved=@"true";
    
    NSString *ImagePath=[arrImageName componentsJoinedByString:@","];
    
    [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO newPost (WallID,PostShareType,PostCommentNote,ImagePath,FileType,FileMineType,approved)values('%@','%@','%@','%@','%@','%@','%@')",WallID,PostShareType,PostCommentNote,ImagePath,FileType,FileMineType,approved]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)post_VideoIn_LocalDB
{
    NSMutableArray *arrRandonImageName=[[NSMutableArray alloc]init];
    for (NSMutableDictionary *dic in arrCollectionList)
    {
        NSString *VideoName=[dic objectForKey:@"videoSelect"];
        [arrRandonImageName addObject:VideoName];
    }
    
    [self postNew_Video_LocalDB:arrRandonImageName];
}

-(void)postNew_Video_LocalDB:(NSMutableArray*)arrVideoName
{
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSString *WallID;
    if ([_checkscreen isEqualToString:@"Institute"])
    {
        WallID = [NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstitutionWallID"]];
    }
    else if ([_checkscreen isEqualToString:@"Standard"] ||
             [_checkscreen isEqualToString:@"Division"] ||
             [_checkscreen isEqualToString:@"Subject"] ||
             [_checkscreen isEqualToString:@"Group"] ||
             [_checkscreen isEqualToString:@"Project"])
    {
        WallID = [NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]];
    }
    else if ([_checkscreen isEqualToString:@"MyWall"])
    {
        WallID = [NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]];
    }
    else
    {
        WallID = [NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]];
    }
    
    NSString *PostShareType=[self.lblTo text];
    NSString *PostCommentNote=[self.txtView_PostText text];
    NSString *FileType;
    FileType=@"VIDEO";
    
    NSString *FileMineType;
    FileMineType= @"VIDEO";
    
    NSString *approved;
    approved=@"true";
    
    NSString *ImagePath=[arrVideoName componentsJoinedByString:@","];
    
    [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO newPost (WallID,PostShareType,PostCommentNote,ImagePath,FileType,FileMineType,approved)values('%@','%@','%@','%@','%@','%@','%@')",WallID,PostShareType,PostCommentNote,ImagePath,FileType,FileMineType,approved]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)post_TextIn_LocalDB
{
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSString *WallID;
    if ([_checkscreen isEqualToString:@"Institute"])
    {
        WallID = [NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstitutionWallID"]];
    }
    else if ([_checkscreen isEqualToString:@"Standard"] ||
             [_checkscreen isEqualToString:@"Division"] ||
             [_checkscreen isEqualToString:@"Subject"] ||
             [_checkscreen isEqualToString:@"Group"] ||
             [_checkscreen isEqualToString:@"Project"])
    {
        WallID = [NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]];
    }
    else if ([_checkscreen isEqualToString:@"MyWall"])
    {
        WallID = [NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]];
    }
    else
    {
        WallID = [NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]];
    }
    NSString *PostShareType=[self.lblTo text];
    NSString *PostCommentNote=[self.txtView_PostText text];
    NSString *FileType;
    FileType=@"Text";
    
    NSString *FileMineType;
    FileMineType= @"Text";
    
    NSString *approved;
    approved=@"true";
    
    NSString *ImagePath=@"";
    
    [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO newPost (WallID,PostShareType,PostCommentNote,ImagePath,FileType,FileMineType,approved)values('%@','%@','%@','%@','%@','%@','%@')",WallID,PostShareType,PostCommentNote,ImagePath,FileType,FileMineType,approved]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - COLLECTIONVIEW DELEGATE

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrCollectionList count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellCollection";
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIView *viewBackground=(UIView*)[cell.contentView viewWithTag:1];
    viewBackground.layer.cornerRadius = 3.0;
    viewBackground.clipsToBounds=YES;
    viewBackground.layer.borderColor = [UIColor lightGrayColor].CGColor;
    viewBackground.layer.borderWidth = 1.0;
    
    UIImageView *imageSelected=(UIImageView*)[cell.contentView viewWithTag:2];
    imageSelected.image=[[arrCollectionList objectAtIndex:indexPath.row]objectForKey:@"imageSelect"];
    
    NSArray *arrImage=[arrCollectionList valueForKey:@"imageSelect"];
    NSNull *strNull=[[NSNull alloc]init];
    if([arrImage count] == 0 || [arrImage containsObject:strNull])
    {
        imageSelected.image=[UIImage imageNamed:@"dummy_video.png"];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float f = collectionView.bounds.size.width/2;
    return CGSizeMake(f-10, f-10);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5,5, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)btnCell_DeleteImageVideo:(id)sender
{
    [self.viewDelete_Conf setHidden:NO];
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.collectionList_ImageAndVideo];
    indexPathTemp = [self.collectionList_ImageAndVideo indexPathForItemAtPoint:buttonPosition];
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    //public.image
    //public.movie
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    if(![mediaType isEqualToString:@"public.image"])
    {
        NSURL *chosenMovie = [info objectForKey:UIImagePickerControllerMediaURL];
       
        NSString *timestampVideo = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
        NSArray *ary = [timestampVideo componentsSeparatedByString:@"."];
        NSString *getTime = [ary objectAtIndex:0];
        NSURL *fileURL = [self grabFileURL:[NSString stringWithFormat:@"%@.mp4",getTime]];
     
        NSData *movieData = [NSData dataWithContentsOfURL:chosenMovie];
        [movieData writeToURL:fileURL atomically:YES];
        UISaveVideoAtPathToSavedPhotosAlbum([chosenMovie path], nil, nil, nil);
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:[NSString stringWithFormat:@"%@.mp4",getTime] forKey:@"videoSelect"];
        [arrCollectionList addObject:dic];
    }
    else
    {
        UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
        if([arrCollectionList count] < 6)
        {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setValue:img forKey:@"imageSelect"];
            [arrCollectionList addObject:dic];
        }
        else
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Post_Image_limit delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
        }
    }
    [self.collectionList_ImageAndVideo reloadData];
}

- (NSURL*)grabFileURL:(NSString *)fileName
{
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    documentsURL = [documentsURL URLByAppendingPathComponent:fileName];
    return documentsURL;
}

#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [arrPopup removeObject:popTipView];
}

#pragma mark - Delete Conf UIButton Action

- (IBAction)btnDeleteConf_Cancel:(id)sender
{
    [self.viewDelete_Conf setHidden:YES];
}

- (IBAction)btnDeleteConf_Yes:(id)sender
{
    [self.viewDelete_Conf setHidden:YES];
    if([arrCollectionList count] != 0)
    {
        [arrCollectionList removeObjectAtIndex:indexPathTemp.row];
    }
    [self.collectionList_ImageAndVideo reloadData];
}

#pragma mark - SharePost To: UIButton Action

- (IBAction)btnPublic_SharePopup:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    [self.lblTo setText:@"Public"];
    [self.imgTo setImage:[UIImage imageNamed:@"fb_publics_round_blue"]];
}

- (IBAction)btnOnlyMe_SharePopup:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    [self.lblTo setText:@"Only Me"];
    [self.imgTo setImage:[UIImage imageNamed:@"fb_only_me_round_blue"]];
}

- (IBAction)btnFriends_SharePopup:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    [self.lblTo setText:@"Friends"];
    [self.imgTo setImage:[UIImage imageNamed:@"fb_group_round_blue"]];
}

#pragma mark - UIButton Action

- (IBAction)BackBtnClicked:(id)sender
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SaveBtnClicked:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    if(self.dicSelect_Edit_Delete_Post == nil)
    {
        //image
        NSArray *arrVideo=[arrCollectionList valueForKey:@"videoSelect"];
        NSArray *arrImage=[arrCollectionList valueForKey:@"imageSelect"];
        
        NSNull *strNull=[[NSNull alloc]init];
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            if([arrCollectionList count] != 0)
            {
                if([arrVideo count] == 0 || [arrVideo containsObject:strNull])
                {
                    for (NSMutableDictionary *dic in arrCollectionList)
                    {
                        UIImage *img=[dic objectForKey:@"imageSelect"];
                        [self apiCallFor_UploadFile:@"1" FileType:@"IMAGE" FileName:[NSString stringWithFormat:@"%@.png",[Utility randomImageGenerator]] imageSelect:img videoURL:nil];
                    }
                }
                else if([arrImage count] == 0 || [arrImage containsObject:strNull])
                {
                    for (NSMutableDictionary *dic in arrCollectionList)
                    {
                        NSString *strVideo=[dic objectForKey:@"videoSelect"];
                        [self apiCallFor_UploadFile:@"1" FileType:@"VIDEO" FileName:[NSString stringWithFormat:@"%@.mp4",[Utility randomImageGenerator]] imageSelect:nil videoURL:strVideo];
                    }
                }
            }
            else if (![Utility validateBlankField:self.txtView_PostText.text])
            {
                [self apiCallFor_newPost:@"1" FileType:@"Text"];
            }
        }
        else
        {
            if([arrCollectionList count] != 0)
            {
                if([arrVideo count] == 0 || [arrVideo containsObject:strNull])
                {
                    [self post_ImageIn_LocalDB];
                }
                else if([arrImage count] == 0 || [arrImage containsObject:strNull])
                {
                    [self post_VideoIn_LocalDB];
                }
            }
            else if (![Utility validateBlankField:self.txtView_PostText.text])
            {
                [self post_TextIn_LocalDB];
            }
        }
    }
    else
    {
        if (![Utility validateBlankField:self.txtView_PostText.text])
        {
            [self apiCallFor_editPostDetail:@"1"];
        }
        else
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Post_enter_detail delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
        }
    }
}

- (IBAction)btnTo:(id)sender
{
    [self.view endEditing:YES];
    arrPopup = [[NSMutableArray alloc]init];
    [arrPopup addObject:[Utility addCell_PopupView:self.viewshare_Popup ParentView:self.view sender:sender]];
}

- (IBAction)btnAddPhoto:(id)sender
{
    [self.view endEditing:YES];
    NSArray *arrVideo=[arrCollectionList valueForKey:@"videoSelect"];
    
    NSNull *strNull=[[NSNull alloc]init];
    
    if([arrVideo count] == 0 || [arrVideo containsObject:strNull])
    {
        if([arrCollectionList count] < 5)
        {
            UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Add Photo!" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Liabrary", nil];
            [action showInView:self.view];
        }
        else
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Post_Image_limit delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
        }
    }
    else
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Post_only_Video_or_image delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
    }
}

- (IBAction)btnAddVideo:(id)sender
{
    [self.view endEditing:YES];
    NSArray *arrImage=[arrCollectionList valueForKey:@"imageSelect"];
    NSNull *strNull=[[NSNull alloc]init];
    if([arrImage count] == 0 || [arrImage containsObject:strNull])
    {
        if([arrCollectionList count] < 1)
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"add Video" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction* pickFromGallery = [UIAlertAction actionWithTitle:@"Take a video"
                                                                      style:UIAlertActionStyleDefault
                                                                    handler:^(UIAlertAction * action) {
                                                                        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                                                        {
                                                                            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                                                            {
                                                                                
                                                                                UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                                                                                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                                                picker.delegate = self;
                                                                                picker.allowsEditing = NO;
                                                                                NSArray *mediaTypes = [[NSArray alloc]initWithObjects:(NSString *)kUTTypeMovie, nil];
                                                                                picker.mediaTypes = mediaTypes;
                                                                                [self presentViewController:picker animated:YES completion:nil];
                                                                                
                                                                            } else {
                                                                                
                                                                                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"I'm afraid there's no camera on this device!" delegate:nil cancelButtonTitle:@"Dang!" otherButtonTitles:nil, nil];
                                                                                [alertView show];
                                                                            }
                                                                            
                                                                            
                                                                        }
                                                                        
                                                                    }];
            UIAlertAction* takeAPicture = [UIAlertAction actionWithTitle:@"Choose from gallery"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action)
                                           {
                                               if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                               {
                                                   
                                                   UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                                                   picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                   picker.delegate = self;
                                                   picker.allowsEditing = NO;
                                                   NSArray *mediaTypes = [[NSArray alloc]initWithObjects:(NSString *)kUTTypeMovie, nil];
                                                   picker.mediaTypes = mediaTypes;
                                                   [self presentViewController:picker animated:YES completion:nil];
                                                   
                                               } else {
                                                   
                                                   UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"I'm afraid there's no camera on this device!" delegate:nil cancelButtonTitle:@"Dang!" otherButtonTitles:nil, nil];
                                                   [alertView show];
                                               }
                                               
                                           }];
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * action) {
                                                           }];
            
            [alertController addAction:pickFromGallery];
            [alertController addAction:takeAPicture];
            [alertController addAction:cancel];
            [self presentViewController:alertController animated:YES completion:nil];  
        }
        else
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Post_Video_limit delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
        }
    }
    else
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Post_only_Video_or_image delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
    }
}

#pragma mark - SLL Method

- (void)startListening
{
    if(speechRecognitionTask != nil)
    {
        [speechRecognitionTask cancel];
        speechRecognitionTask = nil;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    [audioSession setMode:AVAudioSessionModeMeasurement error:nil];
    [audioSession setActive:YES error:nil];
    
    speechRecognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    AVAudioInputNode * inputNode = [audioEngine inputNode];
    
    speechRecognitionRequest.shouldReportPartialResults = YES;
    
    self.txtView_PostText.text = @"";
    // [self clearText];
    //[self updateText:@"Speak a command!" forUIElement:PartialResultTextView];
    
    speechRecognitionTask = [speechRecognizer recognitionTaskWithRequest:speechRecognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        Boolean isFinal = NO;
        
        if(_commandExecuted)
            return;
        
        if(result != nil)
        {
            //  self.btnSpeechToText.enabled = true;
            NSString* response = [[result bestTranscription] formattedString];
            [self.txtView_PostText setText:[NSString stringWithFormat:@"%@",response]];
            [self updateText:[[result bestTranscription] formattedString] forUIElement:PartialResultTextView];
            isFinal = [result isFinal];
            
            if([self tryAndRecognisePhrase:response])
            {
                [self updateText:[NSString stringWithFormat:@"Action succesfully issued: %@, using local dictionary matching.", (NSString*)[_rapidCommandsDictionary objectForKey:[response lowercaseString]]] forUIElement:ActionIssuedTextView];
                
                isFinal = YES;
                _commandExecuted = YES;
            }
        }
        
        if(isFinal)
        {
            [self updateText:[[result bestTranscription] formattedString] forUIElement:FinalResultTextView];
        }
        
        if(error != nil || isFinal)
        {
            [audioEngine stop];
            [inputNode removeTapOnBus: 0];
            if(speechRecognitionRequest != nil)
            {
                [speechRecognitionRequest endAudio];
            }
            
            speechRecognitionRequest = nil;
            speechRecognitionTask = nil;
            
            if(error)
            {
                UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alrt show];
                // [self updateText:@"An error occured starting the Speech service. Try again later." forUIElement:PartialResultTextView];
                return;
            }
            
            if(_commandExecuted)
            {
                
                //   [_StartListeningButton setTitle:@"Start listening" forState:UIControlStateNormal];
            }
            else
            {
                //                UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                //                [alrt show];
                //[self updateText:@"Command was not found in local dictionary. Reaching to LUIS for intent extraction" forUIElement:ActionIssuedTextView];
                
                //   [self extractLuisIntent:[[result bestTranscription] formattedString]];
            }
        }
    }];
    
    AVAudioFormat* recordingFormat = [inputNode outputFormatForBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format: recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [speechRecognitionRequest appendAudioPCMBuffer:buffer];
    }];
    
    [audioEngine prepare];
    [audioEngine startAndReturnError:nil];
}
- (Boolean)tryAndRecognisePhrase:(NSString *)phrase
{
    if([_rapidCommandsDictionary objectForKey:[phrase lowercaseString]])
    {
        _commandExecuted = YES;
    }
    
    return _commandExecuted;
}

-(void)updateText:(NSString*)text forUIElement:(TextViewElement)textViewElement
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        switch (textViewElement)
        {
            case ActionIssuedTextView:
                self.txtView_PostText.text = text;
                break;
            case LuisResultTextView:
                self.txtView_PostText.text = text;
                break;
            case FinalResultTextView:
                self.txtView_PostText.text = text;
                break;
            case PartialResultTextView:
                self.txtView_PostText.text = text;
                break;
                
            default:
                break;
        }
    });
}

- (IBAction)btnSpeechToText:(id)sender
{
    [self.view endEditing:YES];
    [self.viewSTT_Poppup setHidden:NO];
}

- (IBAction)btnBack_STT:(id)sender
{
    [self.viewSTT_Poppup setHidden:YES];
}

- (IBAction)btnSTT_Start_Stop:(id)sender
{
    if([audioEngine isRunning])
    {
        [audioEngine stop];
        if(speechRecognitionRequest != nil)
        {
            [speechRecognitionRequest endAudio];
        }
        
        [self.viewSTT_Poppup setHidden:YES];
        [self.lblSTT_Status setText:@"Tap to speak"];
        [self.btnSTT_Start_Stop setImage:[UIImage imageNamed:@"microphone_circle_white"] forState:UIControlStateNormal];
    }
    else
    {
        [self startListening];
        [self.lblSTT_Status setText:@"Speak now"];
        [self.btnSTT_Start_Stop setImage:[UIImage imageNamed:@"microphone_circle"] forState:UIControlStateNormal];
        [self.viewSTT_Poppup setHidden:NO];
    }
}
@end
