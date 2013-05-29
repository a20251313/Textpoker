//
//  CABasicAnimation+someAniForProp.m
//  Texas-pokes
//
//  Created by ran on 13-1-25.
//
//

#import "CABasicAnimation+someAniForProp.h"




@implementation CAAnimation (name)

@dynamic name,aniView;

@end


@implementation CABasicAnimation (someAniForProp)


+(CABasicAnimation  *)aninopacity:(CFTimeInterval)timer  name:(NSString *)name
{
    CABasicAnimation *animationopacity =[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animationopacity.fromValue=[NSNumber numberWithFloat:0];
    
    
    animationopacity.toValue=[NSNumber numberWithFloat:1.0];
    
    animationopacity.autoreverses = NO;
    
    animationopacity.duration = timer;
    
    animationopacity.repeatCount = 1;
    
    animationopacity.removedOnCompletion = NO;
    
    animationopacity.delegate = self;
    
    animationopacity.name = name;
    
    
    animationopacity.fillMode = kCAFillModeForwards;
    
    
    return animationopacity;
    
}

+(CABasicAnimation *)aniRotate:(CFTimeInterval)timer  name:(NSString *)name
{
    CATransform3D rotationTransform  = CATransform3DMakeRotation(-M_PI,0,0,1);
    CATransform3D FormrotationTransform  = CATransform3DMakeRotation(0,0,0,1);
    CABasicAnimation* animation;
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    
    
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    animation.fromValue = [NSValue valueWithCATransform3D:FormrotationTransform];
    animation.duration = 0.4f;
    
    
    
    animation.autoreverses = NO;
    animation.cumulative = YES;
    animation.name = name;
    
    animation.removedOnCompletion = YES;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.repeatCount = CGFLOAT_MAX;
    animation.delegate = self;
    
    
    return animation;
}


+(CABasicAnimation *)aniRotate:(CFTimeInterval)timer tovalue:(CGFloat)tovalue fromValue:(CGFloat)fromvalue 
{
    CATransform3D rotationTransform  = CATransform3DMakeRotation(tovalue,0,0,1);
    CATransform3D FormrotationTransform  = CATransform3DMakeRotation(fromvalue,0,0,1);
    CABasicAnimation* animation;
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    
    
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    animation.fromValue = [NSValue valueWithCATransform3D:FormrotationTransform];
    animation.duration = timer;
    
    
    
    animation.autoreverses = NO;
    animation.cumulative = YES;
    //animation.name = name;
    
    animation.removedOnCompletion = YES;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.repeatCount = 1;
    animation.delegate = self;
    
    
    return animation;
}

+(CABasicAnimation  *)aniWithTransition:(CFTimeInterval)timer  tovalue:(CGFloat)fTovalue  fromValue:(CGFloat)fFromValue
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.duration  = timer;
    
    animation.autoreverses = NO;
    
    animation.repeatCount = 1;
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    animation.toValue=[NSNumber numberWithInt:fTovalue];
    
   
    animation.fromValue=[NSNumber numberWithInt:fFromValue];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animation;
}



+(CABasicAnimation  *)aniWithScale:(CFTimeInterval)timer  tovalue:(CGFloat)fTovalue  fromValue:(CGFloat)fFromValue
{
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = timer;
    pulse.repeatCount = 1;
    pulse.autoreverses = NO;
    pulse.fromValue = [NSNumber numberWithFloat:fFromValue];
    pulse.toValue = [NSNumber numberWithFloat:fTovalue];
    pulse.removedOnCompletion = NO;
    
    pulse.fillMode = kCAFillModeForwards;
    
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    return pulse;
}

+(CABasicAnimation *)aniWithPosition:(CFTimeInterval)timer fromValue:(CGPoint)fromValue tovalue:(CGPoint)tovalue
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSValue valueWithCGPoint:fromValue];
    animation.toValue = [NSValue valueWithCGPoint:tovalue];
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses = NO;
    animation.duration=timer;
    animation.repeatCount=1;
   
    return animation;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"CABasicAnimation:%p beginTime:%f",self,self.beginTime];
}


@end
