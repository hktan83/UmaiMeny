//
//  CCSushiMenuViewController.m
//  Umai Meny
//
//  Created by Caleb on 22/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCSushiMenuViewController.h"
#import "CCSushiTableViewController.h"

@interface CCSushiMenuViewController ()

@property (strong, nonatomic) NSString * sushiType;
@property (strong, nonatomic) IBOutlet UILabel *standardLabel;
@property (strong, nonatomic) IBOutlet UILabel *vegetariskLabel;
@property (strong, nonatomic) IBOutlet UILabel *fatLabel;
@property (strong, nonatomic) IBOutlet UILabel *mamasLabel;
@property (strong, nonatomic) IBOutlet UILabel *utanRaRiskLabel;
@property (strong, nonatomic) IBOutlet UILabel *omakaseLabel;
@property (strong, nonatomic) IBOutlet UILabel *kockensValLabel;



@end

@implementation CCSushiMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    float buttonBorderWidth = 1.5;
    CGColorRef buttonBorderColor = [[UIColor brownColor] CGColor];
    
    
    self.standardButton.layer.cornerRadius = self.standardButton.frame.size.width/2.0;
    self.standardButton.layer.borderWidth = buttonBorderWidth;
    self.standardButton.layer.borderColor = buttonBorderColor;
    self.standardButton.clipsToBounds = YES;
    
    self.mamasButton.layer.cornerRadius = self.mamasButton.frame.size.width/2.0;
    self.mamasButton.layer.borderWidth = buttonBorderWidth;
    self.mamasButton.layer.borderColor = buttonBorderColor;
    self.mamasButton.clipsToBounds = YES;
    
    self.vegetariskButton.layer.cornerRadius = self.vegetariskButton.frame.size.width/2.0;
    self.vegetariskButton.layer.borderWidth = buttonBorderWidth;
    self.vegetariskButton.layer.borderColor = buttonBorderColor;
    self.vegetariskButton.clipsToBounds = YES;
    
    self.fatButton.layer.cornerRadius = self.fatButton.frame.size.width/2.0;
    self.fatButton.layer.borderWidth = buttonBorderWidth;
    self.fatButton.layer.borderColor = buttonBorderColor;
    self.fatButton.clipsToBounds = YES;
    
    self.omakaseButton.layer.cornerRadius = self.omakaseButton.frame.size.width/2.0;
    self.omakaseButton.layer.borderWidth = buttonBorderWidth;
    self.omakaseButton.layer.borderColor = buttonBorderColor;
    self.omakaseButton.clipsToBounds = YES;
    
    [self iPhone4SAdaption];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - IBActions

- (IBAction)standardButtonPressed:(UIButton *)sender {
    self.sushiType = @"Standard Sushi";
    [self performSegueWithIdentifier:@"toSushiTableVCSegue" sender:nil];
}

- (IBAction)mamasButtonPressed:(UIButton *)sender {
    self.sushiType = @"Mamas Sushi";
    [self performSegueWithIdentifier:@"toSushiTableVCSegue" sender:nil];
}

- (IBAction)vegetariskButtonPressed:(UIButton *)sender {
    self.sushiType = @"Vegetarisk Sushi";
    [self performSegueWithIdentifier:@"toSushiTableVCSegue" sender:nil];
}

- (IBAction)fatButtonPressed:(UIButton *)sender {
    self.sushiType = @"Fat";
    [self performSegueWithIdentifier:@"toSushiTableVCSegue" sender:nil];
}

- (IBAction)omakaseButtonPressed:(UIButton *)sender {
    self.sushiType = @"Omakase Sushi";
    [self performSegueWithIdentifier:@"toSushiTableVCSegue" sender:nil];
}


#pragma mark - Navigation Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toSushiTableVCSegue"]) {
        CCSushiTableViewController *nextViewController = segue.destinationViewController;
        nextViewController.sushiType = self.sushiType;
    }
}


-(void) iPhone4SAdaption
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 480) {
        self.standardButton.frame = CGRectMake(40, 70, 100, 100);
        self.mamasButton.frame =    CGRectMake(180, 70, 100, 100);
        self.vegetariskButton.frame=CGRectMake(40, 220, 100, 100);
        self.fatButton.frame =      CGRectMake(180, 220, 100, 100);
        self.omakaseButton.frame =  CGRectMake(111, 350, 100, 100);
        
        self.standardLabel.frame =  CGRectMake(40, 175, 150, 20);
        self.mamasLabel.frame =     CGRectMake(190, 175, 150, 20);
        self.utanRaRiskLabel.frame =CGRectMake(195, 195, 150, 20);
        self.vegetariskLabel.frame =CGRectMake(40, 320, 150, 30);
        self.fatLabel.frame =       CGRectMake(210, 325, 150, 20);
        self.omakaseLabel.frame = CGRectMake(111, 450, 150, 20);
    }
}

@end
