//
//  CCSashimiTableViewCell.h
//  Umai Meny
//
//  Created by Caleb on 10/07/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CCSashimiTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *dishNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *quantityLabel;
@property (strong, nonatomic) IBOutlet UITextView *ingredientTextView;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *ordinarieLabel;
@property (strong, nonatomic) IBOutlet UIStepper *quantityStepper;

@end
