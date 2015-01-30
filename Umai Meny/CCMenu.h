//
//  CCMenu.h
//  Umai Meny
//
//  Created by Caleb on 06/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCMenu : NSObject

// Sushi
@property (strong, nonatomic) NSString *sushiType;
@property (nonatomic) int sushiSize;
@property (strong, nonatomic) NSString *sushiIngredient;
@property (nonatomic) int sushiLunchPrice;
@property (nonatomic) int sushiOrdinariePrice;
@property (nonatomic) int sushiOrderQuantity;

// Varmratt
@property (strong, nonatomic) NSString *varmratt;
@property (strong, nonatomic) NSString *varmrattIngredient;
@property (nonatomic) int varmrattLunchPrice;
@property (nonatomic) int varmrattOrdinariePrice;
@property (nonatomic) int varmrattOrderQuantity;

// Forratter
@property (strong, nonatomic) NSString *forratter;
@property (strong, nonatomic) NSArray *forratterPrice;
@property (strong, nonatomic) NSArray *forratterSize;
@property (strong, nonatomic) NSArray *forratterOrderQuantity;
@property (strong, nonatomic) UIImage *forratterImage;

// Sashimi
@property (strong, nonatomic) NSString *sashimi;
@property (strong, nonatomic) NSString *sashimiIngredient;
@property (nonatomic) int sashimiPrice;
@property (nonatomic) int sashimiOrderQuantity;
@property (strong, nonatomic) UIImage *sashimiImage;

// Maki Menu
@property (strong, nonatomic) NSString *makiMenu;
@property (strong, nonatomic) NSString *makiIngredient;
@property (nonatomic) int makiPrice;
@property (nonatomic) int makiOrderQuantity;
@property (strong, nonatomic) UIImage *makiMenuImage;

// Tillagg
@property (strong, nonatomic) NSString *tillagg;
@property (nonatomic) int tillaggPrice;
@property (nonatomic) int tillaggOrderQuantity;

// Methods
-(id) initWithSushiData:(NSDictionary *)data;
-(id) initWithVarmrattData:(NSDictionary *)data;
-(id) initWithForratterData: (NSDictionary *)data andImage:(UIImage *)image;
-(id) initWithSashimiData:(NSDictionary *)data andImage:(UIImage *)image;
-(id) initWithMakiMenuData:(NSDictionary *)data andImage:(UIImage *)image;
-(id) initWithTillaggData:(NSDictionary *)data;

@end
