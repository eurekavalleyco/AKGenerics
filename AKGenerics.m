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

#pragma mark - // DELEGATED METHODS //

#pragma mark - // OVERWRITTEN METHODS //

#pragma mark - // PRIVATE METHODS //

@end