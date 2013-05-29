//
//  UIImage+;
//  Texas-pokes
//
//  Created by ran on 12-9-3.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (sizeOfimage)

+(UIImage*)ImageFormOrFromLocale:(NSString *)imageUrl andTitle:(NSString *)title isTaoBao:(BOOL)bIsTaobao widthandheight:(NSString *)strWHlenghth;
//+(UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize sourceImages:(UIImage*)images;
+(UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize sourceImages:(UIImage*)images;
+(void)writeToLocalfile:(NSDictionary *)dicInfo;
+ (UIImage*)imageByScalingAndCroppingForSizeIngoreheight:(CGSize)targetSize sourceImages:(UIImage*)images;
+(UIImage *)ScreenShotImageFromIphone:(UIView *)Targetview;
@end
