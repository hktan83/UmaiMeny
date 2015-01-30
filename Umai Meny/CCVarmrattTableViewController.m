//
//  CCVarmrattTableViewController.m
//  Umai Meny
//
//  Created by Caleb on 29/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCVarmrattTableViewController.h"
#import "CCVarmrattTableViewCell.h"
#import "CCCoreDataHelper.h"
#import "CCMenu.h"
#import "CCVarmratt.h"
#import "Varmratt.h"

@interface CCVarmrattTableViewController ()
- (IBAction)tommaBarButtonPressed:(UIBarButtonItem *)sender;


@end

@implementation CCVarmrattTableViewController



#pragma mark - lazy instantiation
-(NSMutableArray *) varmrattMenus
{
    if (!_varmrattMenus) {
        _varmrattMenus = [[NSMutableArray alloc] init];
    }
    return _varmrattMenus;
}

-(NSMutableArray *) selectedIndexPath
{
    if (!_selectedIndexPath) {
        _selectedIndexPath = [[NSMutableArray alloc] init];
    }
    return _selectedIndexPath;
}

-(NSMutableArray *)orderBaskets
{
    if (!_orderBaskets) {
        _orderBaskets = [[NSMutableArray alloc] init];
    }
    return _orderBaskets;
}

#pragma mark - View
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
    
    // FetchRequest Varmratt entity from Core Data
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Varmratt"];

    NSSortDescriptor *sortingDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sorting" ascending:YES];
    fetchRequest.sortDescriptors = @[sortingDescriptor];
    
    NSError *error = nil;
    
    NSArray *fetchVarmratt = [[CCCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    self.varmrattMenus = [fetchVarmratt mutableCopy];
    
    if (![self.varmrattMenus count] > 0) {
        // Iterate all the data in CCVarmratt if no data in Varmratt entity
        for (NSMutableDictionary *varmrattData in [CCVarmratt varmratt])
        {
            CCMenu *menu = [[CCMenu alloc] initWithVarmrattData:varmrattData];
            [self.varmrattMenus addObject:[self varmrattWithName:menu]];
        }
    }
    
    //FetchRequest OrderBasket entity from Core Data
    NSFetchRequest *fetchRequestBaskset = [NSFetchRequest fetchRequestWithEntityName:@"OrderBasket"];
    NSError *errorBasket = nil;
    
    NSArray *fetchBasket = [[CCCoreDataHelper managedObjectContext]executeFetchRequest:fetchRequestBaskset error:&errorBasket];
    self.orderBaskets = [fetchBasket mutableCopy];
    
    self.title = @"Varmrätt";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.varmrattMenus count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCVarmrattTableViewCell *cell = (CCVarmrattTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    
    Varmratt *selectedVarmratt = [self.varmrattMenus objectAtIndex:indexPath.row];
    [cell.quantityStepper setHidden:YES];
    [cell.quantityLabel setHidden:YES];
    [cell.ingredientTextView setHidden:YES];
    [cell.lunchLabel setHidden:YES];
    [cell.lunchPriceLabel setHidden:YES];
    [cell.ordinarieLabel setHidden:YES];
    [cell.ordinariePriceLabel setHidden:YES];
    
    cell.dishNameLabel.text = [NSString stringWithFormat:@"%@", selectedVarmratt.name];

    cell.ingredientTextView.text = selectedVarmratt.ingredient;
    cell.ingredientTextView.userInteractionEnabled = NO;
    
    if ([self.selectedIndexPath containsObject:indexPath]) {
        [cell.quantityStepper setHidden:NO];
        [cell.ingredientTextView setHidden:NO];
        [cell.lunchLabel setHidden:NO];
        [cell.lunchPriceLabel setHidden:NO];
        [cell.ordinarieLabel setHidden:NO];
        [cell.ordinariePriceLabel setHidden:NO];
        
        // no lunch price for Barn and Bento 5
        if ([selectedVarmratt.name containsString:@"Barn"] || [selectedVarmratt.name containsString:@"Bento 5"]) {
            [cell.lunchLabel setHidden:YES];
            [cell.lunchPriceLabel setHidden:YES];
        }
        
        cell.lunchPriceLabel.text = [NSString stringWithFormat:@"%@ kr", selectedVarmratt.lunchPrice];
        cell.ordinariePriceLabel.text = [NSString stringWithFormat:@"%@ kr", selectedVarmratt.ordinariePrice];
        
        cell.quantityStepper.value = [selectedVarmratt.orderQuantity doubleValue];
        cell.quantityStepper.tag = indexPath.row;
        [cell.quantityStepper addTarget:self action:@selector(incrementStepper:) forControlEvents:UIControlEventValueChanged];
    
    }
    cell.quantityLabel.text = [NSString stringWithFormat:@"%@", selectedVarmratt.orderQuantity];
    
    int orderQuantity = [selectedVarmratt.orderQuantity intValue];
    if (orderQuantity == 0) {
        cell.quantityLabel.hidden = YES;
    }
    else {
        cell.quantityLabel.hidden = NO;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - Table View delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Future development, cell expands according to the total height of several components
    if ([self.selectedIndexPath containsObject:indexPath]) {
        return 135;
    }
    
    else {
        return 50;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self addOrRemoveSelectedIndexPath:indexPath];
}


#pragma mark - Helper methods
/* Helper method which persists a VARMRATT object using Core Data to file system */
-(Varmratt *)varmrattWithName: (CCMenu *)menu
{
    NSManagedObjectContext *context = [CCCoreDataHelper managedObjectContext];
    
    Varmratt *varmratt = [NSEntityDescription insertNewObjectForEntityForName:@"Varmratt" inManagedObjectContext:context];
    varmratt.name = menu.varmratt;
    varmratt.ingredient = menu.varmrattIngredient;
    varmratt.lunchPrice = [NSNumber numberWithInt:menu.varmrattLunchPrice];
    varmratt.ordinariePrice = [NSNumber numberWithInt:menu.varmrattOrdinariePrice];
    varmratt.orderQuantity = [NSNumber numberWithInt:menu.varmrattOrderQuantity];
    
    // NSManagedObjectContext is autosave in the background
    NSError *error = nil;
    if (![context save:&error]) { // &error is pointer of the pointer to error object
        NSLog(@"%@", error); // we have an error
    }
    
    return varmratt;
}

/* Helper method which persists a OrderBaskset object using Core Data to file system*/
-(OrderBasket *)orderBasketInsertObject
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

-(void) updateOrderBasketObject: (Varmratt *)selectedVarmratt
{
    if ([self.orderBaskets count] == 0) {
        [self.orderBaskets addObject:[self orderBasketInsertObject]];
        self.basket = [self.orderBaskets lastObject];
        selectedVarmratt.orderBasket = self.basket; // build relationship with OrderBasket entity
    }
    
    else {
        self.basket = [self.orderBaskets lastObject];
        selectedVarmratt.orderBasket = self.basket; // build relationship with OrderBasket entity
    }
    
    int orderQuantity = [selectedVarmratt.orderQuantity intValue];
    if (orderQuantity == 0) {
        selectedVarmratt.orderBasket = nil; // remove relationship with OrderBasket entity
    }
    
    [self refreshCoreData];
}


-(void)addOrRemoveSelectedIndexPath:(NSIndexPath *)indexPath
{
    BOOL containsIndexPath = [self.selectedIndexPath containsObject:indexPath];
    
    if (containsIndexPath) {
        [self.selectedIndexPath removeObject:indexPath];
    }
    else {
        [self.selectedIndexPath addObject:indexPath];
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)incrementStepper:(UIStepper *)stepper
{
    Varmratt *varmratt = [self.varmrattMenus objectAtIndex:stepper.tag];
    varmratt.orderQuantity = [NSNumber numberWithDouble:stepper.value];
    
    [self refreshCoreData];
    [self updateOrderBasketObject:varmratt];
    
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


#pragma mark - IBActions
- (IBAction)tommaBarButtonPressed:(UIBarButtonItem *)sender
{
    // reset all orderQuantity to be 0
    for (Varmratt *varmratt in self.varmrattMenus) {
        varmratt.orderQuantity = [NSNumber numberWithInt:0];
        [self updateOrderBasketObject:varmratt];
    }
    [self refreshCoreData];
    
    [self.tableView reloadData];
}
@end
