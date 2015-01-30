//
//  CCVarmratt.m
//  Umai Meny
//
//  Created by Caleb on 28/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCVarmratt.h"

@implementation CCVarmratt

+(NSArray *)varmratt
{
    NSMutableArray *varmrattInformation = [@[] mutableCopy];

    NSDictionary *yakitoriKycklingspett = @{VARMRATT: @"Yakitori Kycklingspett", VARMRATT_INGREDIENT: @"kycklingspett, yakitorisås, 2 maki, coleslaw, ris", LUNCH_PRICE: @80, ORDINARIE_PRICE: @95, SORTING: @1};
    [varmrattInformation addObject:yakitoriKycklingspett];
    
    NSDictionary *barnYakitori = @{VARMRATT: @"Barnportion Yakitori", VARMRATT_INGREDIENT: @"kycklingspett, yakitorisås, ris", ORDINARIE_PRICE: @50, SORTING: @2};
    [varmrattInformation addObject:barnYakitori];
    
    NSDictionary *stektLaxTeriyaki = @{VARMRATT: @"Stekt Lax Teriyaki", VARMRATT_INGREDIENT: @"Stekt Lax, Teriyakisås, 2 maki, coleslaw, ris", LUNCH_PRICE: @85, ORDINARIE_PRICE: @105, SORTING: @3};
    [varmrattInformation addObject:stektLaxTeriyaki];
    
    NSDictionary *barnLaxTeriyaki = @{VARMRATT: @"Barnportion Lax Teriyaki", VARMRATT_INGREDIENT: @"Stekt Lax, Teriyakisås, ris", ORDINARIE_PRICE: @60, SORTING: @4};
    [varmrattInformation addObject:barnLaxTeriyaki];
    
    NSDictionary *yakiniku = @{VARMRATT: @"Entrecote Yakiniku", VARMRATT_INGREDIENT: @"Entrecote, Yakinikusås, 2 maki, coleslaw, ris", LUNCH_PRICE: @95, ORDINARIE_PRICE: @115, SORTING: @5};
    [varmrattInformation addObject:yakiniku];

    NSDictionary *bento1 = @{VARMRATT: @"Bento 1", VARMRATT_INGREDIENT: @"Stekt lax, kycklingspett, 3 maki, coleslaw, ris", LUNCH_PRICE: @105, ORDINARIE_PRICE: @135, SORTING: @6};
    [varmrattInformation addObject:bento1];
    
    NSDictionary *bento2 = @{VARMRATT: @"Bento 2", VARMRATT_INGREDIENT: @"Entrecote, kycklingspett, 3 maki, coleslaw, ris", LUNCH_PRICE: @105, ORDINARIE_PRICE: @135, SORTING: @7};
    [varmrattInformation addObject:bento2];
    
    NSDictionary *bento3 = @{VARMRATT: @"Bento 3", VARMRATT_INGREDIENT: @"Entrecote, stekt lax, 3 maki, coleslaw, ris", LUNCH_PRICE: @110, ORDINARIE_PRICE: @140, SORTING: @8};
    [varmrattInformation addObject:bento3];
    
    NSDictionary *bento4MedEntrecote = @{VARMRATT: @"Bento 4 med entrecote", VARMRATT_INGREDIENT: @"Entrecote, tempura jätteräkor 2st, risnätvårulle 1st, 3 maki, coleslaw, ris", LUNCH_PRICE: @130, ORDINARIE_PRICE: @155, SORTING: @9};
    [varmrattInformation addObject:bento4MedEntrecote];
    
    NSDictionary *bento4MedStektLax = @{VARMRATT: @"Bento 4 med stekt lax", VARMRATT_INGREDIENT: @"Stekt lax, tempura jätteräkor 2st, risnätvårulle 1st, 3 maki, coleslaw, ris", LUNCH_PRICE: @130, ORDINARIE_PRICE: @155, SORTING: @10};
    [varmrattInformation addObject:bento4MedStektLax];
    
    NSDictionary *bento4MedKycklingspett = @{VARMRATT: @"Bento 4 med kycklingspett", VARMRATT_INGREDIENT: @"Kycklingspett, tempura jätteräkor 2st, risnätvårulle 1st, 3 maki, coleslaw, ris", LUNCH_PRICE: @120, ORDINARIE_PRICE: @145, SORTING: @11};
    [varmrattInformation addObject:bento4MedKycklingspett];
    
    NSDictionary *bento5MedEntrecote = @{VARMRATT: @"Bento 5 med entrecote", VARMRATT_INGREDIENT: @"Entrecote, gyoza 5st, 3 maki, coleslaw, ris", LUNCH_PRICE: @150, ORDINARIE_PRICE: @150, SORTING: @12};
    [varmrattInformation addObject:bento5MedEntrecote];
    
    NSDictionary *bento5MedStektLax = @{VARMRATT: @"Bento 5 med stekt lax", VARMRATT_INGREDIENT: @"Stekt lax, gyoza 5st, 3 maki, coleslaw, ris", LUNCH_PRICE: @145 , ORDINARIE_PRICE: @145, SORTING: @13};
    [varmrattInformation addObject:bento5MedStektLax];
    
    NSDictionary *bento5MedKycklingspett = @{VARMRATT: @"Bento 5 med kycklingspett", VARMRATT_INGREDIENT: @"Kycklingspett, gyoza 5st, 3 maki, coleslaw, ris", LUNCH_PRICE: @140, ORDINARIE_PRICE: @140, SORTING: @14};
    [varmrattInformation addObject:bento5MedKycklingspett];
    
    
    return [varmrattInformation copy];
}

@end
