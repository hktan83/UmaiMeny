//
//  Tillagg.h
//  Umai Meny
//
//  Created by Caleb on 02/11/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OrderBasket;

@interface Tillagg : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * orderQuantity;
@property (nonatomic, retain) OrderBasket *orderBasket;

@end
