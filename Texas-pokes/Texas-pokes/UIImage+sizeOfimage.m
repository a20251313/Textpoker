//
//  UIImage+sizeOfimage.m
//  Texas-pokes
//
//  Created by ran on 12-9-3.
//
//

#import "UIImage+sizeOfimage.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIImage (sizeOfimage)

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 06 06
 *  @brief
 *           write the data to file
 *  @param
 *          dicInfo
 *                  need has key ------------  VALUE
 *                      PATH                    PATH(NSString *)
 *                      DATA                    DATA(NSData *)
 *	@return
 *          NONE
 *
 */
+(void)writeToLocalfile:(NSDictionary *)dicInfo
{
    NSString  *strPath = [dicInfo valueForKey:@"PATH"];
    NSData    *data = [dicInfo valueForKey:@"DATA"];
    NSFileManager  *fileManger = [NSFileManager defaultManager];
    if (![fileManger fileExistsAtPath:strPath])
    {
        [fileManger createFileAtPath:strPath contents:data attributes:nil];
    }else
    {
        NSFileHandle  *fileHandle = [NSFileHandle fileHandleForWritingAtPath:strPath];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        [fileHandle synchronizeFile];
    }
    
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 06 06
 *  @brief
 *           if locale has the image named strPath. return it. Otherwise download from URL and write
 *            to strPath to save.
 *  @param
 *           imageUrl      the url fro download image
 *  @param
 *            title         The image name(not include （suffix)
 *	@return
 *           UIImage
 *
 */
+(UIImage*)ImageFormOrFromLocale:(NSString *)imageUrl andTitle:(NSString *)title isTaoBao:(BOOL)bIsTaobao widthandheight:(NSString *)strWHlenghth
{
    // NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    UIImage  *image = nil;
    NSString  *strType = [[imageUrl componentsSeparatedByString:@"."] lastObject];
    if (NSNotFound != [title rangeOfString:@"."].location)
    {
        strType = @"";
    }else
    {
        strType = [@"." stringByAppendingString:strType];
    }
    NSString  *strPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@%@",title,strType];
    
    NSFileManager  *fileManger = [NSFileManager defaultManager];
    if ([fileManger fileExistsAtPath:strPath])
    {
        image = [UIImage imageWithData:[NSData dataWithContentsOfFile:strPath]];
    }else
    {
        NSURLResponse  *response = nil;
        NSError  *error = nil;
        if (bIsTaobao)
        {
            imageUrl = [imageUrl stringByAppendingFormat:@"%@",strWHlenghth];
        }
        NSData  *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] returningResponse:&response error:&error];
        if (error)
        {
            // [pool drain];
            return nil;
        }else
        {
            image = [UIImage imageWithData:data];
            if (image == nil)
            {
                //[pool drain];
                return image;
            }
            NSString  *strWitePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@%@",title,strType];
            [self writeToLocalfile:[NSDictionary dictionaryWithObjectsAndKeys:strWitePath,@"PATH",data,@"DATA",nil]];
            //[NSThread detachNewThreadSelector:@selector(writeToLocalfile:) toTarget:self withObject:[NSDictionary dictionaryWithObjectsAndKeys:strWitePath,@"PATH",data,@"DATA",nil]];
        }
    }
    //[image retain];
    //[pool drain];
    return image;
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 06 06
 *  @brief
 *           copy from website
 *           scale the image.
 *  @param
 *           targetSize
 *              The size you wanna
 *  @param
 *            images
 *               source image
 *	@return
 *           UIImage
 *
 */
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize sourceImages:(UIImage*)images
{
    UIImage *newImage = nil;
    // NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    UIImage *sourceImage = images;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    // [newImage retain];
    //[pool drain];
    return newImage;
}

/*+（UIImage *)ScreenShootForIphone:(id)Thread
{
    UIView *view = [[[[[UIApplication sharedApplication] windows] objectAtIndex:1] subviews] lastObject];//获得某个window的某个subView
    NSInteger index = 0;//用来给保存的png命名
    for (UIView *subView in [view subviews])
    {//遍历这个view的subViews
        if ([subView isKindOfClass:NSClassFromString(@"UIView")] || [subView isKindOfClass:NSClassFromString(@"UIThreePartButton")])
        {//找到自己需要的subView
            //支持retina高分的关键
            if(UIGraphicsBeginImageContextWithOptions != NULL)
            {
                UIGraphicsBeginImageContextWithOptions(subView.frame.size, NO, 0.0);
            } else
            {
                UIGraphicsBeginImageContext(subView.frame.size);
            }
            
            //获取图像
            [subView.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            //保存图像
            NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/%d.png",index];
            if ([UIImagePNGRepresentation(image) writeToFile:path atomically:YES])
            {
                index += 1;
                NSLog(@"Succeeded!");
            }
            else
            {
                NSLog(@"Failed!");
            }
        }
    }
}*/


+(UIImage *)ScreenShotImageFromIphone:(UIView *)Targetview
{
    //UIView  *view = [[[[UIApplication sharedApplication] windows] objectAtIndex:1] lastObject];
  
    UIGraphicsBeginImageContextWithOptions(Targetview.frame.size, NO, 0.0);
    
    [Targetview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 06 06
 *  @brief
 *           copy from website
 *           scale the image.
 *  @param
 *           targetSize
 *              The size you wanna
 *  @param
 *            images
 *               source image
 *	@return
 *           UIImage
 *
 */
+ (UIImage*)imageByScalingAndCroppingForSizeIngoreheight:(CGSize)targetSize sourceImages:(UIImage*)images
{
    
    UIGraphicsBeginImageContext(targetSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, targetSize.width, targetSize.height);
    [images drawInRect:imageRect];
    UIImage  *image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *) grayscaleImage: (UIImage *) image
{
    CGSize size = image.size;
    CGRect rect = CGRectMake(0.0f, 0.0f, image.size.width,
                             image.size.height);
    // Create a mono/gray color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, size.width,
                                                 size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    // Draw the image into the grayscale context
    CGContextDrawImage(context, rect, [image CGImage]);
    CGImageRef grayscale = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    // Recover the image
    UIImage *img = [UIImage imageWithCGImage:grayscale];
    CFRelease(grayscale);
    return img;
}
@end
