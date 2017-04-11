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

#define BypassLogin @"NO"

#pragma mark - Alert Message

#define PHONE @"Contact Numeber Must Be 10 Digit"
#define PHONE_EMPTY @"Please Enter PhoneNumber"

#define INTERNETVALIDATION @"No internet connection.."
#define Api_Not_Response @"Please try again!"

#define PASSWORD_EMPTY @"Please Enter Password"
#define PASSWORD @"Password Must be greater than 5 Digit"
#define Password_Conf_Empty @"Please Enter Confirm Password"
#define Password_Conf_Not_Match @"Confirm Password not match"

#define Select_End_Date @"Please select end date."
#define Select_Start_Date @"Please select start date."

#define OTPCODE @"Please Enter OTP"


#define CIRCULAR_TITLE @"Please Enter Title"
#define CIRCULAR_DESC @"Please Enter Description"
#define CIRCULAR_ENDDATE "Please Select EndDate"
#define SELECT_STARTTIME "Please Select StartTime"
#define SELECT_ENDTIME "Please Select EndTime"
#define CLASSWORK_REFERNCELINK @"Please Enter Reference Link"
#define CIRCULAR_TYPE "Please Enter CircularType"
#define CIRCULAR_STANDARD "Please Enter At least one Standard and Division"


#define SUBJECT @"Please Enter Subject"

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
#import "DBOperation.h"
#import "SwitchAcoountVC.h"
#import "ForgotNewPwdVc.h"
#import "OtpPasswordVc.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "WToast.h"
#import "UITextView+Placeholder.h"
#import "HomeWrokVc.h"
#import "ClassworkVC.h"
#import "DisplayTitleVc.h"
#import "BlogDetailVc.h"
#import "profileSearchFriend.h"
#import "ProfileFriendRequestVc.h"
#import "PhotoVc.h"
#import "PhototableCell.h"
#import "ProfilePhotoShowVc.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "YTPlayerView.h"
#import "ProfileVideoVc.h"
#import "ProfileVideoDetailVc.h"
#import "UIScrollView+BottomRefreshControl.h"
#import "AFHTTPRequestOperation.h"
#import "AlbumPhotoCell.h"
#import "PhotoalbumCell.h"
#import "ProfilePhotoShowVc.h"

#import "AlbumPhotoVc.h"
#import "AlbumPhotoVc.h"

#import "CalenderEventVc.h"
#import "CalenderEventDetailVc.h"

#import "ReminderVc.h"
#import "CreateReminderVc.h"

#import "ScoolGroupVc.h"
#import "CreateScoolGroupVc.h"

#import "CreateScoolGroupVc.h"

#pragma mark - YOUTube Video Key

#define YouTubeVideo_Key  @"SII1LZqIAas"

#pragma mark - Api Url And Name List

#define URL_Api  @"http://orataro.com/Services/"


#pragma mark - Register

#define apk_registration  @"apk_registration.asmx"
#define apk_CheckUserMobileNumberForRegistration_action @"CheckUserMobileNumberForRegistration"
#define apk_CheckOTPForRegistration_action @"UserMobileNumberRegistration"


#pragma mark - Login

#define apk_login  @"apk_login.asmx"
#define apk_LoginWithGCM_action  @"LoginWithGCM"
#define apk_NewFogotPasswordCheckUserData_action  @"NewFogotPasswordCheckUserData"
#define apk_CheckSentOTPData_action  @"CheckSentOTPData"
#define apk_UpdateUserPassword_action  @"UpdateUserPassword"
#define apk_GetProjectType_action @"GetProjectType"

#pragma mark - Image Url

#define apk_ImageUrl @"http://orataro.com/DataFiles"
#define apk_ImageUrlFor_HomeworkDetail @"http://orataro.com"

#pragma mark - Circular

#define apk_circular  @"apk_circular.asmx"
#define apk_GetCircularList_action  @"GetCircularList"


#define apk_gradedivisionsubject @"apk_gradedivisionsubject.asmx"

#define apk_CreateCircularWithMulty_action @"CreateCircularWithMulty"

#define apk_GetGradeDivisionSubjectbyTeacher_action @"GetGradeDivisionSubjectbyTeacher"


#pragma mark - Homework

#define apk_homework  @"apk_homework.asmx"
#define apk_GetHomework_action  @"GetHomework"
#define apk_CreateHomework_action  @"CreateHomework"

#pragma mark - apk_classwork

#define apk_classwork  @"apk_classwork.asmx"
#define apk_GetClassWorkList_action  @"GetClassWorkList"
#define apk_CreateClassWork_action @"CreateClassWork"


#pragma mark - apk_attendance

#define apk_attendance  @"apk_attendance.asmx"
#define apk_AttendanceListForTeacher_action @"AttendanceListForTeacher"
#define apk_SaveAttendance @"SaveAttendance"

#pragma mark - apk_cmspage

#define apk_InstitutePage @"apk_cmspage.asmx"
#define apk_GetCmsPages_action @"GetCmsPages"
#define apk_GetCmsPageDetail_action @"GetCmsPageDetail"


#pragma mark - apk_blogs

#define apk_blogs @"apk_blogs.asmx"
#define apk_GetBlogList_action @"GetBlogList"
#define apk_GetBlogDetail_action @"GetBlogDetail"


#pragma mark - apk_friends

#define apk_friends @"apk_friends.asmx"
#define apk_GetFriendList @"GetFriendList"
#define apk_Searchfriend_action @"Searchfriend"
#define apk_GetFriendRequestList_action @"GetFriendRequestList"


#pragma mark - apk_Photo

#define apk_Photos @"apk_Photos.asmx"
#define apk_GetPhotoList_action @"GetPhotoList"

#pragma mark - apk_albums

#define apk_albums @"apk_albums.asmx"
#define apk_GetAlbumList_action @"GetAlbumList"
#define apk_GetAllPhotosByAlbum_action @"GetAllPhotosByAlbum"

#pragma mark -  PTCommunication

#define apk_ptcommunication  @"apk_ptcommunication.asmx"
#define apk_PTCommunicationGetStudentList_action @"PTCommunicationGetStudentList"
#define apk_PTCommunicationGetTeacherList_action @"PTCommunicationGetTeacherList"
#define apk_CreateNewPTCommnunication_action @"CreateNewPTCommnunication"
#define apk_GetPTCommunicationList_action @"GetPTCommunicationList"


#pragma mark - PostedImage

#define apk_apk_Post @"apk_Post.asmx"
#define apk_GetPosted_FileImgaeVideos @"GetPosted_FileImgaeVideos"

#pragma mark -  Timetable

#define apk_timetable  @"apk_timetable.asmx"
#define apk_GetTimeTableListForTeachert_action @"GetTimeTableListForTeacher"

#pragma mark - Notes

#define apk_notes  @"apk_notes.asmx"
#define apk_GetNotesList_action @"GetNotesList"

#pragma mark - Holiday

#define apk_holiday  @"apk_holiday.asmx"
#define apk_GetHoliday_action @"GetHoliday"

#pragma mark - Calendar

#define apk_calendar  @"apk_calendar.asmx"
#define apk_GetCalendarData_action @"GetCalendarData"


#pragma mark - apk_group

#define apk_group @"apk_group.asmx"
#define apk_Group_List_action @"Group_List"
#define apk_Remove_Group_action @"Remove_Group"
#define apk_SaveUpdate_Group @"SaveUpdate_Group"

#pragma mark - Todos

#define apk_todos  @"apk_todos.asmx"
#define apk_GetToDosList_action  @"GetToDosList"
#define apk_SaveUpdateTodos_action  @"SaveUpdateTodos"


#pragma mark - apk_notifications

#define apk_notifications  @"apk_notifications.asmx"
#define apk_NotificationGetList_action  @"NotificationGetList"
#define apk_SetViewFlageOnNotification_action  @"SetViewFlageOnNotification"




#endif /* Global_h */

