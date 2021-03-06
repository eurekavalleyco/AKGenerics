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
//#import "AKDebugger.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#pragma mark - // DEFINITIONS (Private) //

NSString * _Nonnull const NOTIFICATION_OBJECT_KEY = @"kNotificationUserInfo_Object";
NSString * _Nonnull const NOTIFICATION_OLD_KEY = @"kNotificationUserInfo_Old";
NSString * _Nonnull const NOTIFICATION_SECONDARY_KEY = @"kNotificationUserInfo_Secondary";
//NSString * _Nonnull const NOTIFICATION_NEW_KEY = @"kNotificationUserInfo_New";

@interface AKGenerics ()
CGImageRef CGImageRotated(CGImageRef originalCGImage, double radians);
@end

#pragma mark - // IMPLEMENTATION (AKGenerics) //

@implementation AKGenerics

#pragma mark Public Methods

+ (BOOL)object:(nullable id)object1 isEqualToObject:(nullable id)object2 {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeValidator tags:nil message:nil];
    
    // nil == nil
    if (!object1 && !object2) {
        return YES;
    }
    
    // nil != non-nil
    if (!object1 || !object2) {
        return NO;
    }
    
    // NSArray
    if ([object1 isKindOfClass:[NSArray class]] && [object2 isKindOfClass:[NSArray class]]) {
        return [object1 isEqualToArray:object2];
    }
    
    // NSAttributedString
    if ([object1 isKindOfClass:[NSAttributedString class]] && [object2 isKindOfClass:[NSAttributedString class]]) {
        return [object1 isEqualToAttributedString:object2];
    }
    
    // NSData
    if ([object1 isKindOfClass:[NSData class]] && [object2 isKindOfClass:[NSData class]]) {
        return [object1 isEqualToData:object2];
    }
    
    // NSDate
    if ([object1 isKindOfClass:[NSDate class]] && [object2 isKindOfClass:[NSDate class]]) {
        return [object1 isEqualToDate:object2];
    }
    
    // NSDictionary
    if ([object1 isKindOfClass:[NSDictionary class]] && [object2 isKindOfClass:[NSDictionary class]]) return [object1 isEqualToDictionary:object2];
    
    // NSHashTable
    if ([object1 isKindOfClass:[NSHashTable class]] && [object2 isKindOfClass:[NSHashTable class]]) {
        return [object1 isEqualToHashTable:object2];
    }
    
    // NSIndexPath
    if ([object1 isKindOfClass:[NSIndexPath class]] && [object2 isKindOfClass:[NSIndexPath class]]) {
        NSIndexPath *indexPath1 = (NSIndexPath *)object1;
        NSIndexPath *indexPath2 = (NSIndexPath *)object2;
        return ((indexPath1.section == indexPath2.section) && ((indexPath1.row == indexPath2.row) || (indexPath1.item == indexPath2.item)));
    }
    
    // NSIndexSet
    if ([object1 isKindOfClass:[NSIndexSet class]] && [object2 isKindOfClass:[NSIndexSet class]]) {
        return [object1 isEqualToIndexSet:object2];
    }
    
    // NSNumber
    if ([object1 isKindOfClass:[NSNumber class]] && [object2 isKindOfClass:[NSNumber class]]) {
        return [object1 isEqualToNumber:object2];
    }
    
    // NSOrderedSet
    if ([object1 isKindOfClass:[NSOrderedSet class]] && [object2 isKindOfClass:[NSOrderedSet class]]) {
        return [object1 isEqualToOrderedSet:object2];
    }
    
    // NSSet
    if ([object1 isKindOfClass:[NSSet class]] && [object2 isKindOfClass:[NSSet class]]) {
        return [object1 isEqualToSet:object2];
    }
    
    // NSString
    if ([object1 isKindOfClass:[NSString class]] && [object2 isKindOfClass:[NSString class]]) {
        return [object1 isEqualToString:object2];
    }
    
    // NSTimeZone
    if ([object1 isKindOfClass:[NSTimeZone class]] && [object2 isKindOfClass:[NSTimeZone class]]) {
        return [object1 isEqualToTimeZone:object2];
    }
    
    // NSValue
    if ([object1 isKindOfClass:[NSValue class]] && [object2 isKindOfClass:[NSValue class]]) {
        return [object1 isEqualToValue:object2];
    }
    
    return [object1 isEqual:object2];
}

+ (nullable UIViewController *)rootViewController {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

+ (nonnull UIWindow *)fullscreenWindow {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return [UIApplication sharedApplication].delegate.window;
}

+ (void)incrementBadge {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:nil message:nil];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber+1;
}

+ (void)decrementBadge {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:nil message:nil];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber-1;
}

+ (void)setBadgeToCount:(NSUInteger)count {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:nil message:nil];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = count;
}

+ (nullable id)valueForBool:(BOOL)boolValue yesValue:(nullable id)yesValue noValue:(nullable id)noValue {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:nil message:nil];
    
    if (boolValue) {
        return yesValue;
    }
    
    return noValue;
}

+ (nullable NSString *)pluralizationForCount:(NSUInteger)count singular:(nullable NSString *)singular plural:(nullable NSString *)plural {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:nil message:nil];
    
    if (count == 1) {
        return singular;
    }
    
    return plural;
}

+ (void)postNotificationName:(nonnull NSString *)notificationName object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER] message:nil];
    
    if ([NSThread isMainThread]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:object userInfo:userInfo];
        return;
    }
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:object userInfo:userInfo];
    });
}

+ (nullable NSNumber *)angleForDeviceOrientation:(UIDeviceOrientation)orientation {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    switch (orientation) {
        case UIDeviceOrientationLandscapeRight:
            return [NSNumber numberWithFloat:3.0f*M_PI_2];
        case UIDeviceOrientationPortraitUpsideDown:
            return [NSNumber numberWithFloat:M_PI];
        case UIDeviceOrientationLandscapeLeft:
            return [NSNumber numberWithFloat:M_PI_2];
        case UIDeviceOrientationPortrait:
            return [NSNumber numberWithFloat:0.0f];
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationUnknown:
            return nil;
    }
}

+ (nullable NSNumber *)angleForInterfaceOrientation:(UIInterfaceOrientation)orientation {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    switch (orientation) {
        case UIInterfaceOrientationLandscapeLeft:
            return [NSNumber numberWithFloat:3.0f*M_PI_2];
        case UIInterfaceOrientationPortraitUpsideDown:
            return [NSNumber numberWithFloat:M_PI];
        case UIInterfaceOrientationLandscapeRight:
            return [NSNumber numberWithFloat:M_PI_2];
        case UIInterfaceOrientationPortrait:
            return [NSNumber numberWithFloat:0.0f];
        case UIInterfaceOrientationUnknown:
            return nil;
    }
}

+ (CGFloat)angleForImageOrientation:(UIImageOrientation)orientation {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:nil message:nil];
    
    switch (orientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            return 3.0f*M_PI_2;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            return M_PI;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            return M_PI_2;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            return 0.f;
    }
}

+ (AVCaptureVideoOrientation)convertInterfaceOrientationToVideoOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            return AVCaptureVideoOrientationPortrait;
        case UIInterfaceOrientationLandscapeRight:
            return AVCaptureVideoOrientationLandscapeRight;
        case UIInterfaceOrientationPortraitUpsideDown:
            return AVCaptureVideoOrientationPortraitUpsideDown;
        case UIInterfaceOrientationLandscapeLeft:
            return AVCaptureVideoOrientationLandscapeLeft;
        case UIInterfaceOrientationUnknown:
//            [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeWarning methodType:AKMethodTypeGetter tags:@[AKD_UI] message:[NSString stringWithFormat:@"Cannot convert %@ to %@", stringFromVariable(interfaceOrientation), @"AVCaptureVideoOrientation"]];
            return 0.0;
    }
}

+ (CGFloat)statusBarHeight {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (void)compareArray:(nonnull NSArray *)array toArray:(nonnull NSArray *)newArray andGenerateIndexPathsToInsert:(NSArray *__autoreleasing  _Nonnull * _Nonnull)indexPaths withSection:(NSUInteger)section {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:nil message:nil];
    
    NSMutableArray *indexPathsToInsert = [NSMutableArray array];
    NSUInteger index;
    for (id obj in newArray) {
        if (![array containsObject:obj]) {
            index = [newArray indexOfObject:obj];
            [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:index inSection:section]];
        }
    }
    
    *indexPaths = [NSArray arrayWithArray:indexPathsToInsert];
}

+ (void)compareArray:(nonnull NSArray *)array toArray:(nonnull NSArray *)newArray andGenerateIndexPaths:(NSArray * _Nonnull * _Nonnull)indexPaths toMoveToIndexPaths:(NSArray * _Nonnull * _Nonnull)newIndexPaths withSection:(NSUInteger)section {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:nil message:nil];
    
    NSAssert(array.count == newArray.count, @"%@ and %@ must have the same number of items", stringFromVariable(array), stringFromVariable(newArray));
    
    NSAssert([[NSSet setWithArray:array] isEqualToSet:[NSSet setWithArray:newArray]], @"%@ and %@ must have the same items", stringFromVariable(array), stringFromVariable(newArray));
    
    NSMutableArray *fromIndexPaths = [NSMutableArray array];
    NSMutableArray *toIndexPaths = [NSMutableArray array];
    NSUInteger index, newIndex;
    for (id obj in array) {
        index = [array indexOfObject:obj];
        newIndex = [newArray indexOfObject:obj];
        if (index != newIndex) {
            [fromIndexPaths addObject:[NSIndexPath indexPathForRow:index inSection:section]];
            [toIndexPaths addObject:[NSIndexPath indexPathForRow:newIndex inSection:section]];
        }
    }
    
    *indexPaths = [NSArray arrayWithArray:fromIndexPaths];
    *newIndexPaths = [NSArray arrayWithArray:toIndexPaths];
}

+ (void)compareArray:(nonnull NSArray *)array toArray:(nonnull NSArray *)newArray andGenerateIndexPathsToDelete:(NSArray *__autoreleasing  _Nonnull * _Nonnull)indexPaths withSection:(NSUInteger)section {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:nil message:nil];
    
    NSMutableArray *indexPathsToDelete = [NSMutableArray array];
    NSUInteger index;
    for (id obj in array) {
        if (![newArray containsObject:obj]) {
            index = [array indexOfObject:obj];
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:index inSection:section]];
        }
    }
    
    *indexPaths = [NSArray arrayWithArray:indexPathsToDelete];
}

#pragma mark Private Methods

CGImageRef CGImageRotated(CGImageRef originalCGImage, double radians) {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    CGSize imageSize = CGSizeMake(CGImageGetWidth(originalCGImage), CGImageGetHeight(originalCGImage));
    CGSize rotatedSize = imageSize;
    if (ABS(radians) == M_PI_2) {
        rotatedSize = CGSizeMake(imageSize.height, imageSize.width);
    }
    
    double rotatedCenterX = rotatedSize.width*0.5f;
    double rotatedCenterY = rotatedSize.height*0.5f;
    
    UIGraphicsBeginImageContextWithOptions(rotatedSize, NO, 1.0f);
    CGContextRef rotatedContext = UIGraphicsGetCurrentContext();
    if ((radians == 0.0f) || (radians == M_PI)) {
        CGContextTranslateCTM(rotatedContext, rotatedCenterX, rotatedCenterY);
        if (radians == 0.0f) {
            CGContextScaleCTM(rotatedContext, 1.0f, -1.0f);
        }
        else {
            CGContextScaleCTM(rotatedContext, -1.0f, 1.0f);
        }
        CGContextTranslateCTM(rotatedContext, -1.0f*rotatedCenterX, -1.0f*rotatedCenterY);
    }
    else if (ABS(radians) == M_PI_2) {
        CGContextTranslateCTM(rotatedContext, rotatedCenterX, rotatedCenterY);
        CGContextRotateCTM(rotatedContext, radians);
        CGContextScaleCTM(rotatedContext, 1.0f, -1.0f);
        CGContextTranslateCTM(rotatedContext, -1.0f*rotatedCenterY, -1.0f*rotatedCenterX);
    }
    
    CGRect drawingRect = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    CGContextDrawImage(rotatedContext, drawingRect, originalCGImage);
    CGImageRef rotatedCGImage = CGBitmapContextCreateImage(rotatedContext);
    UIGraphicsEndImageContext();
    return rotatedCGImage;
}

@end

#pragma mark - // IMPLEMENTATION (NSArray) //

@implementation NSArray (AKGenerics)

#pragma mark Public Methods

+ (nonnull instancetype)arrayWithValue:(float)value increment:(float)increment length:(NSUInteger)length {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeCreator tags:nil message:nil];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:length];
    for (int i = 0; i < length; i++) {
        [array addObject:[NSNumber numberWithFloat:value+i*increment]];
    }
    return [[self class] arrayWithArray:array];
}

+ (nonnull instancetype)arrayWithStartValue:(NSInteger)startValue endValue:(NSUInteger)endValue {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeCreator tags:nil message:nil];
    
    if (startValue == endValue) {
        return [[self class] arrayWithObject:[NSNumber numberWithInteger:startValue]];
    }
    
    NSUInteger increment = (startValue < endValue) ? 1 : -1;
    NSUInteger count = ABS(endValue-startValue);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        [array addObject:[NSNumber numberWithInteger:startValue+i*increment]];
    }
    return [[self class] arrayWithArray:array];
}

+ (nonnull instancetype)arrayWithLength:(NSUInteger)length block:(nonnull id _Nonnull (^)(NSUInteger index))block {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeCreator tags:nil message:nil];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:length];
    for (int i = 0; i < length; i++) {
        [array addObject:block(i)];
    }
    return [[self class] arrayWithArray:array];
}

- (nonnull instancetype)sortedArray:(BOOL)ascending {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeCreator tags:nil message:nil];
    
    return [self sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
        NSNumber *value1 = [NSArray sortValueForObject:obj1];
        NSNumber *value2 = [NSArray sortValueForObject:obj2];
        
        if (value1 && value2) {
            return ascending ? [value1 compare:value2] : [value2 compare:value1];
        }
        
        if (value1 && !value2) {
            return NSOrderedAscending;
        }
        
        if (!value1 && value2) {
            return NSOrderedDescending;
        }
        
        NSString *string1 = [NSArray sortStringForObject:obj1];
        NSString *string2 = [NSArray sortStringForObject:obj2];
        
        if (string1 && string2) {
            return ascending ? [string1 compare:string2] : [string2 compare:string1];
        }
        
        if (string1 && !string2) {
            return NSOrderedAscending;
        }
        
        if (!string1 && string2) {
            return NSOrderedDescending;
        }
        
        return NSOrderedSame;
    }];
}

#pragma mark Private Methods

+ (NSNumber *)sortValueForObject:(id _Nonnull)obj {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:nil message:nil];
    
    if ([obj isKindOfClass:[NSNumber class]]) {
        return obj;
    }
    
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)obj;
        if (string.isNumeric) {
            return [NSNumber numberWithFloat:string.floatValue];
        }
    }
    
    return nil;
}

+ (NSString *)sortStringForObject:(id _Nonnull)obj {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:nil message:nil];
    
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    
    if ([obj isKindOfClass:[NSAttributedString class]]) {
        NSAttributedString *attributedString = (NSAttributedString *)obj;
        return attributedString.string;
    }
    
    return nil;
}

@end

#pragma mark - // IMPLEMENTATION (NSData) //

#pragma mark Imports

#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (AKGenerics)

#pragma mark Public Methods

- (nonnull instancetype)AES256EncryptWithKey:(nonnull NSString *)key {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_DATA] message:nil];
    
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [[self class] dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

- (nonnull instancetype)AES256DecryptWithKey:(nonnull NSString *)key {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_DATA] message:nil];
    
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [[self class] dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

- (nonnull NSDictionary *)convertToDictionary {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:nil message:nil];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:self];
}

@end

#pragma mark - // IMPLEMENTATION (NSDate) //

@implementation NSDate (AKGenerics)

#pragma mark Public Methods

- (nonnull instancetype)dateRoundedToPrecision:(NSUInteger)decimalPoints {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeCreator tags:nil message:nil];
    
    NSTimeInterval timeInterval = self.timeIntervalSince1970;
    NSTimeInterval expandedTimeInterval = timeInterval*powl(10, decimalPoints);
    NSTimeInterval roundedTimeInterval = round(expandedTimeInterval);
    NSMutableString *stringTimeInterval = [NSMutableString stringWithFormat:@"%.f", roundedTimeInterval];
    [stringTimeInterval insertString:@"." atIndex:stringTimeInterval.length-decimalPoints];
    NSDecimalNumber *decimalTimeInterval = [NSDecimalNumber decimalNumberWithString:stringTimeInterval];
    double doubleTimeInterval = decimalTimeInterval.doubleValue;
    return [[self class] dateWithTimeIntervalSince1970:doubleTimeInterval];
}

@end

#pragma mark - // IMPLEMENTATION (NSDictionary) //

@implementation NSDictionary (AKGenerics)

#pragma mark Public Methods

+ (nonnull instancetype)dictionaryWithNullableObject:(nullable id)object forKey:(nonnull id <NSCopying>)key {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeCreator tags:nil message:nil];
    
    if (!object) {
        return [[self class] dictionary];
    }
    
    return [[self class] dictionaryWithObject:object forKey:key];
}

- (nonnull NSSet *)pathURLs {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:nil message:nil];
    
    NSMutableSet *pathURLs = [NSMutableSet set];
    NSMutableArray *keyArrays = [NSMutableArray arrayWithCapacity:self.allKeys.count];
    for (NSString *key in self.allKeys) {
        [keyArrays addObject:@[key]];
    }
    NSArray *keyArray, *subkeyArray;
    id child;
    NSDictionary *dictionary;
    NSURL *pathURL;
    while (keyArrays.count) {
        keyArray = keyArrays.firstObject;
        child = self;
        for (int i = 0; i < keyArray.count; i++) {
            child = child[keyArray[i]];
        }
        if ([child isKindOfClass:[NSDictionary class]]) {
            dictionary = (NSDictionary *)child;
            if (dictionary.allKeys.count) {
                for (NSString *subkey in dictionary.allKeys) {
                    subkeyArray = [keyArray arrayByAddingObject:subkey];
                    [keyArrays addObject:subkeyArray];
                }
            }
            else {
                pathURL = [NSURL fileURLWithPathComponents:keyArray];
                [pathURLs addObject:pathURL];
            }
        }
        else {
            pathURL = [NSURL fileURLWithPathComponents:keyArray];
            [pathURLs addObject:pathURL];
        }
        [keyArrays removeObject:keyArray];
    }
    return [NSSet setWithSet:pathURLs];
}

- (nonnull NSData *)convertToData {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:nil message:nil];
    
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}

@end

#pragma mark - // IMPLEMENTATION (NSMutableDictionary) //

@implementation NSMutableDictionary (AKGenerics)

#pragma mark Public Methods

- (void)setNullableObject:(nullable id)anObject forKey:(nonnull id <NSCopying>)aKey {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:nil message:nil];
    
    if (!anObject) {
        return;
    }
    
    [self setObject:anObject forKey:aKey];
}

@end

#pragma mark - // IMPLEMENTATION (NSObject) //

@implementation NSObject (AKGenerics)

#pragma mark Public Methods

- (void)setup
{
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetup tags:nil message:nil];
}

- (void)teardown
{
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetup tags:nil message:nil];
}

@end

#pragma mark - // IMPLEMENTATION (NSString) //

@implementation NSString (AKGenerics)

#pragma mark Public Methods

+ (nonnull instancetype)randomStringWithCharacters:(nonnull NSString *)charactersString length:(NSUInteger)length {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeCreator tags:nil message:nil];
    
    NSMutableString *randomString = [[NSMutableString alloc] initWithCapacity:length];
    for (int i = 0; i < length; i++) {
        [randomString appendFormat: @"%C", [charactersString characterAtIndex:(arc4random() % charactersString.length)]];
    }
    return [[self class] stringWithString:randomString];
}

- (BOOL)isEmail {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeValidator tags:nil message:nil];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSRange range = [regex firstMatchInString:self options:0 range:NSMakeRange(0, self.length)].range;
    return (range.length > 0);
}

- (BOOL)isNumeric {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeValidator tags:nil message:nil];
    
    return [[NSCharacterSet decimalDigitCharacterSet] isSupersetOfSet:[NSCharacterSet characterSetWithCharactersInString:self]];
}

- (nonnull instancetype)encryptedStringUsingKey:(nonnull NSString *)key {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_DATA] message:nil];
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    data = [data AES256EncryptWithKey:key];
    return [data base64EncodedStringWithOptions:0];
}

- (nonnull instancetype)decryptedStringUsingKey:(nonnull NSString *)key {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_DATA] message:nil];
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    data = [data AES256DecryptWithKey:key];
    return [[[self class] alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSUInteger)length {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:nil message:nil];
    
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet nonBaseCharacterSet];
    [characterSet formUnionWithCharacterSet:[NSCharacterSet controlCharacterSet]];
    return [[self componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""].length;
}

- (BOOL)onlyContainsCharactersInSet:(nonnull NSCharacterSet *)characterSet {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeValidator tags:nil message:nil];
    
    return [AKGenerics object:self isEqualToObject:[[self componentsSeparatedByCharactersInSet:characterSet.invertedSet] componentsJoinedByString:@""]];
}

@end

#pragma mark - // IMPLEMENTATION (UIAlertController) //

@implementation UIAlertController (AKGenerics)

#pragma mark Public Methods

+ (nonnull instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actions:(nullable NSArray <NSString *> *)actions preferredAction:(nullable NSString *)preferredAction dismissalText:(nullable NSString *)dismissalText completion:(nullable void(^)(UIAlertAction * _Nonnull action))completionBlock {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeCreator tags:@[AKD_UI] message:nil];
    
    id alertController = [[self class] alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (dismissalText || !actions) {
        [alertController addAction:[UIAlertAction actionWithTitle:(dismissalText ?: @"Dismiss") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alertController clearTextFields];
        }]];
    }
    if (actions) {
        UIAlertAction *alertAction;
        for (NSString *title in actions) {
            alertAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if (completionBlock) {
                    completionBlock(action);
                }
            }];
            [alertController addAction:alertAction];
            if ([title isEqualToString:preferredAction]) {
                if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0f) {
                    ((UIAlertController *)alertController).preferredAction = alertAction;
                }
            }
        }
    }
    return alertController;
}

- (void)clearTextFields {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    for (UITextField *textField in self.textFields) {
        textField.text = nil;
    }
}

@end

#pragma mark - // IMPLEMENTATION (UICollectionViewCell) //

@implementation UICollectionViewCell (AKGenerics)

#pragma mark Public Methods

+ (nonnull instancetype)cellWithReuseIdentifier:(nullable NSString *)reuseIdentifier collectionView:(nonnull UICollectionView *)collectionView atIndexPath:(nonnull NSIndexPath *)indexPath {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];;
}

@end

#pragma mark - // IMPLEMENTATION (UIColor) //

@implementation UIColor (AKGenerics)

#pragma mark Public Methods

+ (nonnull instancetype)iOSBlue {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return [[self class] colorWithHue:0.58692810457516342 saturation:1.0 brightness:1.0f alpha:1.0f];
}

@end

#pragma mark - // IMPLEMENTATION (UIImage) //

@implementation UIImage (AKGenerics)

#pragma mark Public Methods

- (nonnull instancetype)imageWithAlpha:(CGFloat)alpha {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeCreator tags:nil message:nil];
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, self.CGImage);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (nonnull instancetype)thumbnailWithSize:(CGSize)size opaque:(BOOL)opaque {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeCreator tags:nil message:nil];
    
    CGRect cropRect;
    CGFloat newDimension;
    if (self.size.width/self.size.height < size.width/size.height) {
        newDimension = self.size.width*(size.height/size.width);
        cropRect = CGRectMake(0.0, (self.size.height-newDimension)/2.0, self.size.width, newDimension);
    }
    else {
        newDimension = self.size.height*(size.width/size.height);
        cropRect = CGRectMake((self.size.width-newDimension)/2.0, 0.0, newDimension, self.size.height);
    }
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropRect);
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0.0);
    [[UIImage imageWithCGImage:imageRef] drawInRect:CGRectMake(0.0, 0.0, size.width, size.height)];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    return thumbnail;
}

- (nonnull instancetype)croppedImageWithFrame:(CGRect)frame {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:nil message:nil];
    
    CGImageRef imageRef = CGImageRotated([self CGImage], M_PI_2);
    imageRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height-frame.origin.y));
    id croppedImage = [[self class] imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

@end

#pragma mark - // IMPLEMENTATION (UIScrollView) //

@implementation UIScrollView (AKGenerics)

#pragma mark Public Methods

- (void)scrollToView:(nonnull UIView *)view animated:(BOOL)animated {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    if (![view isEventualSubviewOfView:self]) {
//        [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeNotice methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:[NSString stringWithFormat:@"%@ is not subview of %@", stringFromVariable(view), stringFromVariable(scrollView)]];
        return;
    }
    
    CGRect rect = [self convertRect:view.frame fromView:view.superview];
    [self scrollRectToVisible:rect animated:animated];
}

@end

#pragma mark - // IMPLEMENTATION (UITableView) //

@implementation UITableView (AKGenerics)

#pragma mark Public Methods

- (void)moveRowsAtIndexPaths:(NSArray <NSIndexPath *> *)indexPaths toIndexPaths:(NSArray <NSIndexPath *> *)newIndexPaths {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    NSAssert(indexPaths.count == newIndexPaths.count, @"%@ and %@ must have the same number of items", stringFromVariable(indexPaths), stringFromVariable(newIndexPaths));
    
    [self beginUpdates];
    NSIndexPath *indexPath, *newIndexPath;
    for (int i = 0; i < indexPaths.count; i++) {
        indexPath = indexPaths[i];
        newIndexPath = newIndexPaths[i];
        [self moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
    }
    [self endUpdates];
}

@end

#pragma mark - // IMPLEMENTATION (UITableViewCell) //

@implementation UITableViewCell (AKGenerics)

#pragma mark Public Methods

+ (nonnull instancetype)cellWithReuseIdentifier:(nullable NSString *)reuseIdentifier style:(UITableViewCellStyle)style tableView:(nonnull UITableView *)tableView atIndexPath:(nonnull NSIndexPath *)indexPath fromStoryboard:(BOOL)fromStoryboard {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) || (!fromStoryboard)) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell = [[self alloc] initWithStyle:style reuseIdentifier:reuseIdentifier];
        }
        return cell;
    }
    
    return [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
}

+ (CGFloat)defaultHeight {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return 44.0f;
}

@end

#pragma mark - // IMPLEMENTATION (UITextField) //

@implementation UITextField (AKGenerics)

#pragma mark Setters and Getters

- (void)setSelectable:(BOOL)selectable {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(selectable), @(selectable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)selectable {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    NSNumber *selectableValue = objc_getAssociatedObject(self, @selector(selectable));
    if (selectableValue) {
        return selectableValue.boolValue;
    }
    
    self.selectable = YES;
    return self.selectable;
}

#pragma mark Public Methods

- (void)selectTextInRange:(NSRange)range {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    UITextPosition *start = [self positionFromPosition:[self beginningOfDocument] offset:range.location];
    UITextPosition *end = [self positionFromPosition:start offset:range.length];
    [self setSelectedTextRange:[self textRangeFromPosition:start toPosition:end]];
}

#pragma mark Overwritten Methods

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeValidator tags:@[AKD_UI] message:nil];
    
    if (!self.selectable) {
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

@end

#pragma mark - // IMPLEMENTATION (UIView) //

@implementation UIView (AKGenerics)

#pragma mark Public Methods

- (nullable UIView *)firstResponder {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    NSMutableArray *subviews = [NSMutableArray arrayWithArray:self.subviews];
    UIView *subview;
    while (subviews.count) {
        subview = [subviews firstObject];
        if (subview.isFirstResponder) {
            return subview;
        }
        
        [subviews addObjectsFromArray:subview.subviews];
        [subviews removeObject:subview];
    }
    
    return nil;
}

- (BOOL)isEventualSubviewOfView:(nonnull UIView *)view {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    NSMutableOrderedSet *subviews = [[NSMutableOrderedSet alloc] initWithArray:view.subviews];
    UIView *subview;
    while (subviews.count) {
        subview = [subviews firstObject];
        if ([self isEqual:subview]) {
            return YES;
        }
        
        if (subview.subviews.count) {
            [subviews addObjectsFromArray:subview.subviews];
        }
        [subviews removeObject:subview];
    }
    
    return NO;
}

- (void)setFrameWithOriginX:(nullable NSNumber *)originX originY:(nullable NSNumber *)originY width:(nullable NSNumber *)width height:(nullable NSNumber *)height {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    CGRect frame = self.frame;
    if (originX) {
        frame = CGRectMake(originX.floatValue, frame.origin.y, frame.size.width, frame.size.height);
    }
    if (originY) {
        frame = CGRectMake(frame.origin.x, originY.floatValue, frame.size.width, frame.size.height);
    }
    if (width) {
        frame = CGRectMake(frame.origin.x, frame.origin.y, width.floatValue, frame.size.height);
    }
    if (height) {
        frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height.floatValue);
    }
    self.frame = frame;
}

- (void)setFrameWithCenterX:(nullable NSNumber *)centerX centerY:(nullable NSNumber *)centerY width:(nullable NSNumber *)width height:(nullable NSNumber *)height {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    CGRect frame = self.frame;
    if (centerX) {
        frame = CGRectMake(centerX.floatValue-0.5f*frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
    }
    if (centerY) {
        frame = CGRectMake(frame.origin.x, centerY.floatValue-0.5f*frame.size.height, frame.size.width, frame.size.height);
    }
    if (width) {
        frame = CGRectMake(frame.origin.x+(frame.size.width-width.floatValue)*0.5f, frame.origin.y, width.floatValue, frame.size.height);
    }
    if (height) {
        frame = CGRectMake(frame.origin.x, frame.origin.y+(frame.size.height-height.floatValue)*0.5f, frame.size.width, height.floatValue);
    }
    self.frame = frame;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    self.layer.cornerRadius = cornerRadius;
}

- (void)addBorderWithColor:(nonnull CGColorRef)color width:(CGFloat)width {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    [self.layer setBorderColor:color];
    [self.layer setBorderWidth:width];
}

- (void)addShadowWithColor:(nonnull CGColorRef)color opacity:(float)opacity radius:(CGFloat)radius cornerRadius:(CGFloat)cornerRadius offset:(CGSize)shadowOffset {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    [self.layer setShadowPath:[UIBezierPath bezierPathWithRect:self.bounds].CGPath];
    [self.layer setShadowRadius:radius];
    [self.layer setCornerRadius:cornerRadius];
    [self.layer setShadowOffset:shadowOffset];
    [self.layer setMasksToBounds:NO];
    [self.layer setShadowColor:color];
    [self.layer setShadowOpacity:opacity];
}

- (void)rotateFromAngle:(CGFloat)fromAngle byAngle:(CGFloat)angle withDuration:(CFTimeInterval)duration completion:(nullable void (^)(void))completion {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, fromAngle);
    [CATransaction begin];
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.byValue = [NSNumber numberWithFloat:angle];
    rotationAnimation.duration = duration;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [CATransaction setCompletionBlock:completion];
    [self.layer addAnimation:rotationAnimation forKey:stringFromVariable(rotationAnimation)];
    [CATransaction commit];
}

- (void)flipHorizontally:(CGFloat)radians withAnimations:(nullable void (^)(void))animations duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(nullable void (^)(BOOL))completion {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    CGPoint rotationAxis = CGPointMake(0.0f, 1.0f);
    [self flipWithRotationAxis:rotationAxis radians:radians withAnimations:animations duration:duration options:options completion:completion];
}

- (void)flipVertically:(CGFloat)radians withAnimations:(nullable void (^)(void))animations duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(nullable void (^)(BOOL))completion {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    CGPoint rotationAxis = CGPointMake(1.0f, 0.0f);
    [self flipWithRotationAxis:rotationAxis radians:radians withAnimations:animations duration:duration options:options completion:completion];
}

#pragma mark Private Methods

- (void)flipWithRotationAxis:(CGPoint)rotationAxis radians:(CGFloat)radians withAnimations:(nullable void (^)(void))animations duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(nullable void (^)(BOOL))completion {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = -1.0f/500.0f;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, radians, rotationAxis.x, rotationAxis.y, 0.0f);
    [UIView animateWithDuration:duration delay:0.0 options:options animations:^{
        self.layer.transform = rotationAndPerspectiveTransform;
        if (animations) {
            animations();
        }
    } completion:completion];
}

@end

#pragma mark - // IMPLEMENTATION (UIViewController) //

@implementation UIViewController (AKGenerics)

#pragma mark Public Methods

- (void)performBlockOnChildViewControllers:(void (^)(UIViewController *childViewController))block {
//    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    NSMutableArray <UIViewController *> *childViewControllers = [NSMutableArray arrayWithArray:self.childViewControllers];
    UIViewController *childViewController;
    while (childViewControllers.count) {
        childViewController = childViewControllers[0];
        if ([childViewController isKindOfClass:[UINavigationController class]] || [childViewController isKindOfClass:[UITabBarController class]]) {
            [childViewControllers addObjectsFromArray:childViewController.childViewControllers];
        }
        else {
            block(childViewController);
        }
        [childViewControllers removeObject:childViewController];
    };
}

@end
