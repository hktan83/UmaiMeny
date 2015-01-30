//
//  CCMainMenuViewController.m
//  Umai Meny
//
//  Created by Caleb on 07/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCMainMenuViewController.h"
#import "SWRevealViewController.h"
#import "CCSashimiTableViewController.h"


@interface CCMainMenuViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSString *menuType;
@property (strong, nonatomic) IBOutlet UIButton *sushiButton;
@property (strong, nonatomic) IBOutlet UIButton *varmrattButton;
@property (strong, nonatomic) IBOutlet UIButton *forratterButton;
@property (strong, nonatomic) IBOutlet UIButton *sashimiButton;
@property (strong, nonatomic) IBOutlet UIButton *makiMenyButton;
@property (strong, nonatomic) IBOutlet UIButton *tillaggButton;


@end

@implementation CCMainMenuViewController

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
    
    //Change button color
    self.sidebarButton.tintColor = [UIColor redColor];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar
    self.sidebarButton.target = self.revealViewController;
    self.sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self iPhone4SAdaption];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)forratterButtonPressed:(UIButton *)sender
{
    self.menuType = @"forratter";
//    [self performSegueWithIdentifier:@"toForratterVCSegue" sender:nil];
}

- (IBAction)sashimiButtonPressed:(UIButton *)sender
{
    self.menuType = @"sashimi";
    [self performSegueWithIdentifier:@"toSashimiVCSegue" sender:nil];

}

- (IBAction)makiMenuButtonPressed:(UIButton *)sender
{
    self.menuType = @"Maki Meny";
    [self performSegueWithIdentifier:@"toSashimiVCSegue" sender:nil];
}

- (IBAction)tillaggButtonPressed:(UIButton *)sender
{
    self.menuType = @"tillagg";
}


 #pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if ([[segue identifier] isEqualToString:@"toSashimiVCSegue"])
     {
         CCSashimiTableViewController *nextVC = segue.destinationViewController;
         nextVC.menuType = self.menuType;
     }
 }


#pragma mark - iPhone 4S Adaption
- (void)iPhone4SAdaption
{
    // iPhone 4S adaption
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect navBarFrame = self.navigationController.navigationBar.frame;
    
    
    if (screenBounds.size.height == 480) {
        CGFloat minX = CGRectGetMinX(screenBounds);
        CGFloat minY = CGRectGetMinY(screenBounds);
        CGFloat maxX = CGRectGetMaxX(screenBounds);
        CGFloat statusBarFrameHeight = CGRectGetHeight(statusBarFrame);
        CGFloat navBarFrameHeight = CGRectGetHeight(navBarFrame);
        CGFloat statusAndNavBarFrameHeight = statusBarFrameHeight + navBarFrameHeight;
        CGFloat totalButtonsFrameHeight = screenBounds.size.height - statusAndNavBarFrameHeight;
        CGFloat singleButtonFrameHeight = totalButtonsFrameHeight/6;
        
        self.sushiButton.frame = CGRectMake(minX, minY+statusAndNavBarFrameHeight, maxX, singleButtonFrameHeight);
        self.varmrattButton.frame = CGRectMake(minX, minY+statusAndNavBarFrameHeight+1*(singleButtonFrameHeight), maxX, singleButtonFrameHeight);
        self.forratterButton.frame = CGRectMake(minX, minY+statusAndNavBarFrameHeight+2*(singleButtonFrameHeight), maxX, singleButtonFrameHeight);
        self.sashimiButton.frame = CGRectMake(minX, minY+statusAndNavBarFrameHeight+3*(singleButtonFrameHeight), maxX, singleButtonFrameHeight);
        self.makiMenyButton.frame = CGRectMake(minX, minY+statusAndNavBarFrameHeight+4*(singleButtonFrameHeight), maxX, singleButtonFrameHeight);
        self.tillaggButton.frame = CGRectMake(minX, minY+statusAndNavBarFrameHeight+5*(singleButtonFrameHeight), maxX, singleButtonFrameHeight);
    }
    

}


@end
