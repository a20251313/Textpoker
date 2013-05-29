//
//  JFSharePanel.m
//  Texas-pokes
//
//  Created by ran on 13-1-21.
//
//

#import "JFSharePanel.h"
#import "PublicDefine.h"

#define SHAREPANELWIDTH       480
#define SHAREPANELHEIGHT      320

#define CONTENTWIDTH          290
#define CONTENTHEIGHT         240

#define SHARECONTENTVIEWTAG         2176423
#define PREPIC_VIEWTAG              2176424
@implementation JFSharePanel
@synthesize shareContent,shareImage,shareType,iSSendImage,shareContentType,shareBounds;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}



//type   2 is  sina   1 is  QQ
-(id)initWithShareType:(NSInteger)type
           content:(NSString *)strContent
             image:(UIImage*)image
shareContentType:(int8_t)ishareContentType
{
    CGRect   frame = CGRectMake(0, 0, SHAREPANELWIDTH, SHAREPANELHEIGHT);
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
        self.iSSendImage = YES;
        self.shareContent = strContent;
        self.shareType = type;
        self.shareImage = image;
        self.shareContentType = ishareContentType;
        
        UIImageView    *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SHAREPANELWIDTH-CONTENTWIDTH)/2, (SHAREPANELHEIGHT-CONTENTHEIGHT)/2, CONTENTWIDTH, CONTENTHEIGHT)];
        
        imageView.image = [UIImage imageNamed:@"dzpk_share_bg.png"];
        imageView.tag = SHARECONTENTVIEWTAG;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
    
        UIImageView     *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 18, 55, 55)];
        if (type == 2)
        {
            logoView.image = [UIImage imageNamed:@"dzpk_sina_share.png"];
        }else if (type == 1)
        {
            logoView.image = [UIImage imageNamed:@"dzpk_qq_share.png"];
        }
        
        [imageView addSubview:logoView];
        
        
        
        
        UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 120, 20)];
        label.text = NSLocalizedString(@"微博分享送筹码", nil);
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        [imageView addSubview:label];
        
        
        UIImageView    *SendimageChoose = [[UIImageView alloc] initWithFrame:CGRectMake(90, 45, 18, 18)];
        SendimageChoose.image = [UIImage imageNamed:@"dzpk_share_screenshot_NO.png"];
        SendimageChoose.userInteractionEnabled = YES;
        
        UITapGestureRecognizer    *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(modifySendImageAction:)];
        [SendimageChoose addGestureRecognizer:tap];
        [tap release];
        [imageView addSubview:SendimageChoose];
        
        UILabel   *labelSendImage = [[UILabel alloc] initWithFrame:CGRectMake(115, 45, 100, 20)];
        labelSendImage.text = NSLocalizedString(@"发送截图", nil);
        labelSendImage.font = [UIFont systemFontOfSize:13];
        labelSendImage.backgroundColor = [UIColor clearColor];
        labelSendImage.textColor = [UIColor whiteColor];
        [imageView addSubview:labelSendImage];
        
        
        UIImageView  *hookYesView = [[UIImageView alloc] initWithFrame:SendimageChoose.bounds];
        hookYesView.image = [UIImage imageNamed:@"dzpk_share_screenshot_YES.png"];
        [SendimageChoose addSubview:hookYesView];
        hookYesView.tag = 111;
        [hookYesView release];
        
        
        UIImageView   *pre_pic = [[UIImageView alloc] initWithFrame:CGRectMake(210, 42, 36, 26)];
        pre_pic.image = [UIImage imageNamed:@"dzpk_share_pic_pre.png"];
        pre_pic.userInteractionEnabled = YES;
        UITapGestureRecognizer  *tapGe = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(prePic:)];
        [pre_pic addGestureRecognizer:tapGe];
        [tapGe release];
        [imageView addSubview:pre_pic];
        [pre_pic release];
     
        
        
        
        
        
        
        UITextView   *contentView = [[UITextView alloc] initWithFrame:CGRectMake(20, 80, 250, 100)];
        contentView.text = strContent;
        contentView.delegate = self;
        [contentView setTextColor:[UIColor blackColor]];
        [contentView setFont:[UIFont systemFontOfSize:13]];
        contentView.layer.masksToBounds = YES;
        contentView.layer.cornerRadius = 5;
       // contentView.clearsOnInsertion = YES;
        [imageView addSubview:contentView];
        
        
      
        
        
        UIButton   *btnExit = [[UIButton alloc] initWithFrame:CGRectMake(40, 190, 90, 40)];
        [btnExit setTitle:NSLocalizedString(@"退出", nil) forState:UIControlStateNormal];
        [btnExit.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btnExit setBackgroundImage:[UIImage imageNamed:@"dzpk_share_exit.png"] forState:UIControlStateNormal];
        [btnExit addTarget:self
                    action:@selector(ExitSharePanel:)
          forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:btnExit];
        
        
        UIButton   *btnShare = [[UIButton alloc] initWithFrame:CGRectMake(160, 190, 90, 40)];
        [btnShare.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btnShare setBackgroundImage:[UIImage imageNamed:@"dzpk_share_btn.png"] forState:UIControlStateNormal];
        [btnShare setTitle:NSLocalizedString(@"分享", nil) forState:UIControlStateNormal];
        [btnShare addTarget:self
                    action:@selector(ShareContent:)
          forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:btnShare];
        
        
        
        /*UIImageView     *imageExitShare = [[UIImageView alloc] initWithFrame:CGRectMake(CONTENTWIDTH-7, -7, 15, 15)];
        imageExitShare.image = [UIImage imageNamed:@"close_btn_src_normal.png"];
        imageExitShare.userInteractionEnabled = YES;
        UITapGestureRecognizer  *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(ExitSharePanel:)];
        [imageExitShare addGestureRecognizer:tapGesture];
        [tapGesture release];
        [imageView addSubview:imageExitShare];*/
        
        
        
        [imageView release];
        [logoView release];
        [label release];
        [contentView release];
        [SendimageChoose release];
        [labelSendImage release];
        [btnExit release];
        [btnShare release];
        //[imageExitShare release];
        
        
        // Initialization code
    }
    
    return self;
}

-(void)prePic:(id)sender
{
    if (self.shareImage == nil)
    {
        return;
    }
    NSLog(@"prePic:%@",sender);
    UIView   *view = [self viewWithTag:PREPIC_VIEWTAG];
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:self.bounds];
        UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height/2)];
        imageView.image = self.shareImage;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 5;
        [view addSubview:imageView];
        view.tag = PREPIC_VIEWTAG;
        imageView.center = view.center;
        view.userInteractionEnabled = YES;
        imageView.userInteractionEnabled = YES;
        [self addSubview:view];
        [imageView release];
        [view release];
        
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(removePreView:)];
        [view addGestureRecognizer:tap];
        [tap release];
    }
    
}

-(void)removePreView:(id)thread
{
    [self endEditing:YES];
    UIView  *tempview = [self viewWithTag:SHARECONTENTVIEWTAG];
    [tempview setCenter:self.center];

   
    
     UIView   *view = [self viewWithTag:PREPIC_VIEWTAG];
     [view removeFromSuperview];
}
-(void)modifySendImageAction:(UITapGestureRecognizer *)SendObject
{
    
    UIImageView  *imageView = (UIImageView *)SendObject.view;
    
    UIImageView  *hookYesView = (UIImageView *)[imageView viewWithTag:111];
    
    
    if (hookYesView == nil)
    {
        hookYesView = [[UIImageView alloc] initWithFrame:imageView.bounds];
        hookYesView.image = [UIImage imageNamed:@"dzpk_share_screenshot_YES.png"];
        [imageView addSubview:hookYesView];
        hookYesView.tag = 111;
        [hookYesView release];
         self.iSSendImage = YES;
    }else
    {
        [hookYesView removeFromSuperview];
         self.iSSendImage = NO;
    }
   /* if ([imageView.image isEqual:[UIImage imageNamed:@"dzpk_share_screenshot_YES.png"]])
    {
        imageView.image = [UIImage imageNamed:@"dzpk_share_screenshot_NO.png"];
        self.iSSendImage = NO;
    }else
    {
        imageView.image = [UIImage imageNamed:@"dzpk_share_screenshot_YES.png"];
        self.iSSendImage = YES;
    }*/
    NSLog(@"modifySendImageAction:");
}


-(void)ExitSharePanel:(id)sender
{
    [self removeFromSuperview];
    NSLog(@"ExitSharePanel:");
}

-(void)ShareContent:(id)sender
{
    if (self.shareType == 1)
    {
         TencentOAuth  *tenect = [TencentOAuth ShareInstance:self];
        if (self.iSSendImage && self.shareImage)
        {
            NSData    *data = UIImagePNGRepresentation(self.shareImage);
            [tenect addMessageAndPicWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.shareContent,@"content",data,@"pic", nil]];
        }else
        {
            [tenect addMessageWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.shareContent,@"content", nil]];
        }
    }else if (self.shareType == 2)
    {
        SinaWeibo   *sharesinaWeibo = [SinaWeibo shareInstance:self];
        if (self.iSSendImage && self.shareImage)
        {
            NSData    *data = UIImagePNGRepresentation(self.shareImage);
            [sharesinaWeibo PublicWeiBoMessage:self.shareContent withImage:data];
        }else
        {
            [sharesinaWeibo PublicWeiBoMessage:self.shareContent];
        }
        
    }
    
     NSLog(@"ShareContent:");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark textView delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    UIView  *view = [self viewWithTag:SHARECONTENTVIEWTAG];
    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-60, view.frame.size.width, view.frame.size.height)];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
   // UIView  *view = [self viewWithTag:SHARECONTENTVIEWTAG];
   // [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+60, view.frame.size.width, view.frame.size.height)];
   // [self endEditing:YES];
    
}


- (void)textViewDidChange:(UITextView *)textView
{
    
   
    
    if ([textView.text rangeOfString:@"\n"].location != NSNotFound)
    {
        UIView  *view = [self viewWithTag:SHARECONTENTVIEWTAG];
        [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+60, view.frame.size.width, view.frame.size.height)];
        [self endEditing:YES];
        self.shareContent = textView.text;
        return;
    }
    
    if (sinaCountWord(textView.text) >= 140)
    {
       // textView.text = [textView.text substringToIndex:140];
    }
  //  UIView  *view = [self viewWithTag:SHARECONTENTVIEWTAG];
//    [view setFrame:CGRectMake(0, view.frame.origin.y+60, view.frame.size.width, view.frame.size.height)];
   
    
}



-(void)dealWithShareBounds:(NSNotification*)note
{
  
    
    RJFTcpSocket  *m_socket = [note object];
    NSDictionary  *dicInfo = [note userInfo];
    if (dicInfo &&(m_socket.tag == GAMESOCKETTAG  || m_socket.tag == RESOURCESOCKEtTAG) )
    {
        
    }else
    {
        return;
    }
    
    size_t  size = [[dicInfo valueForKey:TCPSOCKETSIZE] intValue];
    BasisZipAndUnzip   *objShare = [[BasisZipAndUnzip alloc] initWithSize:size+10];
    int  requestCode = -1;
    
    NSData  *data = [[note userInfo] valueForKey:TCPSOCKETMESSAGE];
    
    void *handle = NULL;
    int8_t  *byte =(int8_t*) [data bytes];
    int  pos = 4;
    if (byte[0] != 'D')
    {
        pos = 5;
    }
    requestCode = [BasisZipAndUnzip unbyte_to_int16:byte pos:pos];
    
    if (requestCode == REQ_SHARE_BONUS)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:BNRRECEIVEMESSAGEFROMSERVER
                                                      object:nil];
        logMyLogInfo(@"--------------------------START receive REQ_SHARE_BONUS  -----------------------");
        handle = [objShare PhaseInfoFromData:byte outRequestCode:&requestCode];
        
        
        DZPK_SERVER_REQ_SHARE_BONUS     *info = handle;
        
        logMyLogInfo(@"status:%d",info->status);
        if (!info->status)
        {
            logMyLogInfo(@"status:%d types:%d bounds:%d allchip:%d",info->status,info->type,info->bounds,info->all_chips);
        }
        
        
        logMyLogInfo(@"--------------------------END receive REQ_SHARE_BONUS  -----------------------");
    }
}
#pragma mark sinaWeibo delegate
//2 is share  
- (void)sinaweiboDataResponse:(id)result
                withErrorInfo:(NSError *)error
              withRequesttype:(NSInteger)type
{
    NSLog(@"result:%@  error:%@   type:%d",result,error,type);
    if ([result valueForKey:@"error"] && (type == 2 || type == 30))
    {
        NSLog(@"++++++++++++++\n\nshare fail\n\n++++++++++++");
    }else
    {
        
     
        [self sendShareBounds:1];
        
        NSLog(@"++++++++++++++\n\nshare sucee\n\n++++++++++++");
    }
}

-(void)sendShareBounds:(int8_t)type
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dealWithShareBounds:)
                                                 name:BNRRECEIVEMESSAGEFROMSERVER
                                               object:nil];
    UserInfo  *objInfo = [UserInfo shareInstance];
    DZPK_CLIENT_REQ_SHARE_BONUS    info = {type};
    RJFTcpSocket   *socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    BasisZipAndUnzip  *objBasic = [[BasisZipAndUnzip alloc] initWithSize:100];
    [socket SendCharMessage:[objBasic syncWithRequest:REQ_SHARE_BONUS
                                               userID:objInfo.userIDForDzpk
                                          structArray:&info] size:[objBasic dataSize]];
    [objBasic release];
    objBasic = nil;
    
}
#pragma mark tencent  delegate

-(void)addMessageAndPicResponse:(APIResponse*) response
{
    if ([response.jsonResponse valueForKey:@"ret"] == 0)
    {
         [self sendShareBounds:1];
          NSLog(@"++++++++++++++\n\nshare sucee\n\n++++++++++++");
    }else
    {
         NSLog(@"++++++++++++++\n\nshare fail\n\n++++++++++++");
    }
    NSLog(@"APIResponse:%@",response);
}
-(void)addMessageResponse:(APIResponse*) response
{
    if ([response.jsonResponse valueForKey:@"ret"] == 0)
    {
         [self sendShareBounds:1];
        NSLog(@"++++++++++++++\n\nshare sucee\n\n++++++++++++");
    }else
    {
        NSLog(@"++++++++++++++\n\nshare fail\n\n++++++++++++");
    }
    NSLog(@"APIResponse:%@",response);

}



@end
