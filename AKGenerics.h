//
//  AKGenerics.h
//  AKSuperViewController
//
//  Created by Ken M. Haggerty on 12/16/13.
//  Copyright (c) 2013 Eureka Valley Co. All rights reserved.
//

#pragma mark - // NOTES (Public) //

#pragma mark - // IMPORTS (Public) //

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - // PROTOCOLS //

#pragma mark - // DEFINITIONS (Public) //

#define stringFromVariable(variable) (@""#variable)
#define NOTIFICATION_OBJECT_KEY @"kNotificationUserInfoObject"
#define NOTIFICATION_OLD_KEY @"kNotificationOldKeyObject"
#define NOTIFICATION_NEW_KEY @"kNotificationNewKeyObject"

@interface AKGenerics : NSObject
+ (void)setImage:(UIImage *)image forButton:(UIButton *)button;
+ (void)setText:(NSString *)text forButton:(UIButton *)button;
+ (UIView *)getFirstResponderInView:(UIView *)view;
+ (void)selectTextForTextField:(UITextField *)textField inRange:(NSRange)range;
+ (UIImage *)image:(UIImage *)image setAlpha:(CGFloat)alpha;
+ (NSString *)randomStringWithCharacters:(NSString *)charactersString length:(NSUInteger)length;
+ (BOOL)view:(UIView *)view isEventualSubviewOfView:(UIView *)parentView;
+ (BOOL)isEmail:(NSString *)email;
@end