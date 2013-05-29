//
//  JFItemShowView.h
//  Texas-pokes
//
//  Created by ran on 13-1-22.
//
//


@protocol BNRUSERITEMSOLD <NSObject>

-(void)AddAnimationWithSeatID:(int8_t)seatID tag:(NSInteger)tag  withChip:(int32_t)chips;
-(void)GiftChipTofriend:(int8_t)seatID chip:(int32_t)chip;

@end


#import <UIKit/UIKit.h>
@interface JFItemShowView : UIView
{
    id          delegate;
}


@property(assign)  UILabel  *labelChip;
@property(assign)  UIImageView   *numberView;
@property(assign)   id delegate;
@property(readwrite)int8_t  seatID;
@property(nonatomic,retain) NSArray   *arrayTags,*arrayPrices;
- (id)initWithitems:(NSArray *)items prices:(NSArray *)prices withTags:(NSArray *)arrayTags withFrame:(CGRect)frame maxValue:(int32_t)chipMax;
@end
