//
//  CCMakiMenu.m
//  Umai Meny
//
//  Created by Caleb on 07/07/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCMakiMenu.h"

@implementation CCMakiMenu

+(NSArray *)maki
{
    NSMutableArray *makiInformation = [@[] mutableCopy];

    NSDictionary *drake = @{MAKI_MENU: @"Draken", MAKI_INGREDIENT: @"Tempurafriterade räkor, avokado, kryddig majonnäs, sesamfrö, paprikapulver" , MAKI_PRICE : @95, MAKI_IMAGE: @"Drake.png" };
    [makiInformation addObject:drake];
    
    NSDictionary *paki = @{MAKI_MENU: @"Paki", MAKI_INGREDIENT: @"Marinerad pepparlax, philadephiaost, avokado, japansk majonnäs, teriyaki sesamfrö", MAKI_PRICE : @100, MAKI_IMAGE: @"Paki.png" };
    [makiInformation addObject:paki];
    
    NSDictionary *rainbow = @{MAKI_MENU: @"Rainbow roll", MAKI_INGREDIENT: @"Krabröra, avokado, lax, tonfisk, tilapia, sesamsås", MAKI_PRICE: @120, MAKI_IMAGE: @"Rainbow.png"};
    [makiInformation addObject:rainbow];
    
    NSDictionary *oi = @{MAKI_MENU: @"Oi roll", MAKI_INGREDIENT: @"Lax, gräslök, avokado, unagisås", MAKI_PRICE: @110, MAKI_IMAGE: @"Oi.png"};
    [makiInformation addObject:oi];
    
    NSDictionary *rani = @{MAKI_MENU: @"Räni roll", MAKI_INGREDIENT: @"Tonfisk, avokado, philadephiaost, sesamfrö, kryddig majonnäs", MAKI_PRICE: @110, MAKI_IMAGE: @"Rani.png"};
    [makiInformation addObject:rani];
    
    NSDictionary *caterpillar = @{MAKI_MENU: @"Caterpillar", MAKI_INGREDIENT: @"Stekt lax, kryddig majonnäs, avokado, gräslök, flygfiskrom, unagisås", MAKI_PRICE: @115, MAKI_IMAGE: @"Caterpillar.png"};
    [makiInformation addObject:caterpillar];
    
    NSDictionary *crispyChicken = @{MAKI_MENU: @"Crispy Chicken roll", MAKI_INGREDIENT: @"Friterade kyckling, bladsallad, gurka, majonnäs, kimchi", MAKI_PRICE: @105, MAKI_IMAGE: @"Crispy.png"};
    [makiInformation addObject:crispyChicken];
    
    NSDictionary *beefRoll = @{MAKI_MENU: @"Beef roll", MAKI_INGREDIENT: @"Entrecote, gurka, salladslök, kryddig majonnäs med kimchi, sesamfrö", MAKI_PRICE: @105, MAKI_IMAGE: @"BeefRoll.png"};
    [makiInformation addObject:beefRoll];
    
    return [makiInformation copy];
}

@end
