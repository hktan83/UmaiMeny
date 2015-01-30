//
//  CCVarmrattTableViewController.h
//  Umai Meny
//
//  Created by Caleb on 29/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderBasket.h"

@interface CCVarmrattTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *varmrattMenus; 
@property (strong, nonatomic) NSMutableArray *selectedIndexPath;

@property (strong, nonatomic) OrderBasket *basket;
@property (strong, nonatomic) NSMutableArray *orderBaskets;





@end
