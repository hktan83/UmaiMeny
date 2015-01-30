//
//  CCTillaggTableViewCell.h
//  Umai Meny
//
//  Created by Caleb on 04/08/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCTillaggTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *dishNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *quantityLabel;
@property (strong, nonatomic) IBOutlet UIStepper *quantityStepper;



@end
