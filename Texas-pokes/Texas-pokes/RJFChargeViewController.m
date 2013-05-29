//
//  RJFChargeViewController.m
//  Texas-pokes
//
//  Created by popo on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFChargeViewController.h"
#import "RJFMainWindow.h"
#import "RJFGameFlorOrComPeteViewController.h"
//#import "AlixPayOrder.h"
//#import "DataSigner.h"
//#import "AlixPay.h"
//#import "AlixPayResult.h"
//#import "DataVerifier.h"
#import "UserInfo.h"
#define ANIMITIONVIEWTAG        1345
#define CHIPS      @"CHIPS"
#define BEANS      @"BEANS"
#define MONEY      @"MONEY"
#define CHARGEHOST                  @"texasfee.lelechat.com"
#define CHARGEPORT                  1990


@implementation Product

@synthesize subject = _subject;
@synthesize price = _price;
@synthesize body = _body;
@synthesize orderId = _orderId;
@end



@interface RJFChargeViewController ()

@end

extern  NSString  *BNRREMOVEFROMSUPERVIEW;
extern  NSString  *BNRRESULTFROMALIPAY;
@implementation RJFChargeViewController


#pragma mark pay alertView delegate method
-(void)ClickInsureExchange:(id)userInfo
{
    [self setAllButtonEnable:YES];
    logMyLogInfo(@"userinfo:%@",userInfo);
    NSNumber  *bISBeantoChips = [userInfo valueForKey:@"ISBEANTOCHIP"];
    
    BasisZipAndUnzip  *objZip = [[BasisZipAndUnzip alloc] initWithSize:200];
    
    RJFTcpSocket  *socketResou = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    
    if ([bISBeantoChips boolValue])
    {
        
        ShowHUD(NSLocalizedString(@"加载中,请稍候", nil), self, 15);
        NSString   *strbeans = [[[userInfo valueForKey:@"NOWNUMBER"] componentsSeparatedByString:@" "] objectAtIndex:0];
        
        long  iBeans = [[NSString stringWithNeedTranfanstring:strbeans returnType:NORMALTYPE] longLongValue];
        NSString  *strTotalNumber = [NSString stringWithNeedTranfanstring:[userInfo valueForKey:@"TOTALADDNUMBER"] returnType:NORMALTYPE];
        int32_t  converbeans = m_objShareUser.idou-iBeans;
        int32_t  convertChips = [strTotalNumber intValue];
        DZPK_CLIENT_REQ_CONVERT   converInfo = {1,converbeans*100,convertChips};
        NSLog(@"1 idou:%d chips:%d",converbeans,convertChips);
        [socketResou SendCharMessage:[objZip syncWithRequest:REQ_CONVERT
                                                      userID:m_objShareUser.userIDForDzpk
                                                 structArray:&converInfo] size:[objZip dataSize]];
        
        
    }else
    {
        //long  iBeans = [[userInfo valueForKey:@"TOTALADDNUMBER"] longLongValue];
        
        NSString  *strTotalNumber = [[[userInfo valueForKey:@"NOWNUMBER"] componentsSeparatedByString:@" "] lastObject];
        if ([strTotalNumber intValue] < 100000)
        {
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n抱歉，您的剩余筹码低于10W，故不能够进行兑换。\n谢谢！", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
            [objZip release];
            objZip = nil;
            return;
        }
        int32_t convertBean = [[userInfo valueForKey:@"TOTALADDNUMBER"] intValue];
        int32_t convertChips = [strTotalNumber intValue]-m_objShareUser.userChips;
        DZPK_CLIENT_REQ_CONVERT   converInfo = {2,convertBean,convertChips};
        NSLog(@"2  idou:%d chips:%d",convertBean,convertChips);
        
        [socketResou SendCharMessage:[objZip syncWithRequest:REQ_CONVERT
                                                      userID:m_objShareUser.userIDForDzpk
                                                 structArray:&converInfo] size:[objZip dataSize]];
        
    }
    [objZip release];
    objZip = nil;
    
}
-(void)ClickCancelExchange:(id)Userinfo
{
    [self setAllButtonEnable:YES];
    
}

-(void)ClickCancel:(id)sender
{
    
}
-(void)ClickInsure:(id)sender
{
    if (m_chargeCtlType == CHARGETYPE)
    {
        NSString * URLString = @"http://itunes.apple.com/cn/app/id333206289?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
    }
    
}


#pragma mark receive charge notifi
#if 0
-(void)receiveSucesscNot:(NSNotification *)note
{
    AlixPayResult   *result = [[note userInfo] valueForKey:@"RESULT"];
    //是否支付成功
    if (9000 == result.statusCode)
    {
        /*
         *用公钥验证签名
         */
        id<DataVerifier> verifier = CreateRSADataVerifier([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA public key"]);
        if ([verifier verifyString:result.resultString withSign:result.signString])
        {
            NSDictionary  *dicInfo = [m_arrayStoreDataSource objectAtIndex:m_index];
            m_objShareUser.idou += [[dicInfo valueForKey:BEANS] intValue];
            [labelIBeans setText:[NSString stringWithFormat:@"%ld",m_objShareUser.idou]];
            
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n充值成功", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
            
        }//验签错误
        else
        {
            
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n签名错误", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
        }
    }
    //如果支付失败,可以通过result.statusCode查询错误码
    else
    {
        
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:result.statusMessage
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
    }
    
    
}
#endif

#pragma mark setbutton enable
-(void)setAllButtonEnable:(BOOL)bEnable 
{
    for(UIView  *view in [self.view subviews])
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            view.userInteractionEnabled = bEnable;
            // logMyLogInfo(@"button:%@",view);
        }
    }
    
    NSArray  *array = [m_tableView visibleCells];
    
    for (id cell in array)
    {
        for(UIView  *view in [[cell contentView] subviews])
        {
            if ([view isKindOfClass:[UIButton class]])
            {
                view.userInteractionEnabled = bEnable;
                //  logMyLogInfo(@"tableview button:%@",view);
            }
        }
        
    }
    
}
///*
// *随机生成15位订单号,外部商户根据自己情况生成订单号
// */
//- (NSString *)generateTradeNO
//{
//	const int N = 15;
//
//	NSString *sourceString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//	NSMutableString *result = [[[NSMutableString alloc] init] autorelease];
//	srand(time(0));
//	for (int i = 0; i < N; i++)
//	{
//		unsigned index = rand() % [sourceString length];
//		NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
//		[result appendString:s];
//	}
//	return result;
//}



#pragma mark tableview button method
-(void)ClickiBeanExchangeToChips:(UIButton *)sender
{
    
    
    CGPoint point = sender.center;
    point = [m_tableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [m_tableView indexPathForRowAtPoint:point];
    
    
    NSDictionary   *dicInfo = [m_arrayStoreDataSource objectAtIndex:indexpath.row];
    m_index = indexpath.row;
   
    NSString  *strChips = [dicInfo valueForKey:CHIPS];
    NSString  *strBeans = [dicInfo valueForKey:BEANS];
    strBeans = [[strBeans componentsSeparatedByString:@" "] objectAtIndex:0];
    // NSString *strIbean = [NSString stringWithNeedTranfanstring:strIbean returnType:NORMALTYPE];
    
    if ([strBeans intValue] > [m_objShareUser idou])
    {
        
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:NSLocalizedString(@"提示\n\ni豆余额不足，请立刻充值", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
      
        return;
    }
    
    PayAlertView *payAV = [[PayAlertView alloc]
                           initWithFrame:CGRectMake(30, 25, 350, 250)
                           withIbeans:strBeans
                           WithChips:strChips
                           BeanToCHips:YES];
    [payAV setDelegate:self];
    [self.view addSubview:payAV];
    [payAV release];
    
    
}
-(void)ClickChipsExchangeToiBeans:(UIButton *)sender
{
    
    CGPoint point = sender.center;
    point = [m_tableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [m_tableView indexPathForRowAtPoint:point];
    
    NSDictionary   *dicInfo = [m_arrayStoreDataSource objectAtIndex:indexpath.row];
    m_index = indexpath.row;

    NSString  *strChips = [dicInfo valueForKey:CHIPS];
    NSString  *strBeans = [dicInfo valueForKey:BEANS];
    
    
    NSString *strUserWant = [NSString stringWithNeedTranfanstring:strChips returnType:NORMALTYPE];
    
    if ([strUserWant intValue] > [m_objShareUser userChips])
    {
        NSString  *strWarn = [NSString stringWithFormat:NSLocalizedString(@"提示\n您的剩余筹码已低于%@，故不能进行此项操作。", nil),strChips];
        
        
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:strWarn
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        

        return;
    }
    PayAlertView *payAV = [[PayAlertView alloc] initWithFrame:CGRectMake(30, 25, 350, 250) withIbeans:strBeans WithChips:strChips BeanToCHips:NO];
    [payAV setDelegate:self];
    [self.view addSubview:payAV];
    [payAV release];
    
    
    
}



#if 0
-(void)ChargeIbeansByAliPay:(Product *)product
{
    /*
     *商户的唯一的parnter和seller。
     *本demo将parnter和seller信息存于（AlixPayDemo-Info.plist）中,外部商户可以考虑存于服务端或本地其他地方。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
	//如果partner和seller数据存于其他位置,请改写下面两行代码
	NSString *partner = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Partner"];
    NSString *seller = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Seller"];
	
	//partner和seller获取失败,提示
	if ([partner length] == 0 || [seller length] == 0)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
														message:@"缺少partner或者seller。"
													   delegate:self
											  cancelButtonTitle:INSURE
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
    
    /*
	 *生成订单信息及签名
	 *由于demo的局限性，本demo中的公私钥存放在AlixPayDemo-Info.plist中,外部商户可以存放在服务端或本地其他地方。
	 */
	//将商品信息赋予AlixPayOrder的成员变量
	AlixPayOrder *order = [[AlixPayOrder alloc] init];
	order.partner = partner;
	order.seller = seller;
	order.tradeNO = product.orderId;//[self generateTradeNO]; //订单ID（由商家自行制定）
	order.productName = product.subject; //商品标题
	order.productDescription = product.body; //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
	//order.notifyURL =  @"http://www.xxx.com"; //回调URL
	order.notifyURL =  @"http://www.xxx.com"; //回调URL
	//应用注册scheme,在AlixPayDemo-Info.plist定义URL types,用于安全支付成功后重新唤起商户应用
	NSString *appScheme = @"Texas-pokes";
	
	//将商品信息拼接成字符串
	NSString *orderSpec = [order description];
	logMyLogInfo(@"orderSpec = %@",orderSpec);
	
	//获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
	id<DataSigner> signer = CreateRSADataSigner([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"]);
	NSString *signedString = [signer signString:orderSpec];
	
	//将签名成功字符串格式化为订单字符串,请严格按照该格式
	NSString *orderString = nil;
	if (signedString != nil) {
		orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
	}
	//获取安全支付单例并调用安全支付接口
	AlixPay * alixpay = [AlixPay shared];
	int ret = [alixpay pay:orderString applicationScheme:appScheme];
	//AlixPayResult  *result = [alixpay handleOpenURL:[NSURL URLWithString:order.notifyURL]];
    [alixpay handleOpenURL:[NSURL URLWithString:order.notifyURL]];
    //logMyLogInfo(@":result:%@",result);
	if (ret == kSPErrorAlipayClientNotInstalled)
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:self
                           message:@"为了保证交易安全，需要安装支付宝安全支付服务，才能进行付款，点击确定，立即安装"
                        buttontype:BOTHBUTTON
                      InsureButton:INSURE
                      CancelButton:CANCEL];
	}
	else if (ret == kSPErrorSignError) {
		logMyLogInfo(@"签名错误！");
	}
    [order release];
    // logMyLogInfo(@"index:%d  info:%@",sender.index,dicInfo);
    
    
}

#endif
//1 alipay 2 yipay 3 iphone
//获取订单号
-(void)RequestCharge:(int32_t)money Type:(int8_t)type
{
    m_chargeType = type;
    DZPK_CLIENT_REQ_GET_CHARGE  chargeinfo = {m_objShareUser.userIDForDzpk,DZPKCLIENTBUILDNUMBER};
    BasisZipAndUnzip   *basic = [[BasisZipAndUnzip alloc] initWithSize:100];
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:CHARGESOCKETTAG];
    
    
    [socket SendCharMessage:[basic syncWithRequest:REQ_GET_CHARGE
                                            userID:m_objShareUser.userIDForDzpk
                                       structArray:&chargeinfo] size:[basic dataSize]];
    [basic release];
    
}



//special for downjoy to get order
-(void)RequestChargeForDownJoy:(int32_t)money Type:(int8_t)type
{
    m_chargeType = type;
    ShowHUD(NSLocalizedString(@"加载中，请稍候！", nil), self, 25);
    //Downjoy   *shareObj = [Downjoy shareInstance];
   // NSLog(@"shareObj.userID:%@",[shareObj downjoyReadMemberInfo]);
    NSString            *DownJoymid = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENTTHIRDUSERID];
    DZPK_CLIENT_REQ_GET_CHARGE_FORDOWNJOY   userOrderInfo = {m_objShareUser.userIDForDzpk,DZPKCLIENTBUILDNUMBER,money,DownJoymid};
    BasisZipAndUnzip   *basic = [[BasisZipAndUnzip alloc] initWithSize:1000];

    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:CHARGESOCKETTAG];
    
    
    [socket SendCharMessage:[basic syncWithRequest:REQ_GET_CHARGE_FORDOWNJOY
                                            userID:m_objShareUser.userIDForDzpk
                                       structArray:&userOrderInfo] size:[basic dataSize]];
    [basic release];
    
}

-(void)ClickAliPay:(UIButton *)sender
{
    // UserInfo  *shareUser = [UserInfo shareInstance];
    
    [self RequestCharge:0 Type:1];
    
    
    
    
}
-(void)ClickYiPay:(UIButton *)sender
{
    [self setAllButtonEnable:YES];
}
-(void)ClickClose:(UIButton *)sender
{
    [self setAllButtonEnable:YES];
}

-(void)ClickChargetoiBeans:(UIButton *)sender
{
    
    if (m_objShareUser.userType == 0)
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:NSLocalizedString(@"提示\n\n您是游客用户，不能够使用充值功能\n", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        return;
    }
    CGPoint point = sender.center;
    point = [m_tableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [m_tableView indexPathForRowAtPoint:point];
    //    NSDictionary   *dicInfo = [m_arrayStoreDataSource objectAtIndex:indexpath.row];
    m_index = indexpath.row;
    NSDictionary   *dicInfo = [m_arrayStoreDataSource objectAtIndex:m_index];
    int32_t   iMoney = [[dicInfo valueForKey:MONEY] intValue];
 
#if MODEFORAPPSTORE
    ShowHUD(NSLocalizedString(@"连接itunes connect中，请稍候!", nil), self,50);
#endif

#if MODEFORDOWNJOY
    [self RequestChargeForDownJoy:iMoney Type:3];
#else
    [self RequestCharge:iMoney Type:3];
#endif
 
    
    
    
}
-(void)setSomecontrolHidden:(BOOL)bHide
{
    [imagviewChips setHidden:bHide];
    [imagviewiBeans setHidden:bHide];
    //[btnChargeDetail setHidden:bHide];
    [btnCharge setHidden:bHide];
    [btnExchange setHidden:bHide];
    [labelRule setHidden:!bHide];
    [labelIBeans setHidden:bHide];
    [labelChips setHidden:bHide];
    
}
-(IBAction)clickBack:(UIButton *)sender
{
    logMyLogInfo(@"view controls:%@",[self.navigationController viewControllers]);
    RJFMainWindow  *mainWindow = nil;
    int count = [[self.navigationController viewControllers] count]-2;
    
   
    switch (m_chargeCtlType)
    {
        case CHARGETYPE:
        case EXCHANGETYPE:
            if ([[self.navigationController.viewControllers objectAtIndex:count] isKindOfClass:[RJFMainWindow class]] ||
                [[self.navigationController.viewControllers objectAtIndex:count] isKindOfClass:[RJFGameFlorOrComPeteViewController class]])
            {
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                mainWindow = [[RJFMainWindow alloc] initWithNibName:@"RJFMainWindow" bundle:nil];
                [self.navigationController pushViewController:mainWindow animated:YES];
                [mainWindow release];
            }
            
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            RJFTcpSocket *socket = [RJFTcpSocket shareWithTag:CHARGESOCKETTAG];
            if (socket)
            {
                [socket disConnect];
            }
            break;
        case CHAREDETAILTYPE:
            [self setSomecontrolHidden:NO];
            [btnChargeDetail setHidden:NO];
            [textViewDeatil setHidden:YES];
            [m_tableView setHidden:NO];
            UIImageView  *imageView =(UIImageView *)[self.view viewWithTag:ANIMITIONVIEWTAG];
            imageView.hidden = NO;
            if (!m_bIsChareModel)
            {
                m_chargeCtlType = EXCHANGETYPE;
            }else
            {
                m_chargeCtlType = CHARGETYPE;
            }
            break;
        default:
            break;
    }
    
}
-(IBAction)clickCharge:(UIButton *)sender
{
    [self setSomecontrolHidden:NO];
    m_bIsChareModel = YES;
    m_chargeCtlType = CHARGETYPE;
    UIImageView  *imageView =(UIImageView *)[self.view viewWithTag:ANIMITIONVIEWTAG];
    if (imageView)
    {
        [imageView.layer addAnimation:[self moveAninmation:CGPointMake(btnCharge.center.x, btnCharge.center.y+4) formValue:CGPointMake(btnExchange.center.x, btnExchange.center.y+4)] forKey:@"111"];
    }
    imageView.center = CGPointMake(btnCharge.center.x, btnCharge.center.y+4);
   // imageView.center = btnCharge.center;
    
    //[sender setBackgroundImage:[UIImage imageNamed:@"nav_sepline.png"] forState:UIControlStateNormal];
   // [btnExchange setBackgroundImage:[UIImage imageNamed:@"nav_sepline_null.png"] forState:UIControlStateNormal];
    [self addExchangeOrChargeInfoToarray:NO];
    [m_tableView reloadData];
    
}
-(IBAction)clickExchange:(UIButton *)sender
{
    m_bIsChareModel = NO;
    [self setSomecontrolHidden:NO];
    m_chargeCtlType = EXCHANGETYPE;
    UIImageView  *imageView =(UIImageView *)[self.view viewWithTag:ANIMITIONVIEWTAG];
    if (imageView)
    {
        [imageView.layer addAnimation:[self moveAninmation:CGPointMake(btnExchange.center.x, btnExchange.center.y+4) formValue:CGPointMake(btnCharge.center.x, btnCharge.center.y+4)] forKey:@"111"];
    }
    imageView.center = CGPointMake(btnExchange.center.x, btnExchange.center.y+4);
  //  imageView.center = btnCharge.center;
    
    /*[sender setBackgroundImage:[UIImage imageNamed:@"nav_sepline.png"] forState:UIControlStateNormal];
    [btnCharge setBackgroundImage:[UIImage imageNamed:@"nav_sepline_null.png"] forState:UIControlStateNormal];*/
    [self addExchangeOrChargeInfoToarray:YES];
    [m_tableView reloadData];
    
    
}
-(IBAction)clickChargeDetail:(UIButton *)sender
{
    m_chargeCtlType = CHAREDETAILTYPE;
    [self setSomecontrolHidden:YES];
    UIImageView  *imageView =(UIImageView *)[self.view viewWithTag:ANIMITIONVIEWTAG];
    imageView.hidden = YES;
    [sender setHidden:YES];
    [textViewDeatil setHidden:NO];
    [m_tableView setHidden:YES];
    
}





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        m_arrayStoreDataSource = [[NSMutableArray alloc] init];
        NSNotificationCenter  *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(receiveSucesscNot:)
                   name:BNRRESULTFROMALIPAY
                 object:nil];
        m_objShareUser = [UserInfo shareInstance];
        // Custom initialization
    }
    return self;
}
-(void)dealloc
{
    if (m_arrayStoreDataSource)
    {
        [m_arrayStoreDataSource removeAllObjects];
        [m_arrayStoreDataSource release];
        m_arrayStoreDataSource = nil;
    }
    if (btnBack)
    {
        [btnBack release];
        btnBack = nil;
    }
    if (btnCharge)
    {
        [btnCharge release];
        btnCharge = nil;
    }
    if (btnExchange)
    {
        [btnExchange release];
        btnExchange = nil;
    }
    if (btnChargeDetail)
    {
        [btnChargeDetail release];
        btnChargeDetail = nil;
    }
    if (labelChips)
    {
        [labelChips release];
        labelChips = nil;
    }
    if (labelIBeans)
    {
        [labelIBeans release];
        labelIBeans = nil;
    }
    if (labelRule)
    {
        [labelRule release];
        labelRule = nil;
    }
    if (textViewDeatil)
    {
        [textViewDeatil release];
        textViewDeatil = nil;
    }
    if (imagviewChips)
    {
        [imagviewChips release];
        imagviewChips = nil;
    }
    if (imagviewiBeans)
    {
        [imagviewiBeans release];
        imagviewiBeans = nil;
    }
    if (m_tableView)
    {
        [m_tableView release];
        m_tableView = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
-(void)addExchangeOrChargeInfoToarray:(BOOL)bExchange
{
    if (bExchange)
    {
        [m_arrayStoreDataSource removeAllObjects];
        for (int i = 0; i < 5; i++)
        {
            int iBeans = 0;
            NSString  *strChips = @"";
            switch (i)
            {
                case 0:
                    iBeans = 1;
                    strChips = @"1w";
                    break;
                case 1:
                    iBeans = 5;
                    strChips = @"5w";
                    break;
                case 2:
                    iBeans = 10;
                    strChips = @"10w";
                    break;
                case 3:
                    iBeans = 100;
                    strChips = @"100w";
                    break;
                case 4:
                    iBeans = 500;
                    strChips = @"500w";
                    break;
                default:
                    break;
            }
            
            NSString   *strIbeans = [NSString stringWithFormat:@"%d i豆",iBeans];
            NSString   *strChips2 = [NSString  stringWithFormat:@"%@",strChips];
            NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:strChips2,CHIPS,strIbeans,BEANS,nil];
            [m_arrayStoreDataSource addObject:dicInfo];
        }
    }else
    {
        [m_arrayStoreDataSource removeAllObjects];
        for (int i = 0; i < 5; i++)
        {
            int iMoney = 0;
            switch (i)
            {
                case 0:
                    iMoney = 30;
                    break;
                case 1:
                    iMoney = 50;
                    break;
                case 2:
                    iMoney = 98;
                    break;
                case 3:
                    iMoney = 298;
                    break;
                case 4:
                    iMoney = 488;
                    break;
                    
                default:
                    break;
            }
            
            NSString   *strIbeans = [NSString stringWithFormat:@"%d i豆",iMoney];
            NSString   *strMoney = [NSString  stringWithFormat:@"%d",iMoney];
            NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:strMoney,MONEY,strIbeans,BEANS,nil];
            [m_arrayStoreDataSource addObject:dicInfo];
        }
        
    }
}

- (void)viewDidLoad
{
    [textViewDeatil setHidden:YES];
    [m_tableView setHidden:NO];
    //[btnExchange setBackgroundImage:[UIImage imageNamed:@"nav_sepline.png"] forState:UIControlStateNormal];
    
    UIImageView   *imageView = [[UIImageView alloc] initWithFrame:btnExchange.frame];
    imageView.center = CGPointMake(imageView.center.x, imageView.center.y+4);
    [self.view insertSubview:imageView belowSubview:btnExchange];
    imageView.tag = ANIMITIONVIEWTAG;
    imageView.image = [UIImage imageNamed:@"nav_sepline.png"];
    imageView.userInteractionEnabled = YES;
    [imageView release];
    
    [self addExchangeOrChargeInfoToarray:YES];
    /* if (m_chargeCtlType == EXCHANGETYPE)
     {
     [self addExchangeOrChargeInfoToarray:YES];
     }else
     {
     [self addExchangeOrChargeInfoToarray:NO];
     }8*/
    
    [labelChips setText:[NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:m_objShareUser.userChips] returnType:COMMOMTYPE]];
    [labelIBeans setText:[NSString stringWithFormat:@"%0.0f",m_objShareUser.idou]];
    [m_tableView reloadData];
    m_chargeCtlType = EXCHANGETYPE;
    
    [RJFTcpSocket shareInitWithHost:CHARGEHOST
                               Port:CHARGEPORT
                           Delagate:nil
                                tag:CHARGESOCKETTAG];
    
#if MODEFOR91
    [textViewDeatil setText:NSLocalizedString(@"91兑换率", nil)];
#else
    [textViewDeatil setText:NSLocalizedString(@"兑换率", nil)];
#endif
      setAllViewautoResize(self.view);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark tableview delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (m_chargeCtlType == CHAREDETAILTYPE)
    {
        return 0;
    }
    return [m_arrayStoreDataSource count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell = nil;
    NSDictionary  *dicInfo = [m_arrayStoreDataSource objectAtIndex:indexPath.row];
    [tableView setBackgroundColor:[UIColor clearColor]];
    switch (m_chargeCtlType)
    {
            
        case EXCHANGETYPE:
            cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"1"] autorelease];
                UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(5, 4, 35, 34)];
                [cell.contentView addSubview:imageview];
                imageview.image = [UIImage imageNamed:@"logo_chips.png"];
                [imageview release];
                UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(5*2+36, 15, 15, 15)];
                [cell.contentView addSubview:imageview2];
                imageview2.image = [UIImage imageNamed:@"small_chips.png"];
                [imageview2 release];
                
                
                
                UILabel  *labelChipsinTable = [[UILabel alloc] initWithFrame:CGRectMake(35+15+5*3, 12, 60, 21)];
                [labelChipsinTable setBackgroundColor:[UIColor clearColor]];
                labelChipsinTable.tag = 12;
                [cell.contentView addSubview:labelChipsinTable];
                [labelChipsinTable release];
                
                UILabel  *labeliBeansinTable = [[UILabel alloc] initWithFrame:CGRectMake(35+15+100+5*4, 12, 60, 21)];
                [labeliBeansinTable setBackgroundColor:[UIColor clearColor]];
                labeliBeansinTable.tag = 13;
                [labeliBeansinTable setTextColor:[UIColor orangeColor]];
                [cell.contentView addSubview:labeliBeansinTable];
                [labeliBeansinTable release];
                
                UIButton   *button = [[UIButton alloc] initWithFrame:CGRectMake(tableView.frame.size.width-100, 8, 90, 30)];
                [button setBackgroundImage:[UIImage imageNamed:@"button_green.png"] forState:UIControlStateNormal];
                [button setTitle:@"i豆->筹码" forState:UIControlStateNormal];
                [button addTarget:self
                           action:@selector(ClickiBeanExchangeToChips:)
                 forControlEvents:UIControlEventTouchUpInside];
                [[button titleLabel] setFont:[UIFont systemFontOfSize:15]];
                button.tag = 14;
                [cell.contentView addSubview:button];
                [button release];
                
                
                /* UIButton   *button2 = [[UIButton alloc] initWithFrame:CGRectMake(tableView.frame.size.width-100, 10, 90, 25)];
                 [button2 setBackgroundImage:[UIImage imageNamed:@"button_blue.png"] forState:UIControlStateNormal];
                 [button2 setTitle:@"筹码->i豆" forState:UIControlStateNormal];
                 [button2 addTarget:self
                 action:@selector(ClickChipsExchangeToiBeans:)
                 forControlEvents:UIControlEventTouchUpInside];
                 button2.tag = 15;
                 [[button2 titleLabel] setFont:[UIFont systemFontOfSize:15]];
                 [cell.contentView addSubview:button2];
                 [button2 release];*/
            }
            if (dicInfo)
            {
                UILabel  *labeltemp  = (UILabel *)[cell.contentView viewWithTag:12];
                if (labeltemp)
                {
                    
                    [labeltemp setText:[dicInfo valueForKey:CHIPS]];
                }
                labeltemp  = (UILabel *)[cell.contentView viewWithTag:13];
                if (labeltemp)
                {
                    [labeltemp setText:[dicInfo valueForKey:BEANS]];
                }
            }
            break;
        case CHARGETYPE:
            cell = [tableView dequeueReusableCellWithIdentifier:@"2"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"2"] autorelease];
                UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(5, -5, 40, 57)];
                [cell.contentView addSubview:imageview];
                imageview.tag = 2;
                imageview.image = [UIImage imageNamed:@"logo_ibeans.png"];
                [imageview release];
                
                UILabel  *labeliBeansinTable = [[UILabel alloc] initWithFrame:CGRectMake(60+5*2, 12, 80, 21)];
                [labeliBeansinTable setBackgroundColor:[UIColor clearColor]];
                labeliBeansinTable.tag = 12;
                [labeliBeansinTable setTextColor:[UIColor orangeColor]];
                [cell.contentView addSubview:labeliBeansinTable];
                [labeliBeansinTable release];
                
                UILabel  *labelMoneyinTable = [[UILabel alloc] initWithFrame:CGRectMake(80+60+5*4+15*2, 12, 100, 21)];
                [labelMoneyinTable setBackgroundColor:[UIColor clearColor]];
                labelMoneyinTable.tag = 13;
                [cell.contentView addSubview:labelMoneyinTable];
                [labelMoneyinTable release];
                
                UIButton   *button = [[UIButton alloc] initWithFrame:CGRectMake(tableView.frame.size.width-140, 10, 90, 25)];
                [button setBackgroundImage:[UIImage imageNamed:@"button_orange.png"] forState:UIControlStateNormal];
                [button setTitle:@"充值" forState:UIControlStateNormal];
                [button addTarget:self
                           action:@selector(ClickChargetoiBeans:)
                 forControlEvents:UIControlEventTouchUpInside];
                [[button titleLabel] setFont:[UIFont systemFontOfSize:15]];
                button.tag = 15;
                [cell.contentView addSubview:button];
                [button release];
            }
            if (dicInfo)
            {
                UILabel  *labeltemp  = (UILabel *)[cell.contentView viewWithTag:13];
                if (labeltemp)
                {
#if MODEFOR91
                    NSString  *strMoney = [[dicInfo valueForKey:MONEY] stringByAppendingFormat:@"个91豆"];
#else
                    NSString  *strMoney = [@"￥ " stringByAppendingString:[dicInfo valueForKey:MONEY]];
#endif
                    
                    [labeltemp setText:strMoney];
                }
                labeltemp  = (UILabel *)[cell.contentView viewWithTag:12];
                if (labeltemp)
                {
                    [labeltemp setText:[dicInfo valueForKey:BEANS]];
                }
                UIImageView  *imageview = (UIImageView *)[cell.contentView viewWithTag:2];
                switch (indexPath.row)
                {
                    case 0:
                        imageview.image = [UIImage imageNamed:@"idou_30.png"];
                        break;
                    case 1:
                        imageview.image = [UIImage imageNamed:@"idou_50.png"];
                        break;
                    case 2:
                        imageview.image = [UIImage imageNamed:@"idou_98.png"];
                        break;
                    case 3:
                        imageview.image = [UIImage imageNamed:@"idou_298.png"];
                        break;
                    case 4:
                        imageview.image = [UIImage imageNamed:@"idou_488.png"];
                        break;
                        
                    default:
                        break;
                }
                
            }
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView            // Default is 1 if not implemented
{
    return 1;
}

/*- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
 if (alertView.tag == 123) {
 NSString * URLString = [NSString stringWithString:@"http://itunes.apple.com/cn/app/id333206289?mt=8"];
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
 }
 }*/

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (m_chargeCtlType == EXCHANGETYPE)
    {
        return;
    }
    // 40, 30, 340, 240
    CGPoint   point = [[touches anyObject] locationInView:self.view];
    if (point.x < 30 || point.x > 390 || point.y < 30 || point.y > 270)
    {
        logMyLogInfo(@"POST a remove");
        NSNotificationCenter  *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:BNRREMOVEFROMSUPERVIEW object:self];
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.view.tag = 13435;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotiFromServer:)
                                                 name:BNRRECEIVEMESSAGEFROMSERVER
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showFailInfo:)
                                                 name:@"GetShopListInAppStoreFail"
                                               object:nil];//faliedTransaction
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showFailInfo:)
                                                 name:@"faliedTransaction"
                                               object:nil];
#if MODEFOR91
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(SNSLeaveComplatformUI:)
                                                 name:(NSString *)kNdCPLeavePlatformNotification
                                               object:nil];
#endif
    [super viewWillAppear:animated];
    [self clickCharge:btnCharge];
    
}
-(void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
 
}
-(void)showFailInfo:(NSNotification *)note
{
    [self setAllButtonEnable:YES];
    HideHUD(self, YES);
    [RJFWarnView addinSelfview:self.view
                      delegate:nil
                       message:NSLocalizedString(@"提示\n\n很抱歉，充值请求失败！", nil)
                    buttontype:INSUREBUTTON
                  InsureButton:INSURE
                  CancelButton:nil];
}
-(void)viewDidDisappear:(BOOL)animated
{
   /* [[NSNotificationCenter defaultCenter] removeObserver:self];
    RJFTcpSocket *socket = [RJFTcpSocket shareWithTag:CHARGESOCKETTAG];
    if (socket)
    {
        [socket disConnect];
    }*/
    [super viewDidDisappear:animated];
}
-(void)receiveNotiFromServer:(NSNotification *)note
{
    RJFTcpSocket  *m_socket = [note object];
    NSDictionary  *dicInfo = [note userInfo];
    if (dicInfo &&(m_socket.tag == RESOURCESOCKEtTAG || m_socket.tag == CHARGESOCKETTAG || m_socket.tag == CHARGESOCKETTAG))
    {
        
    }else
    {
        return;
    }
    
      size_t  size = [[dicInfo valueForKey:TCPSOCKETSIZE] intValue];
    BasisZipAndUnzip   *objShare = [[BasisZipAndUnzip alloc] initWithSize:size+10];
    int  requestCode = -1;
   
    NSData  *data = [[note userInfo] valueForKey:TCPSOCKETMESSAGE];
    int8_t  *bytes =(int8_t*) [data bytes];
    int  pos = 4;
    if (bytes[0] != 'D')
    {
        pos = 5;
    }
    requestCode = [BasisZipAndUnzip unbyte_to_int16:bytes pos:pos];

    logMyLogInfo(@"data:%s size:%ld requestCode:%d",[data bytes],size,requestCode);
    void *handle = NULL;
  
    
    if (requestCode == REQ_CONVERT)
    {
        HideHUD(self, YES);
        handle =[objShare PhaseInfoFromData:bytes         
                             outRequestCode:&requestCode];
        
        DZPK_SERVER_REQ_CONVERT  *info = (DZPK_SERVER_REQ_CONVERT*)handle;
        if (info->status)
        {
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n兑换失败！请重新操作！", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
        }else if(info->status == 0)
        {
            int32_t    dischips = info->chips-m_objShareUser.userChips;
            int32_t    disIdou = m_objShareUser.idou-info->idou*1.0f/100.0f;
            m_objShareUser.idou = info->idou*1.0f/100.0f;
            m_objShareUser.userChips = info->chips;
            NSLog(@"suc  idou:%d chips:%d",info->idou,info->chips);
            [labelChips setText:[NSString stringWithNeedTranfanNumber:info->chips returnType:NORMALTYPE]];
            [labelIBeans setText:[NSString stringWithNeedTranfanNumber:m_objShareUser.idou returnType:NORMALTYPE]];
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:[NSString stringWithFormat:NSLocalizedString(@"恭喜您\n\n\n兑换成功\n你当前拥有筹码%0.0d,拥有i豆%0.0f\n", nil),m_objShareUser.userChips,m_objShareUser.idou]
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
            
            if (disIdou >= 0)
            {
               
                NSString *strMessage = [NSString stringWithFormat:NSLocalizedString(@"恭喜您，成功使用%d个i豆兑换了%d筹码", nil),disIdou,dischips];
                logMyLogInfo(@"disIdou:%d dischips:%d",disIdou,dischips);
                [PublicClass storeMessage:strMessage type:0];
                
            }
       

    }
    }else if (requestCode == REQ_READ_CHARGE_RESULT)
    {
        handle =[objShare PhaseInfoFromData:bytes
                                     
                             outRequestCode:&requestCode];
        DZPK_SERVER_REQ_READ_CHARGE_RESULT  *info = (DZPK_SERVER_REQ_READ_CHARGE_RESULT*)handle;
        if (info->status)
        {
            [self setAllButtonEnable:YES];
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\ni豆更新失败，请重新登录", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
            free(handle);
            [objShare release];
            return;
        }
        
        m_objShareUser.idou = info->iMoney*1.0f/100.0f;
        [labelIBeans setText:[NSString stringWithNeedTranfanNumber:m_objShareUser.idou returnType:NORMALTYPE]];
        NSString  *strWarning = [NSString stringWithFormat:NSLocalizedString(@"\n恭喜您，充值成功！\n\n您现在拥有的i豆总数为：%0.0f", nil),m_objShareUser.idou];
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:strWarning
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        [self setAllButtonEnable:YES];
        
    }else if (requestCode == REQ_GET_CHARGE)
    {
        handle =[objShare PhaseInfoFromData:bytes
                                     
                             outRequestCode:&requestCode];
        
        DZPK_SERVER_REQ_GET_CHARGE  *info = (DZPK_SERVER_REQ_GET_CHARGE*)handle;
        
        [self setAllButtonEnable:NO];
         logMyLogInfo(@"charge status:%d",info->status);
        if (info->status)
        {
            //[self RequestCharge:0 Type:m_chargeType];
            [self setAllButtonEnable:YES];
            HideHUD(self, YES);
            [RJFWarnView addinSelfview:self.view
                               delegate:nil
                                message:NSLocalizedString(@"提示\n\n\n获取订单号失败,请稍候再试！", nil)
                             buttontype:INSUREBUTTON
                           InsureButton:INSURE
                           CancelButton:nil];
            free(handle);
            [objShare release];
            return;
        }
          
       
        
 
        
        NSString  *strproductID = @"";
        int   chagreNumber = 30;
        switch (m_index)
        {
            case 0:
                strproductID = @"dzpk345678001";
                break;
            case 1:
                strproductID = @"dzpk345678002";
                chagreNumber = 50;
                break;
            case 2:
                strproductID = @"dzpk345678003";
                chagreNumber = 98;
                break;
            case 3:
                strproductID = @"dzpk345678004";
                chagreNumber = 298;
                break;
            case 4:
                strproductID = @"dzpk345678005";
                chagreNumber = 488;
                break;
                
            default:
                break;
        }
        
#if MODEFOR91
        
        
        //  chagreNumber = 1;
        [self setAllButtonEnable:YES];
        NSString *strOrder = [info->tradeID stringByAppendingFormat:@"%@",@"1234567890"];
        [[NdComPlatform defaultPlatform] NdUniPayForCoin:[strOrder lowercaseString] needPayCoins:chagreNumber payDescription:strproductID];
        logMyLogInfo(@"status:%d order:%@ info->url:%@ tradeID length:%d  strOrder:%@ str length:%d ",info->status,info->tradeID,info->url,[info->tradeID length],strOrder,[strOrder length]);
#else
        
        InAppPurchaseManager  *shareObj = [InAppPurchaseManager sharedAppPurchase];
        [shareObj setDelegate:self];
        [shareObj requestProUpgradeProductDataWithProductID:strproductID andOrderNumber:info->tradeID];
        
        
        logMyLogInfo(@"charge for product ID:%@",strproductID);
#endif
        

        logMyLogInfo(@"charge for product ID:%@",strproductID);
    }else if (requestCode == REQ_CHARGE_FOR_IPHONE)
    {
        handle =[objShare PhaseInfoFromData:bytes
                                     
                             outRequestCode:&requestCode];
       
        
        HideHUD(self, YES);
        DZPK_SERVER_REQ_CHARGE_FOR_IPHONE  *info = (DZPK_SERVER_REQ_CHARGE_FOR_IPHONE*)handle;
        logMyLogInfo(@"receive chare result:%d",info->status);
        if (info->status)
        {
            [self setAllButtonEnable:YES];
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n对不起，您的充值失败!\n谢谢!", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
            [objShare release];
            objShare = nil;
            return;
        }
        
        int32_t         disIdou = info->iMoney*1.0f/100.0f-m_objShareUser.idou;
        m_objShareUser.idou = info->iMoney*1.0f/100.0f;
        [labelIBeans setText:[NSString stringWithNeedTranfanNumber:m_objShareUser.idou returnType:NORMALTYPE]];
        NSString  *strWarning = [NSString stringWithFormat:NSLocalizedString(@"\n恭喜您，充值成功！\n\n您现在拥有的i豆总数为：%0.0f", nil),m_objShareUser.idou];
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:strWarning
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        
        [self setAllButtonEnable:YES];

        NSString *strMessage = [NSString stringWithFormat:NSLocalizedString(@"恭喜您，成功充值了%d个idou.", nil),disIdou];
        [PublicClass storeMessage:strMessage type:0];

         
    }else if (requestCode == REQ_GET_CHARGE_FORDOWNJOY)
    {
        handle =[objShare PhaseInfoFromData:bytes
                                     
                             outRequestCode:&requestCode];
        
        
        HideHUD(self, YES);
        DZPK_SERVER_REQ_GET_CHARGE_FORDOWNJOY   *chareInfo = handle;
        logMyLogInfo(@"charge order status:%d",chareInfo->status);
        if (chareInfo->status == 0)
        {
#if MODEFORDOWNJOY
             logMyLogInfo(@"chare order status:%d  info:%@",chareInfo->status,chareInfo->strNargForDownjoy);
           // Downjoy   *shareJoy = [Downjoy shareInstance];
          //  shareJoy.delegate = (id)self;
            Downjoy   *shareJoy = [[Downjoy alloc]
                                   initWithBaseInfo:DownJoyAppKey
                                   appKey:DownJoyKeySecret
                                   delegate:(id)self];
            if (![shareJoy downjoyIsLogin])
            {
                [RJFWarnView addinSelfview:self.view
                                  delegate:nil
                                   message:NSLocalizedString(@"提示\n\n\n请先登录", nil)
                                buttontype:INSUREBUTTON
                              InsureButton:INSURE
                              CancelButton:nil];
                free(handle);
                handle = NULL;
                [objShare release];
                [shareJoy release];
                return;
            }
            [self presentModalViewController:shareJoy animated:YES];
            [shareJoy downjoyPayment:chareInfo->strNargForDownjoy];
           // [shareJoy release];
#endif
        }else if (chareInfo->status)
        {
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n\n获取订单号失败！", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
            
        }
        
    }
    
    
    
    
    
    
    
    
    free(handle);
    [objShare release];
}

-(void)removeHUDView:(id)thread
{
    HideHUD(self, YES);
}

#if MODEFOR91
-(void)SNSLeaveComplatformUI:(NSNotification*)note
{
    return;
    /*if (!m_bHasReceiveResult)
    {
        ShowHUD(@"正在同步您的信息中，请稍候", self, 30);
        if (m_timer)
        {
            [m_timer invalidate];
            [m_timer release];
            m_timer = nil;
        }
        m_timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeInterval:10 sinceDate:[NSDate date]]
                                           interval:0
                                             target:self
                                           selector:@selector(checkResult:)
                                           userInfo:nil
                                            repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:m_timer forMode:NSDefaultRunLoopMode];
    }
    if (![[NdComPlatform defaultPlatform] isLogined])
    {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self LoginOutByAuto:nil];
    }
    */
    logMyLogInfo(@"note:%@",note);
    
    
  
}
#endif

/*-(void)checkResult:(id)Thread
{
    HideHUD(self, YES);
    if (!m_bHasReceiveResult)
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:NSLocalizedString(@"提示\n\n\n如果你已经充值，请退出程序，重新登录。你的i豆会刷新", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        
    }
}*/
-(void)LoginOutByAuto:(id)Thread
{
    RJFTcpSocket  *socket = nil;
    
    socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    
    BasisZipAndUnzip  *objBasic = [[BasisZipAndUnzip alloc] initWithSize:50];
    [socket SendCharMessage:[objBasic syncWithRequest:REQ_OFFLINE
                                               userID:m_objShareUser.userIDForDzpk
                                          structArray:NULL]
                       size:[objBasic dataSize]];
    [objBasic release];
    objBasic = nil;
    [socket disConnect];
}

#if  MODEFORDOWNJOY

-(void) payBack
{
  //  [self dismissModalViewControllerAnimated:YES];
  //  Downjoy   *shareObj = [Downjoy shareInstance];
  //  [self dismissModalViewControllerAnimated:YES];
 //   [shareObj dismissViewControllerAnimated:YES completion:^(void){}];
    logMyLogInfo(@"payBack:");
}
#endif


-(CABasicAnimation  *)moveAninmation:(CGPoint)point  formValue:(CGPoint)fromPoint
{
    CABasicAnimation  *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 0.4f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.toValue = [NSValue valueWithCGPoint:point];
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    return animation;
}

@end
