//
//  CCForratterTableViewCell.h
//  Umai Meny
//
//  Created by Caleb on 18/07/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCForratter.h"
#import "CCMenu.h"

@protocol CCForratterTableViewCellDelegate <NSObject>

-(void)updateQuantityLabel:(UIButton *)button atWhichColumn:(int)column;
-(void)setZeroQuantitylabel:(UIButton *)button;

@end


@interface CCForratterTableViewCell : UITableViewCell
@property (weak, nonatomic) id <CCForratterTableViewCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *dishNameLabel;


//IBActions
- (IBAction)trashButtonPressed:(UIButton *)sender;
- (IBAction)priceAButtonPressed:(UIButton *)sender;
- (IBAction)priceBButtonPressed:(UIButton *)sender;
- (IBAction)priceCButtonPressed:(UIButton *)sender;
- (IBAction)priceDButtonPressed:(UIButton *)sender;


// IBOutlets
@property (strong, nonatomic) IBOutlet UIButton *priceAButton;
@property (strong, nonatomic) IBOutlet UIButton *priceBButton;
@property (strong, nonatomic) IBOutlet UIButton *priceCButton;
@property (strong, nonatomic) IBOutlet UIButton *priceDButton;

@property (strong, nonatomic) IBOutlet UILabel *quantityALabel;
@property (strong, nonatomic) IBOutlet UILabel *quantityBLabel;
@property (strong, nonatomic) IBOutlet UILabel *quantityCLabel;
@property (strong, nonatomic) IBOutlet UILabel *quantityDLabel;


@property (strong, nonatomic) NSArray *priceButtons;
@property (strong, nonatomic) NSArray *quantityLabels;
@property (strong, nonatomic) CCMenu *menu;


@end
