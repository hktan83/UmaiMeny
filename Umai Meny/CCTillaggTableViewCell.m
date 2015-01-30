//
//  CCTillaggTableViewCell.m
//  Umai Meny
//
//  Created by Caleb on 04/08/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCTillaggTableViewCell.h"

@implementation CCTillaggTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.quantityLabel.layer.cornerRadius = self.quantityLabel.frame.size.width/2.0;

}

@end
