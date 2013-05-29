//
//  RJFShareViewController.h
//  Texas-pokes
//
//  Created by ran on 13-1-21.
//
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"

@interface RJFShareViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray              *m_arrayDataSource;

}

@property(readwrite,retain) UIImage   *shareImage;
@property(copy) NSString   *shareContent;
@property(readwrite)int8_t          shareContentType;
@property(readwrite)int32_t          shareBounds;


-(id)initWithContent:(NSString *)strContent WithImage:(UIImage  *)image  shareContentType:(int8_t)ishareContentType;
@end
