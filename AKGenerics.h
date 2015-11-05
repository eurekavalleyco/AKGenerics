//
//  AKGenerics.h
//  AKGenerics
//
//  Created by Ken M. Haggerty on 12/16/13.
//  Copyright (c) 2013 Eureka Valley Co. All rights reserved.
//

#pragma mark - // NOTES (Public) //

#pragma mark - // IMPORTS (Public) //

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#pragma mark - // PROTOCOLS //

#pragma mark - // DEFINITIONS (Public) //

#define stringFromVariable(variable) (@""#variable)
#define NOTIFICATION_OBJECT_KEY @"kNotificationUserInfoObject"
#define NOTIFICATION_OLD_KEY @"kNotificationOldKeyObject"

@interface AKGenerics : NSObject
+ (BOOL)object:(id)object1 isEqualToObject:(id)object2;
+ (void)setImage:(UIImage *)image forButton:(UIButton *)button;
+ (void)setBackgroundImage:(UIImage *)image forButton:(UIButton *)button;
+ (void)setText:(NSString *)text forButton:(UIButton *)button;
+ (UIView *)getFirstResponderInView:(UIView *)view;
+ (void)selectTextForTextField:(UITextField *)textField inRange:(NSRange)range;
+ (UIImage *)image:(UIImage *)image setAlpha:(CGFloat)alpha;
+ (NSString *)randomStringWithCharacters:(NSString *)charactersString length:(NSUInteger)length;
+ (BOOL)view:(UIView *)view isEventualSubviewOfView:(UIView *)parentView;
+ (BOOL)isEmail:(NSString *)email;
+ (UIViewController *)rootViewController;
+ (UIWindow *)fullscreenWindow;
+ (UITableViewCell *)cellWithReuseIdentifier:(NSString *)reuseIdentifier class:(Class)cellClass style:(UITableViewCellStyle)style tableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath fromStoryboard:(BOOL)fromStoryboard;
+ (UICollectionViewCell *)cellWithReuseIdentifier:(NSString *)reuseIdentifier collectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
+ (void)clearAllTextFieldsInAlertController:(UIAlertController *)alertController;
+ (void)incrementBadge;
+ (void)decrementBadge;
+ (void)setBadgeToCount:(NSUInteger)count;
+ (NSString *)textForBool:(BOOL)boolValue yesText:(NSString *)yesText noText:(NSString *)noText;
+ (NSString *)pluralizationForCount:(NSInteger)count singular:(NSString *)singular plural:(NSString *)plural;
+ (void)postNotificationName:(NSString *)notificationName object:(id)object userInfo:(NSDictionary *)userInfo;
+ (NSData *)convertDictionaryToData:(NSDictionary *)dictionary;
+ (NSDictionary *)convertDataToDictionary:(NSData *)data;
+ (void)addBorderToView:(UIView *)view withColor:(CGColorRef)color width:(CGFloat)width;
+ (void)addShadowToView:(UIView *)view withShadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius offset:(CGSize)shadowOffset shadowColor:(CGColorRef)color opacity:(float)opacity;
+ (UIImage *)createThumbnailForImage:(UIImage *)image ofSize:(CGSize)size opaque:(BOOL)opaque;
+ (NSNumber *)angleForDeviceOrientation:(UIDeviceOrientation)orientation;
+ (NSNumber *)angleForInterfaceOrientation:(UIInterfaceOrientation)orientation;
+ (CGFloat)angleForImageOrientation:(UIImageOrientation)orientation;
+ (AVCaptureVideoOrientation)convertInterfaceOrientationToVideoOrientation:(UIInterfaceOrientation)interfaceOrientation;
+ (void)rotateViewAnimated:(UIView *)view fromAngle:(CGFloat)fromAngle byAngle:(CGFloat)angle withDuration:(CFTimeInterval)duration completion:(void (^)(void))completion;
+ (void)rotateViewsAnimated:(NSArray *)views fromAngle:(CGFloat)fromAngle byAngle:(CGFloat)angle withDuration:(CFTimeInterval)duration completion:(void (^)(void))completion;
+ (void)flipView:(UIView *)view horizontally:(BOOL)horizontally toPosition:(CGFloat)radians withAnimations:(void (^)(void))animations duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL))completion;
+ (UIImage *)cropImage:(UIImage *)image toFrame:(CGRect)frame;
+ (NSUInteger)length:(NSString *)string;
+ (BOOL)text:(NSString *)text onlyContainsCharactersInSet:(NSCharacterSet *)characterSet;
+ (UIAlertController *)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionText:(NSString *)actionText actionStyle:(UIAlertActionStyle)actionStyle completion:(void (^)(UIAlertAction *))completion;
@end