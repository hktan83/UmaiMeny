//
//  CCTillagg.m
//  Umai Meny
//
//  Created by Caleb on 07/07/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCTillagg.h"

@implementation CCTillagg

+(NSArray *)tillagg
{
    NSMutableArray *tillaggInformation = [@[] mutableCopy];
    
    NSDictionary *nigiri = @{TILLAGG_MENU: @"Nigiri", TILLAGG_PRICE: @15};
    [tillaggInformation addObject:nigiri];
    
    NSDictionary *maki = @{TILLAGG_MENU: @"Maki", TILLAGG_PRICE: @12};
    [tillaggInformation addObject:maki];
    
    NSDictionary *misosoppa = @{TILLAGG_MENU: @"Misosoppa", TILLAGG_PRICE: @15};
    [tillaggInformation addObject:misosoppa];
    
    NSDictionary *soja = @{TILLAGG_MENU: @"Sojasås", TILLAGG_PRICE: @8};
    [tillaggInformation addObject:soja];
    
    NSDictionary *ingefara = @{TILLAGG_MENU: @"Ingefära", TILLAGG_PRICE: @8};
    [tillaggInformation addObject:ingefara];
    
    NSDictionary *tangsallad = @{TILLAGG_MENU: @"Tångsallad", TILLAGG_PRICE: @12};
    [tillaggInformation addObject:tangsallad];
    
    NSDictionary *dipsas = @{TILLAGG_MENU: @"Speciell dipsås", TILLAGG_PRICE: @13};
    [tillaggInformation addObject:dipsas];
    
    return [tillaggInformation copy];
}

@end
