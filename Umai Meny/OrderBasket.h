//
//  OrderBasket.h
//  Umai Meny
//
//  Created by Caleb on 05/11/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Forratter, MakiMenu, Sashimi, Sushi, Tillagg, Varmratt;

@interface OrderBasket : NSManagedObject

@property (nonatomic, retain) NSSet *forratterOrders;
@property (nonatomic, retain) NSSet *makiOrders;
@property (nonatomic, retain) NSSet *sashimiOrders;
@property (nonatomic, retain) NSSet *sushiOrders;
@property (nonatomic, retain) NSSet *tillaggOrders;
@property (nonatomic, retain) NSSet *varmrattOrders;
@end

@interface OrderBasket (CoreDataGeneratedAccessors)

- (void)addForratterOrdersObject:(Forratter *)value;
- (void)removeForratterOrdersObject:(Forratter *)value;
- (void)addForratterOrders:(NSSet *)values;
- (void)removeForratterOrders:(NSSet *)values;

- (void)addMakiOrdersObject:(MakiMenu *)value;
- (void)removeMakiOrdersObject:(MakiMenu *)value;
- (void)addMakiOrders:(NSSet *)values;
- (void)removeMakiOrders:(NSSet *)values;

- (void)addSashimiOrdersObject:(Sashimi *)value;
- (void)removeSashimiOrdersObject:(Sashimi *)value;
- (void)addSashimiOrders:(NSSet *)values;
- (void)removeSashimiOrders:(NSSet *)values;

- (void)addSushiOrdersObject:(Sushi *)value;
- (void)removeSushiOrdersObject:(Sushi *)value;
- (void)addSushiOrders:(NSSet *)values;
- (void)removeSushiOrders:(NSSet *)values;

- (void)addTillaggOrdersObject:(Tillagg *)value;
- (void)removeTillaggOrdersObject:(Tillagg *)value;
- (void)addTillaggOrders:(NSSet *)values;
- (void)removeTillaggOrders:(NSSet *)values;

- (void)addVarmrattOrdersObject:(Varmratt *)value;
- (void)removeVarmrattOrdersObject:(Varmratt *)value;
- (void)addVarmrattOrders:(NSSet *)values;
- (void)removeVarmrattOrders:(NSSet *)values;

@end
