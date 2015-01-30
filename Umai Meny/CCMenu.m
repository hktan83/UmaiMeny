//
//  CCMenu.m
//  Umai Meny
//
//  Created by Caleb on 06/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCMenu.h"
#import "CCSushi.h"
#import "CCVarmratt.h"
#import "CCForratter.h"
#import "CCSashimi.h"
#import "CCMakiMenu.h"
#import "CCTillagg.h"

@implementation CCMenu

-(id) init
{
    self = [self initWithSushiData:nil];
    return self;
}

-(id) initWithSushiData:(NSDictionary *)data
{
    self = [super init];
    self.sushiType = data[SUSHI_TYPE];
    self.sushiSize = [data[SUSHI_SIZE] intValue];
    self.sushiIngredient = data[SUSHI_INGREDIENT];
    self.sushiLunchPrice = [data[LUNCH_PRICE] intValue];
    self.sushiOrdinariePrice = [data[ORDINARIE_PRICE] intValue];
    
    return self;
}

-(id)initWithVarmrattData:(NSDictionary *)data
{
    self = [super init];
    self.varmratt = data[VARMRATT];
    self.varmrattIngredient = data[VARMRATT_INGREDIENT];
    self.varmrattLunchPrice = [data[LUNCH_PRICE] intValue];
    self.varmrattOrdinariePrice = [data[ORDINARIE_PRICE] intValue];
    
    return self;
}

-(id) initWithSashimiData:(NSDictionary *)data andImage:(UIImage *)image
{
    self = [super init];
    self.sashimi = data[SASHIMI];
    self.sashimiIngredient = data[SASHIMI_INGREDIENT];
    self.sashimiPrice = [data[SASHIMI_PRICE] intValue];
    self.sashimiImage = image;
    
    return self;
}

-(id) initWithMakiMenuData:(NSDictionary *)data andImage:(UIImage *)image;
{
    self = [super init];
    self.makiMenu = data[MAKI_MENU];
    self.makiIngredient = data[MAKI_INGREDIENT];
    self.makiPrice = [data[MAKI_PRICE] intValue];
    self.makiMenuImage = image;
    
    return self;
}

-(id)initWithForratterData:(NSDictionary *)data andImage:(UIImage *)image
{
    self = [super init];
    self.forratter = data[FORRATTER];
    self.forratterSize = data[FORRATTER_SIZE];
    self.forratterPrice = data[FORRATTER_PRICE];
    self.forratterImage = image;
        
    return self;
}

-(id) initWithTillaggData:(NSDictionary *)data
{
    self = [super init];
    self.tillagg = data[TILLAGG_MENU];
    self.tillaggPrice = [data[TILLAGG_PRICE] intValue];
    
    
    return self;
}



@end
