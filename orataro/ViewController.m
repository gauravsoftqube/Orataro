//
//  ViewController.m
//  orataro
//
//  Created by harikrishna patel on 25/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ViewController.h"
#import "RegisterVc.h"
#import "LoginVC.h"
#import "ForgotPassVc.h"
#import "WallVc.h"

#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

- (IBAction)EngBtnClicked:(id)sender
{
    WallVc *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
    
    [self.navigationController pushViewController:wc animated:YES];
    
}
#pragma mark - APICall
-(void)postmethod
{
    ///////////////////////////////////////////////////////////////////
    
   // NSString *str=[NSString stringWithFormat:@"%@registration.php",appdel.baseUrl];
    //NSURL *url = [NSURL URLWithString: @"http://symphonyirms.softcube.in/Services/apk_investor.asmx/AddEditInvestor"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://symphonyirms.softcube.in/Services/apk_investor.asmx/AddEditInvestor"]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"text/html; charset=utf-8; boundary=%@",boundary];
    
    NSString *contentType1 = [NSString stringWithFormat:@"text/html; charset=utf-8; boundary=%@",boundary];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
     [request addValue:contentType1 forHTTPHeaderField: @"Content-Type"];
    
     // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
  
//    <InvestorID>string</InvestorID>
//    <Name>string</Name>
//    <MobileNo>string</MobileNo>
//    <RefID>string</RefID>
//    <RefName>string</RefName>
//    <BCardFileName>string</BCardFileName>
//    <BCardFile>base64Binary</BCardFile>
//    <IDProofFileName>string</IDProofFileName>
//    <IDProof>base64Binary</IDProof>
//    <TermConditions>string</TermConditions>
//    <CompanyID>string</CompanyID>
//    <UserID>string</UserID>
    
    
    //InvestorID
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"username\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //Name
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"abc" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    //MobileNo
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"MobileNo\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"1234567890" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    //RefID
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"RefID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"fb7f26f3-bf0a-4ba9-9a97-3a6b3dfc0caa" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //RefName
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"RefName\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"fb7f" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //BCardFileName
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"BCardFileName\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"a.jpg" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    //BCardFile
    
   // UIImage *yourImage = [UIImage imageNamed:@"user"];

  //  NSData *imageData = UIImagePNGRepresentation(yourImage);

   
    
//    NSString *base64 = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//     NSData *bytes = [[NSData alloc] initWithContentsOfFile:base64];
//    
//    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"BCardFile\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[base64 dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]
    
//    UIImage *yourImage = [UIImage imageNamed:@"user"];
//    NSData *imageData = UIImagePNGRepresentation(yourImage);
//    
//    [body appendData:[@"Content-Disposition: form-data; name=\"BCardFile\"; filename=\"a.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[NSData dataWithData:imageData]];
   // [body appendData:[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    
    //[body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //IDProofFileName
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"IDProofFileName\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"b.jpg" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //IDProof
    
//     UIImage *yourImage1 = [UIImage imageNamed:@"user"];
//    NSData *dataImage1 = UIImagePNGRepresentation(yourImage1);
//    [body appendData:[@"Content-Disposition: form-data; name=\"IDProof\"; filename=\"b.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[NSData dataWithData:imageData1]];
//    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    UIImage *yourImage1 = [UIImage imageNamed:@"user"];
    
    NSData *imageData1 = UIImagePNGRepresentation(yourImage1);
    
   // NSString *base641 = [imageData1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"IDProof\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //[body appendData:[base641 dataUsingEncoding:NSUTF8StringEncoding]];
    //[body appendData:base641];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //TermConditions
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"TermConditions\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"fb7fffdfdf" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //CompanyID

    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"CompanyID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"14f1a0dc-3a5b-4e7e-9869-96979a03ea3a" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //UserID
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"UserID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"281ef58f-bd5d-422a-a3e4-4edbf15f985c" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    [request setTimeoutInterval:60];
    NSLog(@"++++++++++++++%@", request.URL);

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             
             NSLog(@"rsponse=%@",response);
             @try
             {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                 NSLog(@"registration json is >>> %@", JSON);
                
                 
            }
             @catch (NSException *exception)
             {
                 
                 NSLog(@"exception is >>>>%@",exception);
             }
             
         });
     }];

    
    //(@"%@",dict);
    
    
 /*   NSString *url= [NSString stringWithFormat:@"http://symphonyirms.softcube.in/Services/apk_investor.asmx/AddEditInvestor"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"text/xml; charset=utf-8" forKey:@"Content-Type"];
    
    [manager POST:[NSString stringWithFormat:@"%@",url] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {

         UIImage *img = [UIImage imageNamed:@"user"];
         NSData *imageData = UIImageJPEGRepresentation(img,1.0);
         [formData appendPartWithFileData:imageData
                                     name:@"BCardFile"
                                 fileName:@"adsas.jpg" mimeType:@"image/jpg"];
         
         UIImage *img1 = [UIImage imageNamed:@"user"];
         NSData *imageData1 = UIImageJPEGRepresentation(img1,1.0);
         [formData appendPartWithFileData:imageData1
                                     name:@"IDProof"
                                 fileName:@"dsas.jpg" mimeType:@"image/jpg"];
         
         [formData appendPartWithFormData:[@"" dataUsingEncoding:NSUTF8StringEncoding]name:@"InvestorID"];
         
         [formData appendPartWithFormData:[@"abc" dataUsingEncoding:NSUTF8StringEncoding]name:@"Name"];
         
         [formData appendPartWithFormData:[@"1234567890" dataUsingEncoding:NSUTF8StringEncoding]name:@"MobileNo"];
         
         [formData appendPartWithFormData:[@"fb7f26f3-bf0a-4ba9-9a97-3a6b3dfc0caa" dataUsingEncoding:NSUTF8StringEncoding]name:@"RefID"];
         
         [formData appendPartWithFormData:[@"abc" dataUsingEncoding:NSUTF8StringEncoding]name:@"RefName"];
         
         [formData appendPartWithFormData:[@"sggsgsg" dataUsingEncoding:NSUTF8StringEncoding]name:@"TermConditions"];
  
         [formData appendPartWithFormData:[@"14f1a0dc-3a5b-4e7e-9869-96979a03ea3a" dataUsingEncoding:NSUTF8StringEncoding]name:@"CompanyID"];
         
         [formData appendPartWithFormData:[@"281ef58f-bd5d-422a-a3e4-4edbf15f985c" dataUsingEncoding:NSUTF8StringEncoding]name:@"UserID"];
         
         [formData appendPartWithFormData:[@"dshg.jpg" dataUsingEncoding:NSUTF8StringEncoding]name:@"BCardFileName"];
         
         [formData appendPartWithFormData:[@"sdhgs.jpg" dataUsingEncoding:NSUTF8StringEncoding]name:@"IDProofFileName"];
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
     {
         
         NSLog(@"Response =%@",responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", task.response.description);
         //[MBProgressHUD hideHUDForView:self.view animated:YES];
     }];*/
    
}

@end
