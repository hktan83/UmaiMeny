//
//  Varmratt.h
//  Umai Meny
//
//  Created by Caleb on 07/12/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OrderBasket;

@interface Varmratt : NSManagedObject

@property (nonatomic, retain) NSString * ingredient;
@property (nonatomic, retain) NSNumber * lunchPrice;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orderQuantity;
@property (nonatomic, retain) NSNumber * ordinariePrice;
@property (nonatomic, retain) NSNumber * sorting;
@property (nonatomic, retain) OrderBasket *orderBasket;

@end
