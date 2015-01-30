//
//  CCBookingViewController.h
//  Umai Meny
//
//  Created by Caleb on 19/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCBookingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;



@end
