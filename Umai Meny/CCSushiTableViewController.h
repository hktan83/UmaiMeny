//
//  CCViewController.h
//  Umai Meny
//
//  Created by Caleb on 05/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderBasket.h"


@interface CCSushiTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *sushiMenus; // section 0
@property (strong, nonatomic) NSMutableArray *selectedIndexPath;
@property (strong, nonatomic) NSString *sushiType;
@property (strong, nonatomic) OrderBasket *basket;
@property (strong, nonatomic) NSMutableArray *orderBaskets;

- (IBAction)tommaBarButtonPressed:(UIBarButtonItem *)sender;

@end
