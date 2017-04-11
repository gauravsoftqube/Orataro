//
//  CreateScoolGroupVc.m
//  orataro
//
//  Created by Softqube on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CreateScoolGroupVc.h"
#import "Global.h"
#import "AppDelegate.h"

@interface CreateScoolGroupVc ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    AppDelegate *get;
}
@end

@implementation CreateScoolGroupVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    get = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    NSLog(@"value=%d",get.scoolgroup);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tblMemberList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    _btnTackeImage.layer.cornerRadius = 30.0;
    
    // Do any additional setup after loading the view.
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    [Utility setLeftViewInTextField:self.txtGroupTitle imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtGroupSubject imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtEducationGroup imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtGroupMemberTecher imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtGroupMemberStudent imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    if (get.scoolgroup == 1)
    {
        _aHeadreTitle.text = @"Create Group (kinjal)";
        self.tblMembrList_Height.constant=0;
    }
    else
    {
        NSLog(@"dic=%@",_dicCreateSchoolGroup);
        
        _aHeadreTitle.text = @"Edit Group (kinjal)";
        self.tblMembrList_Height.constant=105*5;
    }
}

#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UIImageView *img=(UIImageView *)[cell.contentView viewWithTag:2];
    
    [img.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
    [img.layer setBorderWidth:1.0f];
    
    // UILabel *lblName=(UILabel *)[cell.contentView viewWithTag:3];
    
    
    // UILabel *lblStatus=(UILabel *)[cell.contentView viewWithTag:4];
    
    
    UIButton *btnRemove=(UIButton *)[cell.contentView viewWithTag:5];
    [btnRemove.layer setCornerRadius:4];
    btnRemove.clipsToBounds=YES;
    
    return cell;
}


#pragma mark - UIImagePicker Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *selectImage = info[UIImagePickerControllerOriginalImage];
    [_btnTackeImage setBackgroundImage:selectImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIButton Action

- (IBAction)btnBackHeader:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)btnSubmitHeader:(id)sender
{
    // vALIDATION
    
//    @property (weak, nonatomic) IBOutlet UITextField *txtGroupTitle;
//    @property (weak, nonatomic) IBOutlet UITextField *txtGroupSubject;
//    @property (weak, nonatomic) IBOutlet UITextField *txtEducationGroup;
//    
//    @property (weak, nonatomic) IBOutlet UITextView *txtViewAbout;
//    @property (weak, nonatomic) IBOutlet UITextField *txtGroupMemberStudent;
//    @property (weak, nonatomic) IBOutlet UITextField *txtGroupMemberTecher;

    
    if ([Utility validateBlankField:_txtGroupTitle.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CIRCULAR_TITLE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;

    }
    if ([Utility validateBlankField:_txtGroupSubject.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:SUBJECT delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
        
    }
    if ([Utility validateBlankField:_txtGroupMemberStudent.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:SUBJECT delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:_txtGroupMemberTecher.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:SUBJECT delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    [self apiCallFor_createSchoolGroup];
    
}
- (IBAction)btnTackeImage:(id)sender
{
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

- (IBAction)btnMemberCkeckBoxMember:(id)sender
{
}
- (IBAction)btnMemberCkeckBoxPost:(id)sender
{
}
- (IBAction)btnMemberCkeckBoxAlbums:(id)sender
{
}
- (IBAction)btnMemberCkeckBoxAttachment:(id)sender
{
}
- (IBAction)btnMemberCkeckBoxPolls:(id)sender
{
}


- (IBAction)btnSelectEducationGroup:(id)sender
{
}
- (IBAction)btnSelectGroupMemberStudent:(id)sender
{
}
- (IBAction)btnSelectGroupMemberTecher:(id)sender
{
}

#pragma mark - Call Api

-(void)apiCallFor_createSchoolGroup
{
    //uncheck
    //tick_mark
    
    //#define apk_group @"apk_group.asmx"
    //#define apk_Group_List_action @"Group_List"
    //#define apk_Remove_Group_action @"Remove_Group"
    //#define apk_SaveUpdate_Group @"SaveUpdate_Group"
    
    //UserID=30032284-31d1-4ba6-8ef4-54edb8e223aa
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    //WallID=3f553bdf-a302-410f-ab2f-a82bd5aca7b5
    //MemberID=f1a6d89d-37dc-499a-9476-cb83f0aba0f2
    //GroupID=null
    //BeachID=null
    //AboutGroup=dhfhhdud
    //GroupSubject=xkfkfjfj
    //GroupTitle=group
    //GroupTypeID=c515b5fa-9349-4d83-bf25-1206eef5d606
    //IsAutoApprovePendingMember=true
    //IsAutoApprovePendingPost=true
    //IsAutoApprovePendingAlbums=true
    //IsAutoApprovePendingAttachment=true
    //IsAutoApprovePendingPolls=true
    //AllGroupMembers=e6f4c8a3-4a25-46da-a4db-2deb65745e48,c91676f8-9c7c-4509-be59-2e9b7de590f6,f78063ba-d5ae-45ef-8210-4223e1f59e66,2ca9305c-e842-44ae-b800-354ba4475625
    //File=null
    //FileName=null
}


@end
