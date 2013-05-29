//
//  TimeViewOnTop.h
//  I366_V1_4
//
//  Created by admin on 11-11-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TimeViewOnTop : UIView {
	UILabel *_IDLabel;
	UILabel *_m_timeLabel;
    
    NSTimer *_timer;
}

@property (nonatomic, retain) UILabel *m_timeLabel;
@property (nonatomic, retain) UILabel *IDLabel;

@end
