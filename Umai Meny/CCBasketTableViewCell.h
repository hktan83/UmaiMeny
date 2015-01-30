//
//  CCBasketTableViewCell.h
//  Umai Meny
//
//  Created by Caleb on 08/10/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCBasketTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dishLabel;
@property (strong, nonatomic) IBOutlet UILabel *quantityLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@end
