//
//  AddpostVc.h
//  orataro
//
//  Created by Softqube Mac IOS on 30/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>




//= = = = = = = = = = = = = = = = =

#import <Speech/SFSpeechRecognizer.h>
#import <Speech/SFSpeechRecognitionRequest.h>
#import <Speech/SFSpeechRecognitionTask.h>
#import <Speech/SFSpeechRecognitionResult.h>
#import <Speech/SFTranscription.h>

//= = = = = =  = = = = = = = = = = =


@interface AddpostVc : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//========

@property(strong,nonatomic)NSMutableDictionary *dicSelect_std_divi_sub;
@property (strong, nonatomic) NSDictionary *rapidCommandsDictionary;
@property(strong,nonatomic)NSString *checkscreen;

//========


//Header
- (IBAction)BackBtnClicked:(UIButton*)sender;
- (IBAction)SaveBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblheaderTitle;

//To
@property (weak, nonatomic) IBOutlet UIImageView *imgTo;
@property (weak, nonatomic) IBOutlet UILabel *lblTo;
@property (weak, nonatomic) IBOutlet UIButton *btnTo;
- (IBAction)btnTo:(id)sender;


//
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UITextView *txtView_PostText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewTo_Height;


@property (weak, nonatomic) IBOutlet UIButton *btnSpeechToText;
- (IBAction)btnSpeechToText:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnAddPhoto;
- (IBAction)btnAddPhoto:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnAddVideo;
- (IBAction)btnAddVideo:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionList_ImageAndVideo;


//popup Delete Conf
@property (weak, nonatomic) IBOutlet UIView *viewDelete_Conf;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteConf_Cancel;
- (IBAction)btnDeleteConf_Cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteConf_Yes;
- (IBAction)btnDeleteConf_Yes:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewSave;
@property (weak, nonatomic) IBOutlet UIView *viewInnerSave;
@property (weak, nonatomic) IBOutlet UIImageView *imgCancel;


//viewShare Pop up
@property (strong, nonatomic) IBOutlet UIView *viewshare_Popup;
- (IBAction)btnPublic_SharePopup:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPublic_SharePopup;
- (IBAction)btnOnlyMe_SharePopup:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnOnlyMe_SharePopup;
- (IBAction)btnFriends_SharePopup:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnFriends_SharePopup;


//view STT
@property (weak, nonatomic) IBOutlet UIView *viewSTT_Poppup;
@property (weak, nonatomic) IBOutlet UIButton *btnBack_STT;
- (IBAction)btnBack_STT:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblSTT_Status;
@property (weak, nonatomic) IBOutlet UIButton *btnSTT_Start_Stop;
- (IBAction)btnSTT_Start_Stop:(id)sender;



@end
