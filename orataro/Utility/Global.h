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

#define Wait @"Please Wait..."
#define Start_Downloding @"Start Downloding"
#define Complete_Downloding @"Complete Downloding"

#define You_dont_have_permission @"You don\'t have permission."
#define No_Data_Available @"No Data Available."

#define Post_share_successfully @"Post share successfully"
#define Post_enter_detail @"Please enter post detail"

#define Enter_Post_Comment @"Please Enter comment"
#define Please_Select_Friend @"Please select at lest one friend"

#define Post_Image_limit @"Post only less than 5 image"
#define Post_Video_limit @"Post only one video"
#define Post_only_Video_or_image @"Post only image or video"


#define PHONE @"Contact Numeber Must Be 10 Digit"
#define PHONE_EMPTY @"Please Enter PhoneNumber"

#define INTERNETVALIDATION @"No internet connection.."
//#define Api_Not_Response @"Please try again!"
#define Api_Not_Response @"Server not responding!"

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

#define Select_Option @"Please select more than one option."


#define SUBJECT @"Please Enter Subject"
#define STUDENTGROUP @"Please Select Group Member of Student"
#define TEACHERGROUP @"Please Select Group Member of Teacher"


#pragma mark- Slow interner

#define INTERNET @"Please check your internet connection slow."

#pragma mark - Notification Alert 

    #define NOTIFICATION @"No notification found"

#pragma mark - Poll Alert

    #define POLL @"No poll list found"
    #define POLLCREATE @"No poll created."

#pragma mark - Happygram alert

    #define HAPPYGRAM @"No happygramm list found"

#pragma mark - leave alert

    #define STUDENTLEAVE @"No leave Found"
    #define LEAVELISTSAVE @"Leave not save."

#pragma mark - image,photo,album alert

    #define IMAGEUPLOAD @"No image upload"
    #define ALBUMCREATED @"Album create sucessfully."
    #define PHOTOALBUMLIST @"Photo list not found"

#pragma mark - attendance alert

    #define ATTENDANCE @"No attendance list found"
    #define ATTENSUBDIV @"No suject/division found."
    #define ATTENNOTSAVE @"No attendance save."

#pragma mark - circular alert

    #define CIRCULART @"No circular create."
    #define CIRCULARNOTIFICATION @"No notification found"
    #define CIRCULARSUBJECTLIST @"No subject/division list found"
    #define CIRCULARLIST @"Circular list not available"

#pragma mark - classwork alert

    #define CLASSWORKCREATE @"No classwork create."
    #define CLASSWORKLIST @"Classwork not available"

#pragma mark - comment alert

    #define COMMENTLIST @"No comment add."

#pragma mark - homework alert 

    #define HOMEWORKALERT @"No homework create."
    #define  HOMEWORKLIST @"No homework list found"

#pragma mark - note alert

    #define NOTESUBDIV @"No subject/division available"
    #define NOTEDESC @"No description available"
    #define NOTECREATE @"No note created."
    #define NOTETIMETABLE @"No time table found"

#pragma mark - post(add) alert

    #define POSTCREATE @"Post not successfully add."
    #define POSTIMAGE @"Image not upload."
    #define POSTADD @"Record not add."

#pragma mark - blog alert 

    #define BLOGLIST @"No blog list found"

#pragma mark - calendar 

    #define CALENDERNOPROJECT @"Project list not available"
    #define CALLIST @"Calender data not available"

#pragma mark - changepassword alert

    #define PASSWORDCHANGE @"Password could not change."

#pragma mark - chat alert

    #define CHATHISTORY @"Chat history not available."
    #define CHATCOMMU @"PTcommunication not available."

#pragma mark - project(create) alert

    #define PROJECTCREATE @"Project not successfully create."
    #define PROJECTDIVISIONLIST @"Division list not available"
    #define PROJECTSTUNDENTGROUP @"Student group not available"
    #define PROJECTTEACHERLIST @"Teacher list not available"
    #define PRONOTCREATE @"Project not created."
    #define PRODELETERECORD @"Record not delete"

#pragma mark - reminder(create) alert

    #define REMINDERNOTFOUND @"Reminder not available"
    #define REMIDERECORD @"Record not update."

#pragma mark - schoolgroup(create) alert

    #define SCHOOLCIRCULARTYPE @"Circular type not available"
    #define SCHOOLSUBDIV @"No subject/division list found."
    #define SCHOOLSTUDENTLIST @"Student list not available"
    #define SCHOOLTEACHERLIST @"Teacher list not found"
    #define SCHOOLSAVERECORD @"Record not save."
    #define SCHOOLUPDATERECORD @"Record not update"
    #define SCHOOLNOTGROUPEDIT @"No group edit."
    #define SCHOOLREMOVEMEMBER @"No member removed."
    #define SCHOOLGROUPDELETE @"Group delete successfully."


#pragma mark - profile-institute/blog alert

    #define PAGEDETAIL @"No institute page detail found."
    #define BLOGDETAIL @"No blog detail found."

#pragma mark - forgot password 

    #define PASSWORDWRONG @"Please enter right password."
    #define NUMBERVALID @"Enter valid number"

#pragma mark - friendvc list

    #define FRIENDSEARCH @"Search result not found"

#pragma mark - health record 

    #define HEALTHRECORD @"No health record create."
    #define HEALTHGET @"No health record found."

#pragma mark - holiday alert

    #define HOLIDAYLIST @"No holiday list found"

#pragma mark - listselection

    #define LISTGET @"No list found."

#pragma mark - loginVc

    #define LOGINWRONGPASSWORDUSER @"User id or password wrong"
    #define ROLLLIST @"No roll list found"

#pragma mark - message vc

    #define MESSAGELIST @"No list found."

#pragma mark - myprofile

    #define PROFILEPICNOTUPDATE @"No profile image update."

#pragma mark - otp Password

    #define OTPWRONG @"Wrong user id or otp"

#pragma mark - pageVc

    #define PAGELIST @"No list found"

#pragma mark - postdetailvc

    #define POSTDETAIL "No post detail found"

#pragma mark - profileaddupdatedetailvc(happygram)

    #define PROFILEADDUPDATE @"Record not update."
    #define HAPPYGRAMELIST @"Happygram list not update."

#pragma mark - parentprofilevc

    #define PARENTPROFILE @"No parent profile data available"
    #define PROFILEUPDATE @"No record update"
    #define PROFILEPARENTIMAGEUPLOAD @"Image not upload."
    #define FATHERPROFILE @"No father profile data found."
    #define PARENTNOTUPDATE @"Profile not update"
    #define MOTHERPROFILE @"No mother profile data found."
    #define MOTHERUPDATE @"No mother profile update"
    #define GUARDIANPROFILE @"No guardian data found"
    #define PROFILECREATEUPDATE @"No profile create or update."

#pragma mark - photoalbumvc 

    #define PHOTOLIST @"No list found."
    #define IMEAGENOTADDALBUM @"No image add into album."
    #define NOIMAGEUPLOAD @"Image not upload"

#pragma mark - profiledivisionvc

    #define PROFILEDIVISION @"No division list found"

#pragma mark - profileFriendRequest

    #define PROFILEFRIENDREQUEST @"Search record not found"
    #define FRIENDREQUESTACCEPT @"No friend request accept."
    #define FRINEDDECLINE @"No friend request decline."

#pragma mark - profileleavedetailvc

    #define LEAVELIST @"No leave detail found"

#pragma mark - profileleavelistselectionvc

    #define LEAVESELECTION @"No list found"

#pragma mark - profilephonechain

    #define PHONELIST @"Contact list not available"
    #define PHONERECORDNOTDELETE @"Record not delete"

#pragma mark - profilesearchfriend

    #define FRIENDREQUEST @"Friend request not send."

#pragma mark - profilestandardvc

    #define PROFILESTANDARD @"No standard list found"

#pragma mark - profilestudentleavevc

    #define PROFILESTUDENT @"Student list not found"
    #define RECORDNOTSAVE @"Record not update"

#pragma mark - profilesubjectvc

    #define PROFILESUBJECT @"No subject list found"

#pragma mark - profilevideolist

    #define PROFILEVIDEOLIST @"No video list found"

#pragma mark - projectVc

    #define PROJECTLIST @"No project list found"
    #define PROJECTDELETERCORD @"Record not delete"

#pragma mark - ptcommunicationvc

    #define PTCOMMUNICATIONLIST @"No ptcommunication list found"

#pragma mark - RegisterOtpvc

    #define REGISTERWRONGPASSWORD @"User id or password wrong"
    #define REGISTERUSERWRONG @"Userid or password wrong"
    #define REGISTERGCMNOT @"GCM not update"
    #define REGISTERROLLIST @"User roll list not found"

#pragma mark - Registervc

    #define REGISTERMOBILE @"Another Person is already Registerd on this Device...!!!"

#pragma mark - remindervc

    #define  RECORDNOTFOUND @"Record not insert or update."

#pragma mark - schoolvc

    #define SCHOOLPRAYERLIST @"School player not found"

#pragma mark -schoolgroupvc

    #define SCHOOLGROUPLIST @"No school group list found"
    #define SCHOOlGROUPREMOVE @"No group remove"

#pragma mark - singleWallvc

    #define WALLIST @"No wall post list found"
    #define POSTUNLIKE @"No post unlike"
    #define POSTLIKE @"No post like"
    #define POSTNOTSHARE @"Post not share"
    #define NOFRIENDLIST @"Friend list found"

#pragma mark - studentlistvc

    #define STUDENTLIST @"Student list not found"
    #define TEACHERLIST @"Teacher list not found"

#pragma mark - timetablevc

    #define TIMETABLELIST @"Time table not available"

#pragma mark - wallvc

    #define UPLOADPOSTFILE @"File not upload"
    #define POSTNOTFOUND @"No post available"


    #define LOGINAPI @"Userid or password wrong"

    #define USERROLLIST @"User roll list not found"

    #define MEMBERLIST @"No member list found"

    #define MENULIST @"No list found"

    #define POSTDELETE @"Post not delete"

    #define POSTSHAREWALL @"Post not share"

    #define POSTFRIENDLIST @"No friend list found"

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

#import "CMPopTipView.h"
#import "ResultAddPageVc.h"

#import "FBProgressView.h"
#import "ResultAddPageCell.h"

#import "ProfileHappyGramListdetailListVc.h"
#import "ProfileAddUpdateListDetailListVc.h"

#import "ProfileLeaveListSelectVc.h"
#import "ProfileLeaveDetailListVc.h"

#import "ReminderDetailVc.h"

#import "ProfileStudentLeaveVc.h"

#import "profileSearchFriend.h"


#import "ProjectVc.h"
#import "ORGDetailViewController.h"
#import "ORGContainerCell.h"
#import "ORGContainerCellView.h"
#import "CreateProjectVc.h"

#import "ORGContainerCellView.h"
#import "ORGArticleCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "AddCommentVc.h"
#import "IQKeyboardManager.h"

#import "RapidVoiceCommands.h"



#import "ProfilePhoneChainVc.h"

#import "HTMLLabel.h"
#import "WallCustomeCell.h"
#import "PostDetailVC.h"


#import "ProfilePhoneChainVc.h"
#import "HTMLLabel.h"
#import "WallCustomeCell.h"
#import "PostDetailVC.h"
#import "ViewController.h"

#import "HealthRecordVc.h"
#import "HMSegmentedControl.h"

#import "ParentProfileVc.h"
#import "SingleWallVC.h"

#import "ProfileVideoDetailVc.h"

#import "ChatVc.h"
#import "AddAlbumVCViewController.h"

#import "ParallaxViewController.h"

#pragma mark - YOUTube Video Key

#define YouTubeVideo_Key  @"SII1LZqIAas"

#pragma mark - Api Url And Name List

#define URL_Api  @"http://orataro.com/Services/"
//#define URL_Api  @"http://beta.orataro.com/Services/"

#define URL_CSS_File  @"http://orataro.com/Content/bootstrap.css"

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
#define apk_ChangePassword_action @"ChangePassword"
#define apk_GetUserRoleRightList_action @"GetUserRoleRightList"
#define apk_ChangeGCMID @"ChangeGCMID"
#define apk_SaveLoginLog_action @"SaveLoginLog"

#pragma mark - Image Url

#define apk_ImageUrl @"http://orataro.com/DataFiles"
#define apk_ImageUrlFor_HomeworkDetail @"http://orataro.com"


#pragma mark - GenaralWall and MyWall

#define IS_ALLOW_SETTING @"YES"
//
//#define IS_USER_LIKE_WALL = "IsAllowPeopleToLikeAndDislikeCommentWall";
//#define IS_USER_DISLIKE_WALL = "IsAllowPeopleToLikeAndDislikeCommentWall";
//#define IS_USER_SHARE_WALL = "IsAllowPeopleToShareCommentWall";
//#define IS_USER_COMMENT_WALL = "IsAllowPeoplePostCommentWall";
//
//#define IS_USER_LIKE = "IsAllowPeopleToLikeOrDislikeOnYourPost";
//#define IS_USER_DISLIKE = "IsAllowPeopleToLikeOrDislikeOnYourPost";
//#define IS_USER_COMMENT = "IsAllowPeopleToPostMessageOnYourWall";
//#define IS_USER_SHARE = "IsAllowPeopleToShareYourPost";


#pragma mark - Ganara Wall

#define apk_generalwall  @"apk_generalwall.asmx"
#define apk_GetGeneralWallData_action  @"GetGeneralWallData"
#define apk_GetDynamicWallData_action  @"GetDynamicWallData"
#define apk_GetMyWallData_action  @"GetMyWallData"
#define apk_GetWallMember_action  @"GetWallMember"
#define apk_DeletePost_action  @"DeletePost"
#define apk_EditPostDetails_action  @"EditPostDetails"


#define apk_post  @"apk_post.asmx"
#define apk_LikePost_action  @"LikePost"
#define apk_DisLikePost_action  @"DisLikePost"
#define apk_SharePost_action  @"SharePost"
#define apk_UploadFile_action  @"UploadFile"
#define apk_Post_action  @"Post"
#define apk_GetPostedPics_action  @"GetPostedPics"
#define apk_UploadFile @"UploadFile"

#pragma mark - apk_getwallpostcomment

#define apk_getwallpostcomment  @"apk_getwallpostcomment.asmx"
#define apk_GetWallPostComments_action  @"GetWallPostComments"
#define apk_AddComments_action  @"AddComments"


#pragma mark - Circular

#define apk_circular  @"apk_circular.asmx"
#define apk_GetCircularList_action  @"GetCircularList"

#define apk_gradedivisionsubject @"apk_gradedivisionsubject.asmx"
#define apk_CreateCircularWithMulty_action @"CreateCircularWithMulty"
#define apk_GetGradeDivisionSubjectbyTeacher_action @"GetGradeDivisionSubjectbyTeacher"
#define apk_LeaveCountByGradeDivision @"LeaveCountByGradeDivision"

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
#define apk_AttendanceListForStudent @"AttendanceListForStudent"
#define apk_AttendanceReport @"AttendanceReport"


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
#define apk_SendFriendRequest_action @"SendFriendRequest"
#define apk_ApproveRequest_action @"ApproveRequest"
#define apk_DeleteRequest_action @"DeleteRequest"


#pragma mark - apk_Photo

#define apk_Photos @"apk_Photos.asmx"
#define apk_GetPhotoList_action @"GetPhotoList"
#define apk_AddPhotos @"AddPhotos"


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

#define apk_PTCommunicationChatHistory_action @"PTCommunicationChatHistory"
#define apk_PTCommunicationChatHistorySetViewFlag @"PTCommunicationChatHistorySetViewFlag"
#define apk_WriteCommentsInPTCommnunication @"WriteCommentsInPTCommnunication"

#pragma mark - PostedImage

#define apk_apk_Post @"apk_Post.asmx"
#define apk_GetPosted_FileImgaeVideos @"GetPosted_FileImgaeVideos"
#define apk_AddAlbum @"AddAlbum"

#pragma mark -  Timetable

#define apk_timetable  @"apk_timetable.asmx"
#define apk_GetTimeTableListForTeachert_action @"GetTimeTableListForTeacher"

#pragma mark - Notes

#define apk_notes  @"apk_notes.asmx"
#define apk_GetNotesList_action @"GetNotesList"
#define apk_CreateNotesWithMulty_action @"CreateNotesWithMulty"

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
#define apk_GetStudentsListNameAndMemberID @"GetStudentsListNameAndMemberID"
#define apk_GetTeacherListNameAndMemberID @"GetTeacherListNameAndMemberID"
#define apk_StuGroup @"StuGroup"
#define apk_Remove_GroupMembers @"Remove_GroupMembers"

#pragma mark - Todos

#define apk_todos  @"apk_todos.asmx"
#define apk_GetToDosList_action  @"GetToDosList"
#define apk_SaveUpdateTodos_action  @"SaveUpdateTodos"
#define apk_DeleteToDos_action  @"DeleteToDos"

#pragma mark - apk_notifications

#define apk_notifications  @"apk_notifications.asmx"
#define apk_NotificationGetList_action  @"NotificationGetList"
#define apk_SetViewFlageOnNotification_action  @"SetViewFlageOnNotification"
#define apk_SendPushNotification_action  @"SendPushNotification"
#define apk_MemberAllTypeOfCounts_action @"MemberAllTypeOfCounts"

#pragma mark - apk_poll

#define apk_poll  @"apk_poll.asmx"
#define apk_GetPollsListForAddPage_action  @"GetPollsListForAddPage"
#define apk_GetPollsListForParticipantPage_action  @"GetPollsListForParticipantPage"
#define apk_SavePollOptionVote_action  @"SavePollOptionVote"
#define apk_SaveUpdatePolls_action  @"SaveUpdatePolls"
#define apk_GetPollForEdit_action  @"GetPollForEdit"
#define apk_PollDelete_action  @"PollDelete"
#define apk_GetPollResult_action  @"GetPollResult"
#define apk_ShareResult_action  @"ShareResult"


#pragma mark - apk_notes  - AssociationDelete

#define apk_AssociationDelete_action  @"AssociationDelete"

#pragma mark - apk_HappyGramme

#define apk_happygram @"apk_happygram.asmx"
#define apk_StudentHappyGramSelectForListing_action @"StudentHappyGramSelectForListing"
#define apk_GetStudentListForAddNewHappyGram_action @"GetStudentListForAddNewHappyGram"
#define apk_StudentHappyGramSelectForListing @"StudentHappyGramSelectForListing"
#define apk_AddHappyGramData @"AddHappyGramData"
#define apk_UpdateSingleStudentHappyGram @"UpdateSingleStudentHappyGram"

#pragma mark - apk_Institute

#define apk_GetUserDynamicMenuData @"GetUserDynamicMenuData"

#pragma mark - apk_leave

#define apk_leave @"apk_leave.asmx"
#define apk_LeaveAppList_action @"LeaveAppList"
#define apk_ChangeLeaveStatus @"ChangeLeaveStatus"

#pragma mark - apk_projects

#define apk_projects @"apk_projects.asmx"

#define apk_GetProjectList_action  @"GetProjectList"
#define apk_PrjectDataByID_action  @"PrjectDataByID"
#define apk_saveupdateproject_action @"saveupdateproject"
#define apk_DeleteProjects_action @"DeleteProjects"
#define apk_RemoveProjectGroupMembers @"RemoveProjectGroupMembers"

#pragma mark - apk_getStandardList

#define apk_GetGradeDivisionSubject @"GetGradeDivisionSubject"

#pragma mark - apk_phonebook

#define apk_phonebook @"apk_phonebook.asmx"
#define apk_GetPhoneBook @"GetPhoneBook"
#define apk_CreatePhoneBook @"CreatePhoneBook"
#define apk_DeletePhoneBook @"DeletePhoneBook"

#pragma mark - apk_CreateHealthRecord

#define apk_healthrecord @"apk_healthrecord.asmx"
#define apk_CreateHealthRecord @"CreateHealthRecord"
#define apk_GetHealthRecord @"GetHealthRecord"


#pragma mark - apk_parentprofile

#define apk_parentprofile @"apk_parentprofile.asmx"
#define apk_GetParentProfile @"GetParentProfile"
#define apk_CreateParentProfile @"CreateParentProfile"


#pragma mark - apk_profile.asmx

#define apk_profile @"apk_profile.asmx"
#define GetStudentProfileData @"GetStudentProfileData"
#define UpdateStudentProfileData @"UpdateStudentProfileData"

#pragma mark - Change Student Profile API

#define apk_ChnageProfilePhotos @"ChnageProfilePhotos"



#endif /* Global_h */

