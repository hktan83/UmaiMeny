//
//  CCSideBarViewController.m
//  Umai Meny
//
//  Created by Caleb on 18/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCSideBarViewController.h"
#import "SWRevealViewController.h"
#import "CCMainMenuViewController.h"
#import "CCHomeViewController.h"
#import "CCBasketViewController.h"
#import "CCContactViewController.h"

@interface CCSideBarViewController ()

@property (strong, nonatomic) NSArray *menuItems;
@property (strong, nonatomic) NSArray *menuIcons;

@end

@implementation CCSideBarViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.separatorColor = [UIColor colorWithWhite:0.15f alpha:0.2f];
    

    self.menuItems = @[@"Nyheter", @"Meny", @"Korg", @"Kontakt"];
    self.menuIcons = @[@"news.png", @"bookmark.png", @"wishlist.png", @"map.png"];
    
//  Bokning View Controll will be opened in future development
//    self.menuItems = @[@"Nyheter", @"Meny", @"Korg", @"Bokning", @"Kontakt"];
//    self.menuIcons = @[@"news.png", @"bookmark.png", @"wishlist.png",@"calendar.png", @"map.png"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.menuItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *cellText = [self.menuItems objectAtIndex:indexPath.row];
    cell.textLabel.text = cellText;
    UIImage *images = [UIImage imageNamed:self.menuIcons[indexPath.row]];
    cell.imageView.image = images;
    
    cell.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    cell.textLabel.textColor = [UIColor colorWithWhite:2.5f alpha:0.5f];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"toHomeVCSegue" sender:nil];
    }
    else if (indexPath.row == 1){
        [self performSegueWithIdentifier:@"toMainMenuVCSegue" sender:nil];
    }
    else if (indexPath.row == 2){
        [self performSegueWithIdentifier:@"toBasketVCSegue" sender:nil];
    }
    else if (indexPath.row == 3){
        [self performSegueWithIdentifier:@"toContactVCSegue" sender:nil];
    }

    
    //  Bokning View Controll will be opened in future development

//    else if (indexPath.row == 3){
//        [self performSegueWithIdentifier:@"toBookingVCSegue" sender:nil];
//    }
//    else if (indexPath.row == 4){
//        [self performSegueWithIdentifier:@"toContactVCSegue" sender:nil];
//    }
    
}


#pragma mark - TableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Set the title of navigation bar by using the menu items
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    UINavigationController *destViewController = (UINavigationController *)segue.destinationViewController;
//    destViewController.title = [[self.menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    if ([segue.destinationViewController isKindOfClass:[CCHomeViewController class]]) {
        NSLog(@"To HomeVC segue");
    }
    if ([segue.destinationViewController isKindOfClass:[CCMainMenuViewController class]]) {
        NSLog(@"To MainMenuVC segue");
    }
    if ([segue.destinationViewController isKindOfClass:[CCBasketViewController class]]) {
        NSLog(@"To BasketVC segue");
    }
    
    if ([segue isKindOfClass:[SWRevealViewControllerSegue class]]) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue *)segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc){
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers:@[dvc] animated:NO];
            [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        };
    }
    
}


@end
