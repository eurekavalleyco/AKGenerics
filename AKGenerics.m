//
//  AKGenerics.m
//  AKGenerics
//
//  Created by Ken M. Haggerty on 12/16/13.
//  Copyright (c) 2013 Eureka Valley Co. All rights reserved.
//

#pragma mark - // NOTES (Private) //

#pragma mark - // IMPORTS (Private) //

#import "AKGenerics.h"
#import "AKDebugger.h"
#import "AKSystemInfo.h"
#import <QuartzCore/QuartzCore.h>

#pragma mark - // DEFINITIONS (Private) //

@interface AKGenerics ()
@end

@implementation AKGenerics

#pragma mark - // SETTERS AND GETTERS //

#pragma mark - // INITS AND LOADS //

#pragma mark - // PUBLIC METHODS //

+ (BOOL)object:(id)object1 isEqualToObject:(id)object2
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeValidator customCategories:nil message:nil];
    
    if (!object1 && !object2) return YES;
    
    if (!object1 || !object2) return NO;
    
    if ([object1 isKindOfClass:[NSArray class]] && [object2 isKindOfClass:[NSArray class]]) return [object1 isEqualToArray:object2];
    
    if ([object1 isKindOfClass:[NSAttributedString class]] && [object2 isKindOfClass:[NSAttributedString class]]) return [object1 isEqualToAttributedString:object2];
    
    if ([object1 isKindOfClass:[NSData class]] && [object2 isKindOfClass:[NSData class]]) return [object1 isEqualToData:object2];
    
    if ([object1 isKindOfClass:[NSDate class]] && [object2 isKindOfClass:[NSDate class]]) return [object1 isEqualToDate:object2];
    
    if ([object1 isKindOfClass:[NSDictionary class]] && [object2 isKindOfClass:[NSDictionary class]]) return [object1 isEqualToDictionary:object2];
    
    if ([object1 isKindOfClass:[NSHashTable class]] && [object2 isKindOfClass:[NSHashTable class]]) return [object1 isEqualToHashTable:object2];
    
    if ([object1 isKindOfClass:[NSIndexSet class]] && [object2 isKindOfClass:[NSIndexSet class]]) return [object1 isEqualToIndexSet:object2];
    
    if ([object1 isKindOfClass:[NSNumber class]] && [object2 isKindOfClass:[NSNumber class]]) return [object1 isEqualToNumber:object2];
    
    if ([object1 isKindOfClass:[NSOrderedSet class]] && [object2 isKindOfClass:[NSOrderedSet class]]) return [object1 isEqualToOrderedSet:object2];
    
    if ([object1 isKindOfClass:[NSSet class]] && [object2 isKindOfClass:[NSSet class]]) return [object1 isEqualToSet:object2];
    
    if ([object1 isKindOfClass:[NSString class]] && [object2 isKindOfClass:[NSString class]]) return [object1 isEqualToString:object2];
    
    if ([object1 isKindOfClass:[NSTimeZone class]] && [object2 isKindOfClass:[NSTimeZone class]]) return [object1 isEqualToTimeZone:object2];
    
    if ([object1 isKindOfClass:[NSValue class]] && [object2 isKindOfClass:[NSValue class]]) return [object1 isEqualToValue:object2];
    
    return [object1 isEqual:object2];
}

+ (void)setImage:(UIImage *)image forButton:(UIButton *)button
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetup customCategories:nil message:nil];
    
    if (button)
    {
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateSelected];
        [button setImage:image forState:UIControlStateHighlighted];
    }
}

+ (void)setText:(NSString *)text forButton:(UIButton *)button
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetup customCategories:nil message:nil];
    
    if (button)
    {
        [button setTitle:text forState:UIControlStateNormal];
        [button setTitle:text forState:UIControlStateSelected];
        [button setTitle:text forState:UIControlStateHighlighted];
    }
}

+ (UIView *)getFirstResponderInView:(UIView *)view
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter customCategories:nil message:nil];
    
    UIView *firstResponder;
    NSMutableArray *subviews = [[NSMutableArray alloc] initWithObjects:view, nil];
    do {
        UIView *subview = [subviews firstObject];
        if (subview.isFirstResponder) firstResponder = subview;
        else [subviews addObjectsFromArray:subview.subviews];
        [subviews removeObject:subview];
    } while ((!firstResponder) && (subviews.count));
    return firstResponder;
}

+ (void)selectTextForTextField:(UITextField *)textField inRange:(NSRange)range
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified customCategories:nil message:nil];
    
    UITextPosition *start = [textField positionFromPosition:[textField beginningOfDocument] offset:range.location];
    UITextPosition *end = [textField positionFromPosition:start offset:range.length];
    [textField setSelectedTextRange:[textField textRangeFromPosition:start toPosition:end]];
}

+ (UIImage *)image:(UIImage *)image setAlpha:(CGFloat)alpha
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified customCategories:nil message:nil];
    
    UIImage *newImage = nil;
    if (image)
    {
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
        CGContextScaleCTM(ctx, 1, -1);
        CGContextTranslateCTM(ctx, 0, -area.size.height);
        CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
        CGContextSetAlpha(ctx, alpha);
        CGContextDrawImage(ctx, area, image.CGImage);
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newImage;
}

+ (NSString *)randomStringWithCharacters:(NSString *)charactersString length:(NSUInteger)length
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified customCategories:nil message:nil];
    
    NSMutableString *randomString = [[NSMutableString alloc] initWithCapacity:length];
    for (int i = 0; i < length; i++)
    {
        [randomString appendFormat: @"%C", [charactersString characterAtIndex: arc4random() % [charactersString length]]];
    }
    return randomString;
}

+ (BOOL)view:(UIView *)view isEventualSubviewOfView:(UIView *)parentView
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified customCategories:@[AKD_UI] message:nil];
    
    NSMutableOrderedSet *setOfSubviews = [[NSMutableOrderedSet alloc] initWithArray:parentView.subviews];
    UIView *subview;
    while (setOfSubviews.count > 0)
    {
        subview = [setOfSubviews firstObject];
        if ([subview isEqual:view]) return YES;
        else if (subview.subviews.count > 0) [setOfSubviews addObjectsFromArray:subview.subviews];
        [setOfSubviews removeObject:subview];
    }
    return NO;
}

+ (BOOL)isEmail:(NSString *)email
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeValidator customCategories:nil message:nil];
    
    if (!email) return NO;
    
    NSError *error = NULL;
    NSRegularExpression *regexEmail = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" options:NSRegularExpressionCaseInsensitive error:&error];
    if (![regexEmail firstMatchInString:email options:0 range:NSMakeRange(0, email.length)])
    {
        [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeInfo methodType:AKMethodTypeValidator customCategories:@[AKD_ACCOUNTS] message:[NSString stringWithFormat:@"%@ is not a valid email address", stringFromVariable(email)]];
        return NO;
    }
    
    return YES;
}

+ (UIViewController *)rootViewController
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter customCategories:@[AKD_UI] message:nil];
    
    return [[[[UIApplication sharedApplication] delegate] window] rootViewController];
}

+ (UIWindow *)fullscreenWindow
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter customCategories:@[AKD_UI] message:nil];
    
    return [[[UIApplication sharedApplication] delegate] window];
}

+ (UITableViewCell *)cellWithReuseIdentifier:(NSString *)reuseIdentifier class:(NSString *)className style:(UITableViewCellStyle)style tableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath fromStoryboard:(BOOL)fromStoryboard
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter customCategories:@[AKD_UI] message:nil];
    
    UITableViewCell *cell;
    if (([AKSystemInfo iOSVersion] < 7.0) || (!fromStoryboard))
    {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) cell = [[NSClassFromString(className) alloc] initWithStyle:style reuseIdentifier:reuseIdentifier];
    }
    else cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

+ (UICollectionViewCell *)cellWithReuseIdentifier:(NSString *)reuseIdentifier collectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter customCategories:@[AKD_UI] message:nil];
    
    return [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];;
}

+ (void)clearAllTextFieldsInAlertController:(UIAlertController *)alertController
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified customCategories:@[AKD_UI] message:nil];
    
    for (UITextField *textField in alertController.textFields)
    {
        [textField setText:nil];
    }
}

+ (void)incrementBadge
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter customCategories:nil message:nil];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber]+1];
}

+ (void)decrementBadge
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter customCategories:nil message:nil];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber]-1];
}

+ (void)setBadgeToCount:(NSUInteger)count
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter customCategories:nil message:nil];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
}

+ (NSString *)textForBool:(BOOL)boolValue yesText:(NSString *)yesText noText:(NSString *)noText
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter customCategories:nil message:nil];
    
    if (boolValue) return yesText;
    
    return noText;
}

+ (NSString *)pluralizationForCount:(NSInteger)count singular:(NSString *)singular plural:(NSString *)plural
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter customCategories:nil message:nil];
    
    if (ABS(count) == 1) return singular;
    
    return plural;
}

+ (void)postNotificationName:(NSString *)notificationName object:(id)object userInfo:(NSDictionary *)userInfo
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified customCategories:@[AKD_NOTIFICATION_CENTER] message:nil];
    
    if ([NSThread isMainThread])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:object userInfo:userInfo];
        return;
    }
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:object userInfo:userInfo];
    });
}

+ (NSData *)convertDictionaryToData:(NSDictionary *)dictionary
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified customCategories:nil message:nil];
    
    return [NSKeyedArchiver archivedDataWithRootObject:dictionary];
}

+ (NSDictionary *)convertDataToDictionary:(NSData *)data
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified customCategories:nil message:nil];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (void)addBorderToView:(UIView *)view withColor:(CGColorRef)color width:(CGFloat)width
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified customCategories:@[AKD_UI] message:nil];
    
    [view.layer setBorderColor:color];
    [view.layer setBorderWidth:width];
}

+ (void)addShadowToView:(UIView *)view withShadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius offset:(CGSize)shadowOffset shadowColor:(CGColorRef)color opacity:(float)opacity
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified customCategories:@[AKD_UI] message:nil];
    
    [view.layer setShadowPath:[UIBezierPath bezierPathWithRect:view.bounds].CGPath];
    [view.layer setShadowRadius:shadowRadius];
    [view.layer setCornerRadius:cornerRadius];
    [view.layer setShadowOffset:shadowOffset];
    [view.layer setMasksToBounds:NO];
    [view.layer setShadowColor:color];
    [view.layer setShadowOpacity:opacity];
}

+ (UIImage *)createThumbnailForImage:(UIImage *)image ofSize:(CGSize)size opaque:(BOOL)opaque
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeCreator customCategories:nil message:nil];
    
    if (!image)
    {
        [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeNotice methodType:AKMethodTypeCreator customCategories:nil message:[NSString stringWithFormat:@"%@ is nil", stringFromVariable(image)]];
        return nil;
    }
    
    CGRect cropRect;
    CGFloat newDimension;
    if (image.size.width/image.size.height < size.width/size.height)
    {
        newDimension = image.size.width*(size.height/size.width);
        cropRect = CGRectMake(0.0, (image.size.height-newDimension)/2.0, image.size.width, newDimension);
    }
    else
    {
        newDimension = image.size.height*(size.width/size.height);
        cropRect = CGRectMake((image.size.width-newDimension)/2.0, 0.0, newDimension, image.size.height);
    }
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0.0);
    [[UIImage imageWithCGImage:imageRef] drawInRect:CGRectMake(0.0, 0.0, size.width, size.height)];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbnail;
}

+ (NSNumber *)angleForDeviceOrientation:(UIDeviceOrientation)orientation
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter customCategories:@[AKD_UI] message:nil];
    
    switch (orientation)
    {
        case UIDeviceOrientationLandscapeRight:
            return [NSNumber numberWithFloat:3.0f*M_PI_2];
        case UIDeviceOrientationPortraitUpsideDown:
            return [NSNumber numberWithFloat:M_PI];
        case UIDeviceOrientationLandscapeLeft:
            return [NSNumber numberWithFloat:M_PI_2];
        case UIDeviceOrientationPortrait:
            return [NSNumber numberWithFloat:0.0f];
        default:
            return nil;
    }
}

+ (NSNumber *)angleForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter customCategories:@[AKD_UI] message:nil];
    
    switch (orientation)
    {
        case UIInterfaceOrientationLandscapeLeft:
            return [NSNumber numberWithFloat:3.0f*M_PI_2];
        case UIInterfaceOrientationPortraitUpsideDown:
            return [NSNumber numberWithFloat:M_PI];
        case UIInterfaceOrientationLandscapeRight:
            return [NSNumber numberWithFloat:M_PI_2];
        case UIInterfaceOrientationPortrait:
            return [NSNumber numberWithFloat:0.0f];
        default:
            return nil;
    }
}

+ (AVCaptureVideoOrientation)convertInterfaceOrientationToVideoOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter customCategories:@[AKD_UI] message:nil];
    
    switch (interfaceOrientation)
    {
        case UIInterfaceOrientationPortrait:
            return AVCaptureVideoOrientationPortrait;
        case UIInterfaceOrientationLandscapeRight:
            return AVCaptureVideoOrientationLandscapeRight;
        case UIInterfaceOrientationPortraitUpsideDown:
            return AVCaptureVideoOrientationPortraitUpsideDown;
        case UIInterfaceOrientationLandscapeLeft:
            return AVCaptureVideoOrientationLandscapeLeft;
        case UIInterfaceOrientationUnknown:
            [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeWarning methodType:AKMethodTypeGetter customCategories:@[AKD_UI] message:[NSString stringWithFormat:@"Cannot convert %@ to %@", stringFromVariable(interfaceOrientation), @"AVCaptureVideoOrientation"]];
            return 0.0;
    }
}

+ (void)rotateViewAnimated:(UIView *)view fromAngle:(CGFloat)fromAngle byAngle:(CGFloat)angle withDuration:(CFTimeInterval)duration completion:(void (^)(void))completion
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified customCategories:@[AKD_UI] message:nil];
    
    [AKGenerics rotateViewsAnimated:@[view] fromAngle:fromAngle byAngle:angle withDuration:duration completion:completion];
}

+ (void)rotateViewsAnimated:(NSArray *)views fromAngle:(CGFloat)fromAngle byAngle:(CGFloat)angle withDuration:(CFTimeInterval)duration completion:(void (^)(void))completion
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified customCategories:@[AKD_UI] message:nil];
    
    for (UIView *view in views) [view setTransform:CGAffineTransformRotate(CGAffineTransformIdentity, fromAngle)];
    [CATransaction begin];
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [rotationAnimation setByValue:[NSNumber numberWithFloat:angle]];
    [rotationAnimation setDuration:duration];
    [rotationAnimation setRemovedOnCompletion:NO];
    [rotationAnimation setFillMode:kCAFillModeForwards];
    [CATransaction setCompletionBlock:^{
        completion();
    }];
    for (UIView *view in views) [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [CATransaction commit];
}

+ (void)flipView:(UIView *)view toPosition:(CGFloat)radians withAnimations:(void (^)(void))animations duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL))completion
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified customCategories:@[AKD_UI] message:nil];
    
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0/-500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, radians, 0.0f, 1.0f, 0.0f);
    [UIView animateWithDuration:duration delay:0.0 options:options animations:^{
        [view.layer setTransform:rotationAndPerspectiveTransform];
        animations();
    } completion:^(BOOL finished) {
        if (completion) completion(finished);
    }];
}

#pragma mark - // DELEGATED METHODS //

#pragma mark - // OVERWRITTEN METHODS //

#pragma mark - // PRIVATE METHODS //

@end