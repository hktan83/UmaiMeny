//
//  Sashimi.h
//  Umai Meny
//
//  Created by Caleb on 28/10/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OrderBasket;

@interface Sashimi : NSManagedObject

@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSString * ingredient;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orderQuantity;
@property (nonatomic, retain) NSNumber * ordinariePrice;
@property (nonatomic, retain) OrderBasket *orderBasket;

@end
