//
//  TimeViewOnTop.m
//  I366_V1_4
//
//  Created by admin on 11-11-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TimeViewOnTop.h"
#import "UserInfo.h"

@implementation TimeViewOnTop
@synthesize m_timeLabel = _m_timeLabel;
@synthesize IDLabel = _IDLabel;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		UIImageView   *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 60)];
        imageView1.image = [UIImage imageNamed:@"bg.png"];
        [self addSubview:imageView1];
        [imageView1 release];
		UIColor *bgColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
		self.backgroundColor = bgColor;
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(268, 1, 50, 20)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.font = [UIFont systemFontOfSize:15];
        timeLabel.textColor = [UIColor whiteColor];
        self.m_timeLabel = timeLabel;
        [self addSubview:_m_timeLabel];
        [timeLabel release];
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        NSString *datestr = [formatter stringFromDate:date];
        [formatter release];
        
        [self.m_timeLabel setText:datestr];
		
		_timer = [NSTimer scheduledTimerWithTimeInterval:30.0f target:self 
                                            selector:@selector(updateTime:) userInfo:nil repeats:YES];
        
       // extern int user_id;
        UserInfo  *userInfo = [UserInfo shareInstance];
        NSString *self_NickName_ID = [NSString stringWithFormat:@"%@", userInfo.userName];//user_id];
        
        UILabel *idLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 1, 100, 20)];
        idLabel.backgroundColor = [UIColor clearColor];
        idLabel.font = [UIFont systemFontOfSize:15];
        idLabel.textColor = [UIColor whiteColor];
        if (1 != 0) {
            idLabel.text = self_NickName_ID;
        }else {
            idLabel.text = @"";
        }
        
        self.IDLabel = idLabel;
        [self addSubview:idLabel];
        [idLabel release];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 1, 19, 19)];
        imageView.image = [UIImage imageNamed:@"38x38.png"];
        [self addSubview:imageView];
        [imageView release];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"login_success" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserID:) 
													 name:@"login_success" object:nil];
	}
    return self;
}

/*- (void)updateUserID:(NSNotification *)notification
{
	NSData *data = [notification object];
	ST_V_C_LOG_IN self_info = {0};
	[data getBytes:&self_info length:sizeof(self_info)];

	_IDLabel.text = @"";
    
    NSString *self_NickName_ID = [NSString stringWithFormat:@"%d", user_id];
	_IDLabel.text = self_NickName_ID;
}*/

- (void)updateTime:(NSTimer*)timer
{
	NSDate *date = [NSDate date];
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	
	[formatter setDateFormat:@"HH:mm"];
	NSString *datestr = [formatter stringFromDate:date];
	
	[_m_timeLabel setText:datestr];
}

- (void)removeFromSuperview
{
    [_timer invalidate];
    _timer = nil;
    
    [super removeFromSuperview];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*- (void)drawRect:(CGRect)rect {
    // Drawing code.
    
    NSString *self_NickName_ID = [NSString stringWithFormat:@"%d", user_id];
	_IDLabel.text = self_NickName_ID;
    
    if (user_id != 0) {
        _IDLabel.text = self_NickName_ID;
    }else {
        _IDLabel.text = @"";
    }
}*/


- (void)dealloc {
    self.m_timeLabel = nil;
    self.IDLabel = nil;
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [super dealloc];
}


@end
