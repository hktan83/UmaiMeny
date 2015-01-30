//
//  Sushi.h
//  Umai Meny
//
//  Created by Caleb on 27/09/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Sushi : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * ingredient;
@property (nonatomic, retain) NSNumber * lunchPrice;
@property (nonatomic, retain) NSNumber * ordinariePrice;
@property (nonatomic, retain) NSNumber * orderQuantity;
@property (nonatomic, retain) NSManagedObject *orderBasket;

@end
