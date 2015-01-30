//
//  CCForratterTableViewCell.m
//  Umai Meny
//
//  Created by Caleb on 18/07/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCForratterTableViewCell.h"

@implementation CCForratterTableViewCell



// Lasy instantiation
-(NSArray *)priceButtons
{
    if (!_priceButtons) {
        _priceButtons = [[NSArray alloc] initWithObjects:self.priceAButton, self.priceBButton, self.priceCButton, self.priceDButton, nil];
    }
    return _priceButtons;
}

-(NSArray *)quantityLabels
{
    if (!_quantityLabels) {
        _quantityLabels = [[NSArray alloc] initWithObjects:self.quantityALabel, self.quantityBLabel, self.quantityCLabel, self.quantityDLabel, nil];
    }
    return _quantityLabels;
}



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
    self.image.layer.borderWidth = 1.5;
    self.image.layer.borderColor = [[UIColor brownColor] CGColor];
    self.image.layer.masksToBounds = YES;
    self.image.clipsToBounds = YES;
    self.image.layer.cornerRadius = self.image.frame.size.width/2.0;
    
    self.quantityALabel.layer.cornerRadius = self.quantityALabel.frame.size.width/2.0;
    self.quantityBLabel.layer.cornerRadius = self.quantityBLabel.frame.size.width/2.0;
    self.quantityCLabel.layer.cornerRadius = self.quantityCLabel.frame.size.width/2.0;
    self.quantityDLabel.layer.cornerRadius = self.quantityDLabel.frame.size.width/2.0;
    
    // arrange the CAlayer hierarchy by using zPosition
    self.quantityALabel.layer.zPosition = 100;
    self.priceAButton.layer.zPosition = 99;
    
    self.quantityBLabel.layer.zPosition = 102;
    self.priceBButton.layer.zPosition = 101;
    
    self.quantityCLabel.layer.zPosition = 104;
    self.priceCButton.layer.zPosition = 103;
    
    self.quantityDLabel.layer.zPosition = 106;
    self.priceDButton.layer.zPosition = 105;
    
}




#pragma mark - IBActions

- (IBAction)trashButtonPressed:(UIButton *)sender
{
        [self.delegate setZeroQuantitylabel:sender];
}


- (IBAction)priceAButtonPressed:(UIButton *)sender {
    // add this condition to all the acions because need to get the index path of tapped cell contains the button
    [self.delegate updateQuantityLabel:sender atWhichColumn:(int)[self.priceButtons indexOfObject:self.priceAButton]];
}

- (IBAction)priceBButtonPressed:(UIButton *)sender {
    // add this condition to all the acions because need to get the index path of tapped cell contains the button
    [self.delegate updateQuantityLabel:sender atWhichColumn:(int)[self.priceButtons indexOfObject:self.priceBButton]];
}

- (IBAction)priceCButtonPressed:(UIButton *)sender {
    // add this condition to all the acions because need to get the index path of tapped cell contains the button
    [self.delegate updateQuantityLabel:sender atWhichColumn:(int)[self.priceButtons indexOfObject:self.priceCButton]];

}

- (IBAction)priceDButtonPressed:(UIButton *)sender {
    // add this condition to all the acions because need to get the index path of tapped cell contains the button
    [self.delegate updateQuantityLabel:sender atWhichColumn:(int)[self.priceButtons indexOfObject:self.priceDButton]];

}


@end
