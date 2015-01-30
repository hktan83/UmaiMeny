//
//  CCForratter.m
//  Umai Meny
//
//  Created by Caleb on 07/07/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCForratter.h"

@implementation CCForratter

+(NSArray *)forratter
{
    NSMutableArray *forratterInformation = [@[] mutableCopy];
    
    NSDictionary *vegMini = @{FORRATTER: @"Vegetarisk mini-vårrulle", FORRATTER_SIZE: @[@4,@6,@8,@10], FORRATTER_PRICE: @[@20,@30,@35,@45], FORRATTER_IMAGE: @"miniVar.jpg"};
    [forratterInformation addObject:vegMini];
    
    NSDictionary *tempura = @{FORRATTER: @"Tempura jätteräkor", FORRATTER_SIZE: @[@1],FORRATTER_PRICE : @[@40], FORRATTER_IMAGE : @"tempura.jpg" };
    [forratterInformation addObject:tempura];
    
    NSDictionary *risnat = @{FORRATTER: @"Risnätvårrulle", FORRATTER_SIZE: @[@4,@6,@8,@10], FORRATTER_PRICE:@[@40, @60, @75, @90] , FORRATTER_IMAGE: @"risnatVar.jpg"};
    [forratterInformation addObject:risnat];
    
    NSDictionary *kycklingvingar = @{FORRATTER: @"Kycklingvingar", FORRATTER_SIZE: @[@2,@4,@6], FORRATTER_PRICE:@[@30,@55,@80], FORRATTER_IMAGE: @"kycklingvingar.jpg"};
    [forratterInformation addObject:kycklingvingar];
    
    NSDictionary *gyoza = @{FORRATTER: @"Gyoza dumpling", FORRATTER_SIZE: @[@4,@6,@8,@10], FORRATTER_PRICE:@[@40,@60,@75,@90], FORRATTER_IMAGE: @"gyoza.jpg"};
    [forratterInformation addObject:gyoza];
    
    NSDictionary *ris = @{FORRATTER: @"Extra ris", FORRATTER_SIZE: @[@1],FORRATTER_PRICE: @[@15], FORRATTER_IMAGE : @"ris.jpg"};
    [forratterInformation addObject:ris];
    
    NSDictionary *edamame = @{FORRATTER: @"Edamame bönor (40g)", FORRATTER_SIZE: @[@1],FORRATTER_PRICE: @[@25], FORRATTER_IMAGE : @"edamame.jpg"};
    [forratterInformation addObject:edamame];
    
    return [forratterInformation copy];
}


@end
