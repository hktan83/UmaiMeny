//
//  CCTillaggTableViewController.m
//  Umai Meny
//
//  Created by Caleb on 04/08/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCTillaggTableViewController.h"
#import "CCCoreDataHelper.h"
#import "CCMenu.h"
#import "CCTillagg.h"
#import "Tillagg.h"

@interface CCTillaggTableViewController ()
- (IBAction)tillaggBarButtonPressed:(UIBarButtonItem *)sender;

@end

@implementation CCTillaggTableViewController

#pragma mark - Lazy instantiation
-(NSMutableArray *) menus
{
    if (!_menus) {
        _menus = [[NSMutableArray alloc]init];
    }
    return _menus;
}

-(NSMutableArray *) orderBaskets
{
    if (!_orderBaskets) {
        _orderBaskets = [[NSMutableArray alloc] init];
    }
    return _orderBaskets;
}


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

    // FetchRequest Tillagg entity from Core Data
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tillagg"];
    
    NSError *error = nil;
    
    NSArray *fetchTillagg = [[CCCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    self.menus = [fetchTillagg mutableCopy];
    
    if (![self.menus count] > 0) {
        // Iterate all the data in CCTillagg if no data in Tillagg entity
        for (NSDictionary *data in [CCTillagg tillagg]) {
            CCMenu *menu = [[CCMenu alloc] initWithTillaggData:data];
            [self.menus addObject:[self tillaggWithName:menu]];
        }
    }
    
    // FetchRequest OrderBasket entity from Core Data
    NSFetchRequest *fetchRequestBasket = [NSFetchRequest fetchRequestWithEntityName:@"OrderBasket"];
    NSError *errorBasket = nil;
    
    NSArray *fetchBasket = [[CCCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequestBasket error:&errorBasket];
    self.orderBaskets = [fetchBasket mutableCopy];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.title = @"Tillägg";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menus count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCTillaggTableViewCell *cell = (CCTillaggTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Tillagg *selectedTillagg = [self.menus objectAtIndex:indexPath.row];
    
    cell.dishNameLabel.text = selectedTillagg.name;
    cell.priceLabel.text = [NSString stringWithFormat:@"%@:-", selectedTillagg.price];
    
    cell.quantityStepper.value = [selectedTillagg.orderQuantity doubleValue];
    cell.quantityStepper.tag = indexPath.row;
    [cell.quantityStepper addTarget:self action:@selector(incrementStepper:) forControlEvents:UIControlEventValueChanged];
    cell.quantityLabel.text = [NSString stringWithFormat:@"%@", selectedTillagg.orderQuantity];

    int orderQuantity = [selectedTillagg.orderQuantity intValue];
    
    if (orderQuantity == 0) {
        cell.quantityLabel.hidden = YES;
    }
    else {
        cell.quantityLabel.hidden = NO;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - Helper methods
// Helper method which persists a Tillagg object using Core Data to file system
-(Tillagg *)tillaggWithName: (CCMenu *)menu
{
    NSManagedObjectContext *context = [CCCoreDataHelper managedObjectContext];
    
    Tillagg *tillagg = [NSEntityDescription insertNewObjectForEntityForName:@"Tillagg" inManagedObjectContext:context];
    tillagg.name = menu.tillagg;
    tillagg.price = [NSNumber numberWithInt:menu.tillaggPrice];
    tillagg.orderQuantity = [NSNumber numberWithInt:menu.tillaggOrderQuantity];
    
    // NSManageObjectContext is autosave in the background
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"%@", error);
    }
    
    return tillagg;
}

/* Helper method which persists a OrderBaskset object using Core Data to file system*/
-(OrderBasket *) orderBasketInsertObject
{
    NSManagedObjectContext *context = [CCCoreDataHelper managedObjectContext];
    OrderBasket *basket = [NSEntityDescription insertNewObjectForEntityForName:@"OrderBasket" inManagedObjectContext:context];
    
    NSError *error = nil;
    // NSManagedObjectContext is autosave in the background
    if (![context save:&error]) {   // error is pointer of the pointer to error object
        NSLog(@"%@", error);        // we have an error
    }
    
    return basket;
}

-(void) updateOrderBasketObject: (Tillagg *)selectedTillagg
{
    if ([self.orderBaskets count] == 0) {
        [self.orderBaskets addObject:[self orderBasketInsertObject]];
        self.basket = [self.orderBaskets lastObject];
        selectedTillagg.orderBasket = self.basket; // build relationship with OrderBasket entity
    }
    else {
        self.basket = [self.orderBaskets lastObject];
        selectedTillagg.orderBasket = self.basket; // build relationship with OrderBasket entity
    }
    
    int orderQuantity = [selectedTillagg.orderQuantity intValue];
    if (orderQuantity == 0) {
        selectedTillagg.orderBasket = nil; // remove relationship with OrderBasket entity
    }
    
    [self refreshCoreData];
}



-(void)incrementStepper:(UIStepper *)stepper
{
    Tillagg *tillagg = [self.menus objectAtIndex:stepper.tag];
    tillagg.orderQuantity = [NSNumber numberWithDouble:stepper.value];
    
    [self refreshCoreData];
    [self updateOrderBasketObject:tillagg];
    
    [self.tableView reloadData];
}

-(void)refreshCoreData
{
    NSManagedObjectContext *context = [CCCoreDataHelper managedObjectContext];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"%@", error);
    }
}



- (IBAction)tillaggBarButtonPressed:(UIBarButtonItem *)sender
{
    for (Tillagg *tillagg in self.menus) {
        tillagg.orderQuantity = [NSNumber numberWithInt:0];
        [self updateOrderBasketObject:tillagg];
    }
    
    [self refreshCoreData];
    [self.tableView reloadData];
}
@end
