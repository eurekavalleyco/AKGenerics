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

#pragma mark - // DEFINITIONS (AKGenerics) //

#define NOTIFICATION_OBJECT_KEY @"kNotificationUserInfoObjectKey"
#define NOTIFICATION_SECONDARY_KEY @"kNotificationUserInfoSecondaryKey"
#define NOTIFICATION_OLD_KEY @"kNotificationUserInfoOldKey"
#define NOTIFICATION_NEW_KEY @"kNotificationUserInfoNewKey"
//#define NOTIFICATION_SECONDARY_KEY @"kNotificationUserInfoSecondaryKey"

#define stringFromVariable(variable) (@""#variable)

@interface AKGenerics : NSObject
+ (BOOL)object:(nullable id)object1 isEqualToObject:(nullable id)object2;
+ (nullable UIViewController *)rootViewController;
+ (nonnull UIWindow *)fullscreenWindow;
+ (void)incrementBadge;
+ (void)decrementBadge;
+ (void)setBadgeToCount:(NSUInteger)count;
+ (nullable id)valueForBool:(BOOL)boolValue yesValue:(nullable id)yesValue noValue:(nullable id)noValue;
+ (nullable NSString *)pluralizationForCount:(NSUInteger)count singular:(nullable NSString *)singular plural:(nullable NSString *)plural;
+ (void)postNotificationName:(nonnull NSString *)notificationName object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;
+ (nullable NSNumber *)angleForDeviceOrientation:(UIDeviceOrientation)orientation;
+ (nullable NSNumber *)angleForInterfaceOrientation:(UIInterfaceOrientation)orientation;
+ (CGFloat)angleForImageOrientation:(UIImageOrientation)orientation;
+ (AVCaptureVideoOrientation)convertInterfaceOrientationToVideoOrientation:(UIInterfaceOrientation)interfaceOrientation;
+ (void)rotateViews:(nonnull NSArray <UIView *> *)views fromAngle:(CGFloat)fromAngle byAngle:(CGFloat)angle withDuration:(CFTimeInterval)duration completion:(nullable void (^)(void))completion;
+ (CGFloat)statusBarHeight;
+ (void)compareArray:(nonnull NSArray *)array toArray:(nonnull NSArray *)newArray andGenerateIndexPathsToInsert:(NSArray * _Nonnull * _Nonnull)indexPaths withSection:(NSUInteger)section;
+ (void)compareArray:(nonnull NSArray *)array toArray:(nonnull NSArray *)newArray andGenerateIndexPaths:(NSArray * _Nonnull * _Nonnull)indexPaths toMoveToIndexPaths:(NSArray * _Nonnull * _Nonnull)newIndexPaths withSection:(NSUInteger)section;
+ (void)compareArray:(nonnull NSArray *)array toArray:(nonnull NSArray *)newArray andGenerateIndexPathsToDelete:(NSArray * _Nonnull * _Nonnull)indexPaths withSection:(NSUInteger)section;
@end

#pragma mark - // DEFINITIONS (NSArray) //

@interface NSArray (AKGenerics)
+ (nonnull instancetype)arrayWithValue:(float)value increment:(float)increment length:(NSUInteger)length;
+ (nonnull instancetype)arrayWithStartValue:(NSInteger)startValue endValue:(NSUInteger)endValue;
+ (nonnull instancetype)arrayWithLength:(NSUInteger)length block:(nonnull id _Nonnull (^)(NSUInteger index))block;
@end

#pragma mark - // DEFINITIONS (NSData) //

@interface NSData (AKGenerics)
- (nonnull NSData *)AES256EncryptWithKey:(nonnull NSString *)key;
- (nonnull NSData *)AES256DecryptWithKey:(nonnull NSString *)key;
- (nonnull NSDictionary *)convertToDictionary;
@end

#pragma mark - // DEFINITIONS (NSDictionary) //

@interface NSDictionary (AKGenerics)
+ (nonnull instancetype)dictionaryWithNullableObject:(nullable id)object forKey:(nonnull id <NSCopying>)key;
- (nonnull NSData *)convertToData;
@end

#pragma mark - // DEFINITIONS (NSMutableDictionary) //

@interface NSMutableDictionary (AKGenerics)
- (void)setNullableObject:(nullable id)anObject forKey:(nonnull id <NSCopying>)aKey;
@end

#pragma mark - // DEFINITIONS (NSObject) //

@interface NSObject (AKGenerics)
- (void)setup;
- (void)teardown;
@end

#pragma mark - // DEFINITIONS (NSString) //

@interface NSString (AKGenerics)
+ (nonnull instancetype)randomStringWithCharacters:(nonnull NSString *)charactersString length:(NSUInteger)length;
- (BOOL)isEmail;
- (BOOL)isNumeric;
- (nonnull instancetype)encryptedStringUsingKey:(nonnull NSString *)key;
- (nonnull instancetype)decryptedStringUsingKey:(nonnull NSString *)key;
- (NSUInteger)length;
- (BOOL)onlyContainsCharactersInSet:(nonnull NSCharacterSet *)characterSet;
@end

#pragma mark - // DEFINITIONS (UIAlertController) //

@interface UIAlertController (AKGenerics)
+ (nonnull instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actions:(nullable NSArray <NSString *> *)actions preferredAction:(nullable NSString *)preferredAction dismissalText:(nullable NSString *)dismissalText completion:(nullable void (^)(UIAlertAction * _Nonnull action))completionBlock;
//+ (nonnull instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionText:(nullable NSString *)actionText actionStyle:(UIAlertActionStyle)actionStyle completion:(void (^ _Nullable)(UIAlertAction * _Nonnull))completion;
- (void)clearTextFields;
//- (nonnull void(^)(void))clearTextFieldsBlock;
@end

//#pragma mark - // DEFINITIONS (UIButton) //
//
//@interface UIButton (AKGenerics)
//- (void)setImage:(nullable UIImage *)image;
//- (void)setBackgroundImage:(nullable UIImage *)image;
//- (void)setText:(nullable NSString *)text;
//@end

#pragma mark - // DEFINITIONS (UICollectionViewCell) //

@interface UICollectionViewCell (AKGenerics)
+ (nonnull instancetype)cellWithReuseIdentifier:(nullable NSString *)reuseIdentifier collectionView:(nonnull UICollectionView *)collectionView atIndexPath:(nonnull NSIndexPath *)indexPath;
@end

#pragma mark - // DEFINITIONS (UIColor) //

@interface UIColor (AKGenerics)
+ (nonnull instancetype)iOSBlue;
@end

#pragma mark - // DEFINITIONS (UIImage) //

@interface UIImage (AKGenerics)
- (nonnull instancetype)imageWithAlpha:(CGFloat)alpha;
- (nonnull instancetype)thumbnailWithSize:(CGSize)size opaque:(BOOL)opaque;
- (nonnull instancetype)croppedImageWithFrame:(CGRect)frame;
@end

#pragma mark - // DEFINITIONS (UIScrollView) //

@interface UIScrollView (AKGenerics)
- (void)scrollToView:(nonnull UIView *)view animated:(BOOL)animated;
@end

#pragma mark - // DEFINITIONS (UITableView) //

@interface UITableView (AKGenerics)
- (void)moveRowsAtIndexPaths:(nonnull NSArray <NSIndexPath *> *)indexPaths toIndexPaths:(nonnull NSArray <NSIndexPath *> *)newIndexPaths;
@end

#pragma mark - // DEFINITIONS (UITableViewCell) //

@interface UITableViewCell (AKGenerics)
+ (nonnull instancetype)cellWithReuseIdentifier:(nullable NSString *)reuseIdentifier style:(UITableViewCellStyle)style tableView:(nonnull UITableView *)tableView atIndexPath:(nonnull NSIndexPath *)indexPath fromStoryboard:(BOOL)fromStoryboard;
+ (CGFloat)defaultHeight;
@end

#pragma mark - // DEFINITIONS (UITextField) //

@interface UITextField (AKGenerics)
- (void)selectTextInRange:(NSRange)range;
@end

#pragma mark - // DEFINITIONS (UIView) //

@interface UIView (AKGenerics)
- (nullable UIView *)firstResponder;
- (BOOL)isEventualSubviewOfView:(nonnull UIView *)view;
- (void)setFrameWithOriginX:(nullable NSNumber *)originX originY:(nullable NSNumber *)originY width:(nullable NSNumber *)width height:(nullable NSNumber *)height;
- (void)setFrameWithCenterX:(nullable NSNumber *)centerX centerY:(nullable NSNumber *)centerY width:(nullable NSNumber *)width height:(nullable NSNumber *)height;
- (void)addBorderWithColor:(nonnull CGColorRef)color width:(CGFloat)width;
- (void)addShadowWithColor:(nonnull CGColorRef)color opacity:(float)opacity radius:(CGFloat)radius cornerRadius:(CGFloat)cornerRadius offset:(CGSize)shadowOffset;
- (void)rotateFromAngle:(CGFloat)fromAngle byAngle:(CGFloat)angle withDuration:(CFTimeInterval)duration completion:(nullable void (^)(void))completion;
- (void)flipHorizontally:(CGFloat)radians withAnimations:(nullable void (^)(void))animations duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(nullable void (^)(BOOL))completion;
- (void)flipVertically:(CGFloat)radians withAnimations:(nullable void (^)(void))animations duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(nullable void (^)(BOOL))completion;
@end

#pragma mark - // DEFINITIONS (UIViewController) //

@interface UIViewController (AKGenerics)
- (void)performBlockOnChildViewControllers:(nonnull void (^)(UIViewController * _Nonnull childViewController))block;
@end
