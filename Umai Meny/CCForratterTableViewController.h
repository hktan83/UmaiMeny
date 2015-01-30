//
//  CCForratterTableViewController.h
//  Umai Meny
//
//  Created by Caleb on 06/07/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCForratterTableViewCell.h"
#import "CCForratter.h"
#import "CCMenu.h"
#import "OrderBasket.h"

@interface CCForratterTableViewController : UITableViewController <CCForratterTableViewCellDelegate>

@property (strong, nonatomic) NSMutableArray *forratterMenus;
@property (strong, nonatomic) CCMenu *menu;

@property (strong, nonatomic) OrderBasket *basket;
@property (strong, nonatomic) NSMutableArray *orderBaskets;

@end
