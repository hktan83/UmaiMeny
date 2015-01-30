//
//  CCSashimi.m
//  Umai Meny
//
//  Created by Caleb on 07/07/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCSashimi.h"


@implementation CCSashimi


+(NSArray *)sashimi
{
    NSMutableArray *sashimiInformation = [@[] mutableCopy];
    
    NSDictionary *laxSashimi = @{SASHIMI : @"Lax Sashimi", SASHIMI_INGREDIENT : @"6 laxskivor", SASHIMI_PRICE : @130 , SASHIMI_IMAGE : @"laxSashimi.jpg"};
    [sashimiInformation addObject:laxSashimi];
    
    NSDictionary *laxSashimiMaki = @{SASHIMI: @"Lax Sashimi och maki", SASHIMI_INGREDIENT : @"6 laxskivor, 4 makirullar", SASHIMI_PRICE : @155, SASHIMI_IMAGE : @"laxSashimiMaki.jpg"};
    [sashimiInformation addObject:laxSashimiMaki];
    
    NSDictionary *sashimiMix = @{SASHIMI: @"Sashimi Mix", SASHIMI_INGREDIENT: @"4 lax, 2 tonfisk, 2 hamachi, 2 pilgrimsmusslor, 4 ama-abi", SASHIMI_PRICE: @180, SASHIMI_IMAGE : @"sashimiMix.jpg"};
    [sashimiInformation addObject:sashimiMix];
    
    NSDictionary *sashimiCombo = @{SASHIMI: @"Sashimi Sushi Combo", SASHIMI_INGREDIENT : @"3 lax, 2 tonfisk, 1 hamachi, 2 pilgrimsmusslor, 4 ama-abi, 6 maki rullar", SASHIMI_PRICE: @215, SASHIMI_IMAGE : @"sashimiSushiCombo.jpg"};
    [sashimiInformation addObject:sashimiCombo];
    
    
    return [sashimiInformation copy];
}

@end
