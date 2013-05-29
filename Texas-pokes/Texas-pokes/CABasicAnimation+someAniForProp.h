//
//  CABasicAnimation+someAniForProp.h
//  Texas-pokes
//
//  Created by ran on 13-1-25.
//
//

#import <QuartzCore/QuartzCore.h>


@interface CAAnimation   (name)
@property(readwrite,copy)NSString   *name;
@property(readwrite,assign)UIView   *aniView;
@end

@interface CABasicAnimation (someAniForProp)


+(CABasicAnimation  *)aniWithScale:(CFTimeInterval)timer  tovalue:(CGFloat)fTovalue  fromValue:(CGFloat)fFromValue;
+(CABasicAnimation  *)aniWithTransition:(CFTimeInterval)timer  tovalue:(CGFloat)fTovalue  fromValue:(CGFloat)fFromValue;
+(CABasicAnimation  *)aninopacity:(CFTimeInterval)timer  name:(NSString *)name;
+(CABasicAnimation *)aniRotate:(CFTimeInterval)timer  name:(NSString *)name;
+(CABasicAnimation *)aniWithPosition:(CFTimeInterval)timer fromValue:(CGPoint)fromValue tovalue:(CGPoint)tovalue;
+(CABasicAnimation *)aniRotate:(CFTimeInterval)timer tovalue:(CGFloat)tovalue fromValue:(CGFloat)fromvalue;
@end
