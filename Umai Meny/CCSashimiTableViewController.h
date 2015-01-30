//
//  CCSashimiTableViewController.h
//  Umai Meny
//
//  Created by Caleb on 07/07/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderBasket.h"

@interface CCSashimiTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *menus;        // for without Core Data
@property (strong, nonatomic) NSMutableArray *sashimiMenus; // for Core Data Sashimi entity
@property (strong, nonatomic) NSMutableArray *makiMenus;    // for Core Data MakiMenu entity
@property (strong, nonatomic) NSMutableArray *selectedIndexPath;
@property (strong,nonatomic) NSString *menuType;            // to distinguish Sashimi or MakiMenu eneity

@property (strong, nonatomic) OrderBasket *basket;
@property (strong, nonatomic) NSMutableArray *orderBaskets;

@end
