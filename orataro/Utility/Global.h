//
//  Global.h
//  iHop
//
//  Created by Softqube on 07/12/16.
//  Copyright © 2016 Softqube. All rights reserved.
//

#ifndef Global_h
#define Global_h

#define AppDel ((LoginVC *)[[UIApplication sharedApplication] delegate])

/*
 
#define COMMING @"Comming soon...!"
#define USERNM @"Please Enter UserName"

#define EMAIL @"Please Enter Email"
#define BIRTH @"Please Enter Date of Birth"
#define ADDRESS @"Please Enter Address"
#define CONTACT @"Please Enter Contact No"

#define ZIPCODE @"Please Enter ZipCode"
#define NAME @"Please Enter Name"
#define SURNAME @"Please Enter SurName"
#define ORGANIZATION @"Please Enter Organization Name"
#define COMPANY @"Please Enter Company Name"
#define COLLEGE @"Please Enter College Name"
#define YEAR @"Please Enter Passing Year"
#define MARKS @"Please Enter Marks"
#define JOBTITLE @"Please Enter Job Title"
#define DESCRIPTION @"Please Enter Description"
#define DETAILS @"Please fill all Details"
#define NORECORD @"No Record Found"
#define PASSCONFIRMPASS @"Password and Confirm Password must be same"
#define OLDPASSNOTMATCH @"Old Password is not mattched"
#define EMAILALLREADY @"Email Address already exist"
#define VALIDEMAIL @"Please Enter valid Email"
#define OLDPASS @"Please Enter Old Password"
#define NEWPASS @"Please Enter New Password"
#define PASSVALIDATION @"Password should contain minimum six character"

 
 */

#pragma mark - Alert Message

#define PHONE @"Contact Numeber Must Be 10 Digit"
#define PHONE_EMPTY @"Please Enter PhoneNumber"

#define INTERNETVALIDATION @"No internet connection.."
#define Api_Not_Response @"Please try again!"
#define PASSWORD_EMPTY @"Please Enter Password"
#define PASSWORD @"Password Must be greater than 5 Digit"
#define OTPCODE @"Please Enter OTP"

#pragma mark - IMPORT UIViewController


#import "Utility.h"
#import "ProgressHUB.h"
#import "Reachability.h"
#import "RightVc.h"
#import "RightCell.h"
#import "AddpostVc.h"
#import "AddCircularVc.h"
#import "ListSelectionVc.h"
#import "AddClassWorkVc.h"
#import "AttendanceVC.h"
#import "StudentListViewController.h"
#import "PTCommuniVc.h"
#import "AddNoteVc.h"
#import "HolidayVc.h"
#import "AddPollVc.h"
#import "ResultVc.h"
#import "PollVc.h"
#import "NotificationVc.h"
#import "OrataroVc.h"
#import "ReminderVc.h"
#import "AboutOrataroVc.h"
#import "HelpDeskVc.h"
#import "AboutUsVc.h"
#import "SettingVcViewController.h"
#import "FAQvc.h"
#import "MyProfileVc.h"
#import "PageVc.h"
#import "MessageVc.h"
#import "BlogVc.h"
#import "FriendVc.h"
#import "LoginVC.h"
#import "RegisterVc.h"
#import "RegisterOtpVc.h"
#import "WallVc.h"
#import "REFrostedViewController.h"


#pragma mark - Api Url And Name List

#define URL_Api  @"http://orataro.com/Services/"

#pragma mark - Register

#define apk_registration  @"apk_registration.asmx"

#define apk_CheckUserMobileNumberForRegistration_action @"CheckUserMobileNumberForRegistration"
#define apk_CheckOTPForRegistration_action @"UserMobileNumberRegistration"


#pragma mark - Login

#define apk_login  @"apk_login.asmx"


#define apk_LoginWithGCM_action  @"LoginWithGCM"

#endif /* Global_h */

