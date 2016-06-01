//
//  AKGenerics+CoreData.m
//  PushQuery
//
//  Created by Ken M. Haggerty on 5/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#pragma mark - // NOTES (Private) //

#pragma mark - // IMPORTS (Private) //

#import "AKGenerics+CoreData.h"
#import "AKDebugger.h"
#import "AKGenerics.h"

#pragma mark - // IMPLEMENTATION (NSEntityMapping) //

//NSString * _Nonnull const NSEntityMappingModelVersionKey = @"modelVersion";

#pragma mark - // IMPLEMENTATION (NSMigrationManager) //

@implementation NSMigrationManager (AKGenerics)

#pragma mark Public Methods

- (NSMutableDictionary *)lookupWithKey:(NSString *)key {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_CORE_DATA] message:nil];
    
    if (!self.userInfo) {
        self.userInfo = [NSDictionary dictionary];
        return [self lookupWithKey:key];
    }
    
    NSMutableDictionary *lookup = self.userInfo[key];
    if (!lookup) {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:self.userInfo];
        userInfo[key] = [NSMutableDictionary dictionary];
        self.userInfo = [NSDictionary dictionaryWithDictionary:userInfo];
        return [self lookupWithKey:key];
    }
    
    return lookup;
}

@end
