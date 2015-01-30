//
//  CCSushiMenuViewController.h
//  Umai Meny
//
//  Created by Caleb on 22/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCSushiMenuViewController : UIViewController

- (IBAction)standardButtonPressed:(UIButton *)sender;
- (IBAction)mamasButtonPressed:(UIButton *)sender;
- (IBAction)vegetariskButtonPressed:(UIButton *)sender;
- (IBAction)fatButtonPressed:(UIButton *)sender;
- (IBAction)omakaseButtonPressed:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton *standardButton;
@property (strong, nonatomic) IBOutlet UIButton *mamasButton;
@property (strong, nonatomic) IBOutlet UIButton *vegetariskButton;
@property (strong, nonatomic) IBOutlet UIButton *fatButton;
@property (strong, nonatomic) IBOutlet UIButton *omakaseButton;




@end
