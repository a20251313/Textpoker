//
//  RJFShowWordLabel.h
//  Texas-pokes
//
//  Created by ran on 12-10-19.
//
//

#import <UIKit/UIKit.h>

@interface RJFShowWordLabel : UILabel
{
    NSMutableArray   *m_arrStoreWords;
    NSTimer          *m_timer;
}
-(void)StartShow;
@end
