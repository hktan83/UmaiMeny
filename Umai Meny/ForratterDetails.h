//
//  ForratterDetails.h
//  Umai Meny
//
//  Created by Caleb on 05/11/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Forratter;

@interface ForratterDetails : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orderQuantity;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * size;
@property (nonatomic, retain) Forratter *forratters;

@end
