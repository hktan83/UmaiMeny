//
//  CCSushiTableViewCell.m
//  Umai Meny
//
//  Created by Caleb on 18/09/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCSushiTableViewCell.h"

@implementation CCSushiTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.quantityLabel.layer.cornerRadius = self.quantityLabel.frame.size.width/2.0;
}

@end
