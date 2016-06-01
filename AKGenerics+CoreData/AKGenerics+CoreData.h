//
//  AKGenerics+CoreData.h
//  PushQuery
//
//  Created by Ken M. Haggerty on 5/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#pragma mark - // NOTES (Public) //

#pragma mark - // IMPORTS (Public) //

#import "AKGenerics.h"
#import <CoreData/CoreData.h>

#pragma mark - // PROTOCOLS //

#pragma mark - // DEFINITIONS (NSEntityMapping) //

//extern NSString * _Nonnull const NSEntityMappingModelVersionKey;

#pragma mark - // DEFINITIONS (NSMigrationManager) //

@interface NSMigrationManager (AKGenerics)
- (nonnull NSMutableDictionary *)lookupWithKey:(nonnull NSString *)lookupKey;
@end