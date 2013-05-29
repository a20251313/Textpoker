//
//  RJFAddChipView.h
//  Texas-pokes
//
//  Created by ran on 12-10-30.
//
//

#import <UIKit/UIKit.h>

@protocol BNRAddChipDelegate <NSObject>
@optional
-(void)getAddChipInfo:(NSDictionary *)dicInfo;
@end

@interface RJFAddChipView : UIImageView
{
    id<BNRAddChipDelegate>   delegate;
}


@property(assign)id<BNRAddChipDelegate> delegate;
- (id)initWithFrame:(CGRect)frame withInfo:(NSDictionary *)dicInfo;
@end
