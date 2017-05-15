//
//  ParentProfileVc.h
//  orataro
//
//  Created by MAC008 on 05/05/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentProfileVc : UIViewController<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *txtMotherEducationQualification;
- (IBAction)btnGurdianProofIDClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtGuardianOfficeNameAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnGurdianPickupDrop;
- (IBAction)btnGurdianPickupDropClicked:(id)sender;
- (IBAction)btnGurdianProofClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtGurdianIdType;
@property (weak, nonatomic) IBOutlet UIView *viewGurdianPrefix;
- (IBAction)btnGurdianDateofIssueClicked:(id)sender;
- (IBAction)btnGurdianDateofExpiryClicked:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblGuardianHeight;
@property (weak, nonatomic) IBOutlet UITextField *txtGuardianDateofIssue;
- (IBAction)btnGuardianIDProofClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtGurdianHomeAddress;
- (IBAction)btnGurdianSaveClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnGuardianDateofExpiryClicked;
@property (weak, nonatomic) IBOutlet UIImageView *imgGurdianIDProof;
@property (weak, nonatomic) IBOutlet UIButton *btnGurdianIDProof;
- (IBAction)btnGurdianIDProofClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtGurdianDateofExpiry;
@property (weak, nonatomic) IBOutlet UIButton *btnGuardianDateofIssueClicked;
@property (weak, nonatomic) IBOutlet UITextField *txtEducationQualification;
@property (weak, nonatomic) IBOutlet UIView *viewMotherPRefix;
@property (weak, nonatomic) IBOutlet UITextField *txtGurdianOfficePhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtGurdianIdNo;
@property (weak, nonatomic) IBOutlet UITextView *txtGurdianOccupationDetail;
- (IBAction)btnMotherAnniversaryClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtGurdianOccupation;
@property (weak, nonatomic) IBOutlet UITextField *txtGurdianDesignation;
@property (weak, nonatomic) IBOutlet UITextField *txtQurdianEmail;
- (IBAction)btnGurdianAnniversaryClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *btnGurdianBirthDate;
@property (weak, nonatomic) IBOutlet UITextField *txtGuardianEducationQualification;
- (IBAction)btnGuardianPrefixClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtGurdianAnnioversary;
- (IBAction)btnGurdianBirthClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtGuardianFullName;
@property (weak, nonatomic) IBOutlet UITextField *txtGuradianFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtGuradianLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtGuradianPrefixName;
@property (weak, nonatomic) IBOutlet UITextField *txtGuardianPhoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnGuardianSelectPhoto;
- (IBAction)btnGuradianPhotoClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblMotherPrefix;
@property (weak, nonatomic) IBOutlet UITextField *txtMotherAnniversaryDate;
- (IBAction)btnMotherDateofExpiryClicked:(id)sender;
- (IBAction)btnMotherDateofIssueClicked:(id)sender;
- (IBAction)btnMotherDateofBirthClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtMotherHomeAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtMotherBirthDate;
@property (weak, nonatomic) IBOutlet UITextView *txtOccupationDetail;
@property (weak, nonatomic) IBOutlet UITextView *txtOfficeNameAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtMotherOfficeNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtMotherIDNo;
@property (weak, nonatomic) IBOutlet UIImageView *imgMotherIDProof;
- (IBAction)btnMotherIDProofClicked:(id)sender;
- (IBAction)btnMotherSaveClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMotherPickupDrop;
@property (weak, nonatomic) IBOutlet UITextField *txtMotherDateofIssue;
- (IBAction)btnMotherPickupDropClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtMotherIDType;
@property (weak, nonatomic) IBOutlet UITextField *txtMotherDateofExpiry;
@property (weak, nonatomic) IBOutlet UITextView *txtMotherOfficeNameAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtMotherPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextView *txtMotherOccupationDetail;
@property (weak, nonatomic) IBOutlet UITextField *txtMotherFullName;
@property (weak, nonatomic) IBOutlet UITextField *txtMotherFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtMotherLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtMotherOccupation;
@property (weak, nonatomic) IBOutlet UITextField *txtMotherDesignation;
@property (weak, nonatomic) IBOutlet UITextField *txtMotherEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnMotherProfileSelect;
- (IBAction)btnMotherProfileSelectPhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtFatherEducationQualification;
- (IBAction)btnFatherBirthDateClicked:(id)sender;
- (IBAction)btnFatherDateofIssueClicked:(id)sender;
- (IBAction)btnFatherDateofExpiryClicked:(id)sender;
- (IBAction)btnFatherAnnivearsaryClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtFatherDateofExpiry;
- (IBAction)btnFatherIdProofImageClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgFatherIdProofImage;
- (IBAction)btnFatherSaveClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtFatherDateofIssue;
- (IBAction)btnFatherPickupDropClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtFatherOfficeNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnFatherPickupDrop;
@property (weak, nonatomic) IBOutlet UITextField *txtFatherIdType;
@property (weak, nonatomic) IBOutlet UITextView *txtFatherHomeAddres;
@property (weak, nonatomic) IBOutlet UITextField *txtFatherId;
@property (weak, nonatomic) IBOutlet UITextView *txtFatherOfficeName;
@property (weak, nonatomic) IBOutlet UITextView *txtFatherOccupationDetail;
@property (weak, nonatomic) IBOutlet UITextField *txtFatherEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFatherDesignation;
@property (weak, nonatomic) IBOutlet UITextField *txtFatherOcuupation;
@property (weak, nonatomic) IBOutlet UITextField *txtFatherAnniversaryDate;
@property (weak, nonatomic) IBOutlet UITextField *txtFatherBirthDate;
@property (weak, nonatomic) IBOutlet UITextField *txtFatherPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtFatherFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtFatherMiddleName;
@property (weak, nonatomic) IBOutlet UITextField *txtFatherLastName;
@property (weak, nonatomic) IBOutlet UIButton *btnFatherSelectImage;
- (IBAction)btnFatherSelectPhotoClicked:(id)sender;
- (IBAction)btnProfileDateSelectClicked:(id)sender;
- (IBAction)btnProfileAnniversaryClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewPrefixProfile;
@property (weak, nonatomic) IBOutlet UITableView *tblPrefixProfile;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblPrefixHeight;
- (IBAction)btnProfileSelectPhotoClicked:(id)sender;

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnPrefixProfiClicked:(id)sender;

- (IBAction)btnSaveProfileClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtMiddleNameProfile;
@property (weak, nonatomic) IBOutlet UITextField *txtStateProfile;
@property (weak, nonatomic) IBOutlet UITextField *txtCountryProfile;
@property (weak, nonatomic) IBOutlet UITextField *txtPincodeProfile;

@property (weak, nonatomic) IBOutlet UITextView *txtOfficeAddressProfile;
@property (weak, nonatomic) IBOutlet UITextField *txtCityProfile;
@property (weak, nonatomic) IBOutlet UITextField *txtAnnivarsaryDateProfile;
@property (weak, nonatomic) IBOutlet UIButton *btnProfileImage;
@property (weak, nonatomic) IBOutlet UITextView *txtOccupationProfile;
@property (weak, nonatomic) IBOutlet UITextField *txtEmailProfile;
@property (weak, nonatomic) IBOutlet UITextField *txtlastnameProfile;
@property (weak, nonatomic) IBOutlet UITextField *txtDisplayNameProfile;
@property (weak, nonatomic) IBOutlet UITextField *txtPrefixProfile;
@property (weak, nonatomic) IBOutlet UITextField *txtBirthDateProfile;

@property (weak, nonatomic) IBOutlet UITextField *txtFullnameProfile;
@property (weak, nonatomic) IBOutlet UIView *viewIndicator2;
@property (weak, nonatomic) IBOutlet UITextField *txtFirstname;
@property (weak, nonatomic) IBOutlet UIView *viewIndicator3;

@property (weak, nonatomic) IBOutlet UIView *viewIndicator1;
@property (weak, nonatomic) IBOutlet UIButton *btnFather;
@property (strong, nonatomic) IBOutlet UIView *viewSecond;
@property (strong, nonatomic) IBOutlet UIView *viewThird;
@property (weak, nonatomic) IBOutlet UIScrollView *scrAddFourView;
@property (strong, nonatomic) IBOutlet UIView *viewFirst;
@property (weak, nonatomic) IBOutlet UIButton *btnGurdian;

@property (strong, nonatomic) IBOutlet UIView *viewFourth;
@property (weak, nonatomic) IBOutlet UIButton *btnProfile;

@property (weak, nonatomic) IBOutlet UIView *viewIndicator;
@property (weak, nonatomic) IBOutlet UIButton *btnMother;

@end
