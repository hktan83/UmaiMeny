//
//  CCSushiTableViewCell.h
//  Umai Meny
//
//  Created by Caleb on 18/09/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCSushiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sushiLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UIStepper *quantityStepper;
@property (weak, nonatomic) IBOutlet UITextView *ingredientTextView;
@property (weak, nonatomic) IBOutlet UILabel *lunchLabel;
@property (weak, nonatomic) IBOutlet UILabel *lunchPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *ordinarieLabel;
@property (weak, nonatomic) IBOutlet UILabel *ordinariePriceLabel;

@end
