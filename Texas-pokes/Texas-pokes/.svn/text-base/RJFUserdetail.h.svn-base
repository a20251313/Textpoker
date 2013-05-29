//
//  RJFUserdetail.h
//  Texas-pokes
//
//  Created by ran on 12-10-26.
//
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"

@interface RJFUserdetail : UIImageView
{
    int32_t                 userID;
}

@property(readwrite)int32_t  userID,MaxChip;
@property(readwrite)int8_t  seatID;
@property(assign)id     delegate;
@property(assign)NSArray   *arrayPrices;
@property(assign)NSArray   *arrayItems;
@property(assign)NSArray   *arrayTags;

-(void)SetInfoAccorddata:(DZPK_SERVER_REQ_GAME_PLAYER_DATA*)dataInfo;
- (id)initWithFrame:(CGRect)frame withID:(int32_t)UserID;
@end
