//
//  CCTillaggTableViewController.h
//  Umai Meny
//
//  Created by Caleb on 04/08/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTillaggTableViewCell.h"
#import "OrderBasket.h"

@interface CCTillaggTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *menus;

@property (strong, nonatomic) OrderBasket *basket;
@property (strong, nonatomic) NSMutableArray *orderBaskets;


@end
