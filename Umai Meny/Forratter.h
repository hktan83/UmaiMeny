//
//  Forratter.h
//  Umai Meny
//
//  Created by Caleb on 05/11/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OrderBasket;

@interface Forratter : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *forratterBundle;
@property (nonatomic, retain) OrderBasket *orderBasket;
@end

@interface Forratter (CoreDataGeneratedAccessors)

- (void)addForratterBundleObject:(NSManagedObject *)value;
- (void)removeForratterBundleObject:(NSManagedObject *)value;
- (void)addForratterBundle:(NSSet *)values;
- (void)removeForratterBundle:(NSSet *)values;

@end
