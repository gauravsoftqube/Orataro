//
//  AddClassWorkVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 31/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AddClassWorkVc.h"
#import "Global.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "UIImage+ImageCompress.h"

@interface AddClassWorkVc ()
{
    UIDatePicker *datePicker,*timepicker;
    UIAlertView *alert,*alert1;
}
@end

@implementation AddClassWorkVc
@synthesize aSelectBtn,aViewWidth,aViewHeight,aEndTextField,aEnddaTextfield,aStartTextField,aTitleTextField,aDescriptionTextView,aReferenceLinkTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [Utility setLeftViewInTextField:aEndTextField imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:aEnddaTextfield imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:aStartTextField imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:aTitleTextField imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:aReferenceLinkTextField imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    aDescriptionTextView.textContainerInset = UIEdgeInsetsMake(10, 1, 0, 0);
    
    //
    CGRect frame = CGRectMake(0, 0, 200, 200);
    datePicker = [[UIDatePicker alloc] initWithFrame:frame];
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate *Date=[NSDate date];
    datePicker.minimumDate=Date;
    
    alert = [[UIAlertView alloc]
             initWithTitle:@"Select Date"
             message:nil
             delegate:self
             cancelButtonTitle:@"OK"
             otherButtonTitles:@"Cancel", nil];
    alert.delegate = self;
    alert.tag = 2;
    [alert setValue:datePicker forKey:@"accessoryView"];
    
    timepicker = [[UIDatePicker alloc] initWithFrame:frame];
    timepicker = [[UIDatePicker alloc] init];
    timepicker.datePickerMode = UIDatePickerModeTime;
    
    alert1 = [[UIAlertView alloc]
              initWithTitle:@"Select Time"
              message:nil
              delegate:self
              cancelButtonTitle:@"OK"
              otherButtonTitles:@"Cancel", nil];
    alert1.delegate = self;
    alert1.tag = 3;
    [alert1 setValue:timepicker forKey:@"accessoryView"];
    
    //set Header Title
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Add Classwork (%@)",[arr objectAtIndex:0]];
    }
    else
    {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Add Classwork"];
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark - ActionSheet Delegates

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

#pragma mark - UIImagePicker Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *selectImage = info[UIImagePickerControllerOriginalImage];
    [aSelectBtn setBackgroundImage:selectImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - UIButton Action

- (IBAction)selectPhotoBtnClicked:(id)sender
{
    [self.view endEditing:YES];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Attach image" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* pickFromGallery = [UIAlertAction actionWithTitle:@"Take a photo"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                                                {
                                                                    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
                                                                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                                    picker.delegate = (id)self;
                                                                    [self presentViewController:picker animated:YES completion:NULL];
                                                                }
                                                                
                                                            }];
    UIAlertAction* takeAPicture = [UIAlertAction actionWithTitle:@"Choose from gallery"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             UIImagePickerController* picker = [[UIImagePickerController alloc] init];
                                                             picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                             picker.delegate = (id)self;
                                                             [self presentViewController:picker animated:YES completion:NULL];
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

- (IBAction)BackBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSaveClicked:(id)sender
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:aTitleTextField.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CIRCULAR_TITLE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:self.aDescriptionTextView.text] || [self.aDescriptionTextView.text isEqualToString:@"Description"])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CIRCULAR_DESC delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:aStartTextField.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@SELECT_STARTTIME delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:aEndTextField.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@SELECT_ENDTIME delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:aEnddaTextfield.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@CIRCULAR_ENDDATE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:aReferenceLinkTextField.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CLASSWORK_REFERNCELINK delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    [self apiCallFor_createClassWork];
}

- (IBAction)btnStartTimeClicked:(id)sender
{
    [self.view endEditing:YES];
    _btnStartTime.tag =1;
    _btnEndTime.tag = 0;
    
    if (alert1.tag == 3)
    {
        [alert1 show];
    }
}

- (IBAction)btnEndTimeClicked:(id)sender
{
    [self.view endEditing:YES];
    _btnEndTime.tag = 1;
    _btnStartTime.tag =0;
    
    if (alert1.tag == 3)
    {
        [alert1 show];
    }
}

- (IBAction)btnEndDateClicked:(id)sender
{
    [self.view endEditing:YES];
    if (alert.tag == 2)
    {
        //   [datePicker setDate:[NSDate date]];
        [alert show];
    }
    
}

#pragma mark - Alertview Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2)
    {
        if (buttonIndex == 0)
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            aEnddaTextfield.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
        
    }
    if (alertView.tag == 3)
    {
        if (buttonIndex == 0)
        {
            if(_btnStartTime.tag == 1)
            {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"HH:mm"];
                NSString *theDate = [dateFormat stringFromDate:[timepicker date]];
                aStartTextField.text = theDate;
            }
            if(_btnEndTime.tag == 1)
            {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"HH:mm"];
                NSString *theDate = [dateFormat stringFromDate:[timepicker date]];
                aEndTextField.text = theDate;
            }
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
    }
}

#pragma mark - add Classwork API

-(void)apiCallFor_createClassWork
{
    //EditID=null
    // WallID=3f553bdf-a302-410f-ab2f-a82bd5aca7b5
    // title=tgfdf
    // GradeID=5bab2f94-61b6-46b5-9cec-e3023b118f91
    // DivisionID=44de9eed-96af-43cf-a5ee-7cc63d9753ed
    // SubjectID=17fd6989-eac1-462b-ac6e-2c7bd08994c2
    // ReferenceLink=www.google.com
    // DateOfClassWork=03-07-2017
    // DateOfCompletion=03-07-2017
    // StartTime=14:19
    // EndTime=16:20
    // ClassWorksDetails=ferff
    // MemberID=f1a6d89d-37dc-499a-9476-cb83f0aba0f2
    // ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    // InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    // UserID=30032284-31d1-4ba6-8ef4-54edb8e223aa
    // BeachID=null
    // File=[B@25a0a2f
    // FileName=IMG-20170307-WA0001.jpg
    // FileType=IMAGE
    // FileMineType=
    
    
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
   
    
    // NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
    /*  NSDate *Date=[NSDate date];
     NSDateFormatter *df=[[NSDateFormatter alloc]init];
     [df setDateFormat:@"MM-dd-yyyy"];
     NSString *strCurrentDate=[df stringFromDate:Date];*/
    
    /*[param setValue:@"" forKey:@"EditID"];
     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
     [param setValue:[NSString stringWithFormat:@"%@",aTitleTextField.text] forKey:@"title"];
     [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectListSelection objectForKey:@"GradeID"]] forKey:@"GradeID"];
     
     [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectListSelection objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
     [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectListSelection objectForKey:@"SubjectID"]] forKey:@"SubjectID"];
     [param setValue:aReferenceLinkTextField.text forKey:@"ReferenceLink"];
     
     
     [param setValue:[NSString stringWithFormat:@"%@",strCurrentDate] forKey:@"DateOfClassWork"];
     
     [param setValue:[NSString stringWithFormat:@"%@",[Utility convertDateFtrToDtaeFtr:@"dd-MM-yy" newDateFtr:@"MM-dd-yyyy" date:aEnddaTextfield.text]] forKey:@"DateOfCompletion"];
     
     [param setValue:aStartTextField.text forKey:@"StartTime"];
     
     [param setValue:aEndTextField.text forKey:@"EndTime"];
     
     [param setValue:aDescriptionTextView.text forKey:@"ClassWorksDetails"];
     
     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
     
     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
     
     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
     
     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
     
     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
     
     // UIImage *getImageAfterResize  = [self resizeImage:aSelectBtn.currentBackgroundImage];
     
     UIImage *getImageAfterResize  =  [Utility imageWithImage:aSelectBtn.currentBackgroundImage scaledToSize:CGSizeMake(100, 100) isAspectRation:YES];
     
     NSData *data = UIImagePNGRepresentation(getImageAfterResize);
     const unsigned char *bytes = [data bytes];
     NSUInteger length = [data length];
     NSMutableArray *byteArray = [NSMutableArray array];
     for (NSUInteger i = 0; i < length; i++)
     {
     [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
     }
     [param setValue:byteArray forKey:@"File"];
     [param setValue:[NSString stringWithFormat:@"%@.png",[Utility randomImageGenerator]] forKey:@"FileName"];
     [param setValue:[NSString stringWithFormat:@"IMAGE"] forKey:@"FileType"];
     
     [param setValue:[NSString stringWithFormat:@""] forKey:@"FileMineType"];*/
    
    
    /* NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
     NSDate *Date=[NSDate date];
     NSDateFormatter *df=[[NSDateFormatter alloc]init];
     [df setDateFormat:@"MM-dd-yyyy"];
     
     NSString *strCurrentDate=[df stringFromDate:Date];
     
     NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
     
     AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
     manager.requestSerializer = [AFHTTPRequestSerializer serializer];
     
     NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
     [params setValue:@"multipart/form-data" forKey:@"Content-Type"];
     
     [manager POST:[NSString stringWithFormat:@"%@",strURL] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
     
     NSData *imageData = UIImageJPEGRepresentation(aSelectBtn.currentBackgroundImage,1.0);
     
     [formData appendPartWithFileData:imageData
     name:@"File"
     fileName:@"photo.jpg" mimeType:@"image/jpeg"];
     
     [formData appendPartWithFormData:[@"" dataUsingEncoding:NSUTF8StringEncoding]name:@"EditID"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] dataUsingEncoding:NSUTF8StringEncoding]name:@"WallID"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",aTitleTextField.text]dataUsingEncoding:NSUTF8StringEncoding]name:@"title"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"GradeID"]] dataUsingEncoding:NSUTF8StringEncoding]name:@"GradeID"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"DivisionID"]] dataUsingEncoding:NSUTF8StringEncoding]name:@"DivisionID"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"SubjectID"]] dataUsingEncoding:NSUTF8StringEncoding]name:@"SubjectID"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",aReferenceLinkTextField.text]dataUsingEncoding:NSUTF8StringEncoding]name:@"ReferenceLink"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",strCurrentDate]dataUsingEncoding:NSUTF8StringEncoding]name:@"DateOfClassWork"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",[Utility convertDateFtrToDtaeFtr:@"dd-MM-yy" newDateFtr:@"MM-dd-yyyy" date:aEnddaTextfield.text]]dataUsingEncoding:NSUTF8StringEncoding]name:@"DateOfCompletion"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",strCurrentDate]dataUsingEncoding:NSUTF8StringEncoding]name:@"DateOfClassWork"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",aStartTextField.text]dataUsingEncoding:NSUTF8StringEncoding]name:@"StartTime"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",aEndTextField.text]dataUsingEncoding:NSUTF8StringEncoding]name:@"EndTime"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",aDescriptionTextView.text]dataUsingEncoding:NSUTF8StringEncoding]name:@"ClassWorksDetails"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] dataUsingEncoding:NSUTF8StringEncoding]name:@"MemberID"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] dataUsingEncoding:NSUTF8StringEncoding]name:@"ClientID"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] dataUsingEncoding:NSUTF8StringEncoding]name:@"InstituteID"];
     
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] dataUsingEncoding:NSUTF8StringEncoding]name:@"UserID"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] dataUsingEncoding:NSUTF8StringEncoding]name:@"BeachID"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@.jpg",[Utility randomImageGenerator]] dataUsingEncoding:NSUTF8StringEncoding]name:@"FileName"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",@"IMAGE"] dataUsingEncoding:NSUTF8StringEncoding]name:@"FileType"];
     
     [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",@""] dataUsingEncoding:NSUTF8StringEncoding]name:@"FileMineType"];
     
     
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
     {
     NSLog(@"response success %@",responseObject);
     
     } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error)
     {
     NSLog(@"Error: %@", task.response.description);
     }];*/
    
    
    /* NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
     
     [param setValue:@"" forKey:@"EditID"];
     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
     [param setValue:[NSString stringWithFormat:@"%@",aTitleTextField.text] forKey:@"title"];
     [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectListSelection objectForKey:@"GradeID"]] forKey:@"GradeID"];
     
     [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectListSelection objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
     [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectListSelection objectForKey:@"SubjectID"]] forKey:@"SubjectID"];
     [param setValue:aReferenceLinkTextField.text forKey:@"ReferenceLink"];
     
     
     [param setValue:[NSString stringWithFormat:@"%@",strCurrentDate] forKey:@"DateOfClassWork"];
     
     [param setValue:[NSString stringWithFormat:@"%@",[Utility convertDateFtrToDtaeFtr:@"dd-MM-yy" newDateFtr:@"MM-dd-yyyy" date:aEnddaTextfield.text]] forKey:@"DateOfCompletion"];
     
     [param setValue:aStartTextField.text forKey:@"StartTime"];
     
     [param setValue:aEndTextField.text forKey:@"EndTime"];
     
     [param setValue:aDescriptionTextView.text forKey:@"ClassWorksDetails"];
     
     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
     
     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
     
     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
     
     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
     
     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
     [param setValue:byteArray forKey:@"File"];
     [param setValue:[NSString stringWithFormat:@"%@.png",[Utility randomImageGenerator]] forKey:@"FileName"];
     [param setValue:[NSString stringWithFormat:@"IMAGE"] forKey:@"FileType"];
     
     [param setValue:[NSString stringWithFormat:@""] forKey:@"FileMineType"];*/
    
    
    
    
    /*  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
     [request setURL:[NSURL URLWithString:strURL]];
     [request setHTTPMethod:@"POST"];
     NSMutableData *body = [NSMutableData data];
     NSString *boundary = @"---------------------------14737809831466499882746641449";
     NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
     [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
     
     //EditID
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"EditID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"" dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //WallID
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"WallID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //title
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"title\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[aTitleTextField.text dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //GradeID
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"GradeID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@",[self.dicSelectListSelection objectForKey:@"GradeID"]] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //DivisionID
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"DivisionID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@",[self.dicSelectListSelection objectForKey:@"DivisionID"]] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //SubjectID
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"SubjectID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@",[self.dicSelectListSelection objectForKey:@"SubjectID"]] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //ReferenceLink
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ReferenceLink\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[aReferenceLinkTextField.text dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //DateOfClassWork
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"DateOfClassWork\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@",strCurrentDate] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //DateOfCompletion
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"DateOfCompletion\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@",[Utility convertDateFtrToDtaeFtr:@"dd-MM-yy" newDateFtr:@"MM-dd-yyyy" date:aEnddaTextfield.text]] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //StartTime
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"StartTime\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[aStartTextField.text dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //EndTime
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"EndTime\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[aEndTextField.text dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //ClassWorksDetails
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ClassWorksDetails\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[aDescriptionTextView.text dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //MemberID
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"MemberID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //ClientID
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ClientID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //InstituteID
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"InstituteID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //UserID
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"UserID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //BeachID
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"BeachID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //File Pass image
     
     NSData *photo1 = UIImagePNGRepresentation(aSelectBtn.currentBackgroundImage);
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"File\"; filename=\"%@\"\r\n",[Utility randomImageGenerator]]] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[NSData dataWithData:photo1]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //FileName
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"FileName\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@.png",[Utility randomImageGenerator]]  dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //FileType
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"FileType\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"IMAGE" dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //FileMineType
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"FileMineType\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"" dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     // close form
     [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     
     [request setHTTPBody:body];
     [request setTimeoutInterval:60];
     
     NSLog(@"++++++++++++++%@", request.URL);
     
     NSOperationQueue *queue = [[NSOperationQueue alloc] init];
     
     [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
     dispatch_async(dispatch_get_main_queue(), ^{
     
     @try
     {
     //   NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
     NSLog(@"JSON1 =%@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
     
     
     NSDictionary  *JSON1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
     
     NSLog(@"JSON1 =%@",JSON1);
     }
     @catch (NSException *exception)
     {
     
     NSLog(@"exception is >>>>%@",exception);
     }
     });
     }];*/
    
     //NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_classwork,apk_CreateClassWork_action];
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_classwork,apk_CreateClassWork_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:@"" forKey:@"EditID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    [param setValue:[NSString stringWithFormat:@"%@",aTitleTextField.text] forKey:@"title"];
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectListSelection objectForKey:@"GradeID"]] forKey:@"GradeID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectListSelection objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectListSelection objectForKey:@"SubjectID"]] forKey:@"SubjectID"];
    [param setValue:aReferenceLinkTextField.text forKey:@"ReferenceLink"];
    
    NSDate *Date=[NSDate date];
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM-dd-yyyy"];
    NSString *strCurrentDate=[df stringFromDate:Date];
    [param setValue:[NSString stringWithFormat:@"%@",strCurrentDate] forKey:@"DateOfClassWork"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[Utility convertDateFtrToDtaeFtr:@"dd-MM-yy" newDateFtr:@"MM-dd-yyyy" date:aEnddaTextfield.text]] forKey:@"DateOfCompletion"];
    
    [param setValue:aStartTextField.text forKey:@"StartTime"];
    
    [param setValue:aEndTextField.text forKey:@"EndTime"];
    
    [param setValue:aDescriptionTextView.text forKey:@"ClassWorksDetails"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
    NSData *data = UIImagePNGRepresentation(aSelectBtn.currentBackgroundImage);
    const unsigned char *bytes = [data bytes];
    NSUInteger length = [data length];
    NSMutableArray *byteArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < length; i++)
    {
        [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
    }
    [param setValue:byteArray forKey:@"File"];
    [param setValue:[NSString stringWithFormat:@"%@.png",[Utility randomImageGenerator]] forKey:@"FileName"];
    [param setValue:[NSString stringWithFormat:@"IMAGE"] forKey:@"FileType"];
    
    [param setValue:[NSString stringWithFormat:@""] forKey:@"FileMineType"];
    
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
                 
                 if([strStatus isEqualToString:@"ClassWork Created SuccessFully...!!"])
                 {
                     for (UIViewController *controller in self.navigationController.viewControllers)
                     {
                         if ([controller isKindOfClass:[ClassworkVC class]])
                         {
                             [self.navigationController popToViewController:controller animated:YES];
                             
                             break;
                         }
                     }
                     
                 }
                 else
                 {
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


-(UIImage *)resizeImage:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 300.0;
    float maxWidth = 400.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth)
    {
        if(imgRatio < maxRatio)
        {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio)
        {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else
        {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithData:imageData];
    
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
