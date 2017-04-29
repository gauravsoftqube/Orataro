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
    
    // set STT
    [self.viewSTT_Poppup setHidden:YES];
    [self allocSTT];
    
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
            [ProgressHUB showHUDAddedTo:self.view];
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

#pragma mark - set local Databse post detail

-(void)postImageInLocalDB
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
    if([mediaType isEqualToString:@"public.movie"])
    {
        NSURL *chosenMovie = [info objectForKey:UIImagePickerControllerMediaURL];
        NSString *timestampVideo = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
        NSArray *ary = [timestampVideo componentsSeparatedByString:@"."];
        NSString *getTime = [ary objectAtIndex:0];
        NSURL *fileURL = [self grabFileURL:[NSString stringWithFormat:@"%@.mov",getTime]];
        NSData *movieData = [NSData dataWithContentsOfURL:chosenMovie];
        [movieData writeToURL:fileURL atomically:YES];
        UISaveVideoAtPathToSavedPhotosAlbum([chosenMovie path], nil, nil, nil);
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:[NSString stringWithFormat:@"%@",fileURL] forKey:@"videoSelect"];
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
//    UIButton *btn=(UIButton*)sender;
//    if (btn.selected)
//    {
//        [self.lblSTT_Status setText:@"Tap to speak"];
//        [self.btnSTT_Start_Stop setImage:[UIImage imageNamed:@"microphone_circle_white"] forState:UIControlStateNormal];
//        [self.viewSTT_Poppup setHidden:YES];
//        btn.selected=NO;
//    }
//    else
//    {
//        
//        [self.lblSTT_Status setText:@"Speak now"];
//        [self.btnSTT_Start_Stop setImage:[UIImage imageNamed:@"microphone_circle"] forState:UIControlStateNormal];
//        btn.selected=YES;
//    }
    
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

        
        // self.btnSpeechToText.enabled=true;
        //[_StartListeningButton setTitle:@"Start listening" forState:UIControlStateNormal];
    }
    else
    {
        //[_StartListeningButton setTitle:@"Stop listening" forState:UIControlStateNormal];
        // self.btnSpeechToText.enabled=false;
        
        
        [self startListening];
        [self.lblSTT_Status setText:@"Speak now"];
        [self.btnSTT_Start_Stop setImage:[UIImage imageNamed:@"microphone_circle"] forState:UIControlStateNormal];
        [self.viewSTT_Poppup setHidden:NO];

     }

}
@end
