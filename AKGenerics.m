//
//  AKGenerics.m
//  AKSuperViewController
//
//  Created by Ken M. Haggerty on 12/16/13.
//  Copyright (c) 2013 Eureka Valley Co. All rights reserved.
//

#pragma mark - // NOTES (Private) //

#pragma mark - // IMPORTS (Private) //

#import "AKGenerics.h"
#import "AKDebugger.h"
#import "AKSystemInfo.h"

#pragma mark - // DEFINITIONS (Private) //

@interface AKGenerics ()
@end

@implementation AKGenerics

#pragma mark - // SETTERS AND GETTERS //

#pragma mark - // INITS AND LOADS //

#pragma mark - // PUBLIC METHODS //

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

#pragma mark - // DELEGATED METHODS //

#pragma mark - // OVERWRITTEN METHODS //

#pragma mark - // PRIVATE METHODS //

@end