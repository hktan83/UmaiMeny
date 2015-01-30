//
//  CCBasketViewController.h
//  Umai Meny
//
//  Created by Caleb on 07/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderBasket.h"


@interface CCBasketViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *orders;
@property (strong, nonatomic) OrderBasket *basket;

@end
