//
//  CCSashimiTableViewCell.m
//  Umai Meny
//
//  Created by Caleb on 10/07/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCSashimiTableViewCell.h"

@implementation CCSashimiTableViewCell

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
    self.ingredientTextView.userInteractionEnabled = NO;
    self.imageView.layer.borderWidth = 1.5;
    self.imageView.layer.borderColor = [[UIColor brownColor] CGColor];
    self.imageView.layer.masksToBounds = YES;
    self.imageView.clipsToBounds = YES;
    
    self.quantityLabel.layer.cornerRadius = self.quantityLabel.frame.size.width/2.0;
    // arrange the CAlayer hierarchy by using zPosition
    self.quantityLabel.layer.zPosition = 1;
    self.image.layer.zPosition = 2;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(5, 5, 70, 70);

    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2.0;    
    
}


@end
