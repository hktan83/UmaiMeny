//
//  CCSushi.m
//  Umai Meny
//
//  Created by Caleb on 05/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCSushi.h"

@implementation CCSushi

+(NSArray *)sushi
{
    NSMutableArray *sushiInformation = [@[] mutableCopy];
    
    NSDictionary *standardSushi8Bitar = @{SUSHI_TYPE : @"Standard Sushi", SUSHI_SIZE : @8, SUSHI_INGREDIENT : @"4 maki, 1 räk, 1 lax, 1 pepparlax, 1 avokado", LUNCH_PRICE : @70, ORDINARIE_PRICE : @90};
    [sushiInformation addObject:standardSushi8Bitar];
    
    NSDictionary *standardSushi10Bitar = @{SUSHI_TYPE : @"Standard Sushi", SUSHI_SIZE : @10, SUSHI_INGREDIENT : @"5 maki, 1 räk, 2 lax, 1 pepparlax, 1 avokado", LUNCH_PRICE : @80, ORDINARIE_PRICE : @100};
    [sushiInformation addObject:standardSushi10Bitar];
    
    NSDictionary *standardSushi12Bitar = @{SUSHI_TYPE : @"Standard Sushi", SUSHI_SIZE : @12, SUSHI_INGREDIENT : @"6 maki, 2 räk, 2 lax, 1 pepparlax, 1 avokado", LUNCH_PRICE : @95, ORDINARIE_PRICE : @120};
    [sushiInformation addObject:standardSushi12Bitar];
    
    NSDictionary *standardSushi14Bitar = @{SUSHI_TYPE : @"Standard Sushi", SUSHI_SIZE : @14, SUSHI_INGREDIENT : @"7 maki, 2 räk, 2 lax, 1 pepparlax, 1 tonfisk, 1 avokado", LUNCH_PRICE : @125, ORDINARIE_PRICE : @145};
    [sushiInformation addObject:standardSushi14Bitar];
    
    NSDictionary *mamasSushi8Bitar = @{SUSHI_TYPE : @"Mamas Sushi", SUSHI_SIZE : @8, SUSHI_INGREDIENT : @"4 maki, 1 räk, 1 tofu, 1 avokado, 1 omelette", LUNCH_PRICE : @70, ORDINARIE_PRICE : @90};
    [sushiInformation addObject:mamasSushi8Bitar];
    
    NSDictionary *mamasSushi10Bitar = @{SUSHI_TYPE : @"Mamas Sushi", SUSHI_SIZE : @10, SUSHI_INGREDIENT : @"6 maki, 1 räk, 1 tofu, 1 avokado, 1 omelette", LUNCH_PRICE : @80, ORDINARIE_PRICE : @100};
    [sushiInformation addObject:mamasSushi10Bitar];
    
    NSDictionary *mamasSushi12Bitar = @{SUSHI_TYPE : @"Mamas Sushi", SUSHI_SIZE : @12, SUSHI_INGREDIENT : @"6 maki, 2 räk, 1 tofu, 2 avokado, 1 omelette", LUNCH_PRICE : @95, ORDINARIE_PRICE : @120};
    [sushiInformation addObject:mamasSushi12Bitar];
    
    NSDictionary *mamasSushi14Bitar = @{SUSHI_TYPE : @"Mamas Sushi", SUSHI_SIZE : @14, SUSHI_INGREDIENT : @"8 maki, 2 räk, 1 tofu, 2 avokado, 1 omelette", LUNCH_PRICE : @125, ORDINARIE_PRICE : @145};
    [sushiInformation addObject:mamasSushi14Bitar];

    NSDictionary *vegSushi8Bitar = @{SUSHI_TYPE : @"Vegetarisk Sushi", SUSHI_SIZE : @8, SUSHI_INGREDIENT : @"4 maki, 1 tofu, 2 avokado, 1 omelette", LUNCH_PRICE : @70, ORDINARIE_PRICE : @90};
    [sushiInformation addObject:vegSushi8Bitar];

    NSDictionary *vegSushi10Bitar = @{SUSHI_TYPE : @"Vegetarisk Sushi", SUSHI_SIZE : @10, SUSHI_INGREDIENT : @"6 maki, 1 tofu, 2 avokado, 1 omelette", LUNCH_PRICE : @80, ORDINARIE_PRICE : @100};
    [sushiInformation addObject:vegSushi10Bitar];

    NSDictionary *vegSushi12Bitar = @{SUSHI_TYPE : @"Vegetarisk Sushi", SUSHI_SIZE : @12, SUSHI_INGREDIENT : @"6 maki, 2 tofu, 2 avokado, 2 omelette", LUNCH_PRICE : @95, ORDINARIE_PRICE : @115};
    [sushiInformation addObject:vegSushi12Bitar];

    NSDictionary *vegSushi14Bitar = @{SUSHI_TYPE : @"Vegetarisk Sushi", SUSHI_SIZE : @14, SUSHI_INGREDIENT : @"8 maki, 2 tofu, 2 avokado, 2 omelette", LUNCH_PRICE : @115, ORDINARIE_PRICE : @135};
    [sushiInformation addObject:vegSushi14Bitar];

    NSDictionary *deluxe20Bitar = @{SUSHI_TYPE : @"Deluxe Fat", SUSHI_SIZE : @20, SUSHI_INGREDIENT : @"10 maki + 10 nigiri", LUNCH_PRICE : @220, ORDINARIE_PRICE : @220};
    [sushiInformation addObject:deluxe20Bitar];

    NSDictionary *deluxe24Bitar = @{SUSHI_TYPE : @"Deluxe Fat", SUSHI_SIZE : @24, SUSHI_INGREDIENT : @"12 maki + 12 nigiri", LUNCH_PRICE : @265, ORDINARIE_PRICE : @265};
    [sushiInformation addObject:deluxe24Bitar];
    
    NSDictionary *familj30Bitar = @{SUSHI_TYPE : @"Familj Fat", SUSHI_SIZE : @30, SUSHI_INGREDIENT : @"15 maki + 15 nigiri", LUNCH_PRICE : @325, ORDINARIE_PRICE : @325};
    [sushiInformation addObject:familj30Bitar];
    
    NSDictionary *familj40Bitar = @{SUSHI_TYPE : @"Familj Fat", SUSHI_SIZE : @40, SUSHI_INGREDIENT : @"20 maki + 20 nigiri", LUNCH_PRICE : @435, ORDINARIE_PRICE : @435};
    [sushiInformation addObject:familj40Bitar];
    
    NSDictionary *lyx30Bitar = @{SUSHI_TYPE : @"Lyx Fat", SUSHI_SIZE : @30, SUSHI_INGREDIENT : @"10 sashimi + 10 maki + 10 nigiri", LUNCH_PRICE : @410, ORDINARIE_PRICE : @410};
    [sushiInformation addObject:lyx30Bitar];
    
    NSDictionary *lyx40Bitar = @{SUSHI_TYPE : @"Lyx Fat", SUSHI_SIZE : @40, SUSHI_INGREDIENT : @"14 sashimi + 13 maki + 13 nigiri", LUNCH_PRICE : @520, ORDINARIE_PRICE : @520};
    [sushiInformation addObject:lyx40Bitar];
    
    NSDictionary *omakaseSushi8Bitar = @{SUSHI_TYPE : @"Omakase Sushi", SUSHI_SIZE : @8, SUSHI_INGREDIENT : @"Kockens val", LUNCH_PRICE : @105, ORDINARIE_PRICE : @105};
    [sushiInformation addObject:omakaseSushi8Bitar];
    
    NSDictionary *omakaseSushi10Bitar = @{SUSHI_TYPE : @"Omakase Sushi", SUSHI_SIZE : @10, SUSHI_INGREDIENT : @"Kockens val", LUNCH_PRICE : @115, ORDINARIE_PRICE : @115};
    [sushiInformation addObject:omakaseSushi10Bitar];

    NSDictionary *omakaseSushi12Bitar = @{SUSHI_TYPE : @"Omakase Sushi", SUSHI_SIZE : @12, SUSHI_INGREDIENT : @"Kockens val", LUNCH_PRICE : @135, ORDINARIE_PRICE : @135};
    [sushiInformation addObject:omakaseSushi12Bitar];
    
    NSDictionary *omakaseSushi14Bitar = @{SUSHI_TYPE : @"Omakase Sushi", SUSHI_SIZE : @14, SUSHI_INGREDIENT : @"Kockens val", LUNCH_PRICE : @160, ORDINARIE_PRICE : @160};
    [sushiInformation addObject:omakaseSushi14Bitar];
    
    return [sushiInformation copy];
}

@end
