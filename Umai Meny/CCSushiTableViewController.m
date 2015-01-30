//
//  CCViewController.m
//  Umai Meny
//
//  Created by Caleb on 05/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCSushiTableViewController.h"
#import "CCSushiTableViewCell.h"
#import "CCCoreDataHelper.h"
#import "CCMenu.h"
#import "CCSushi.h"
#import "Sushi.h"


@interface CCSushiTableViewController ()

@end

@implementation CCSushiTableViewController

#pragma mark - lazy instantiation
- (NSMutableArray *) sushiMenus{
    if (!_sushiMenus) {
        _sushiMenus = [[NSMutableArray alloc] init];
    }
    return _sushiMenus;
}

-(NSMutableArray *)selectedIndexPath
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


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // FetchRequest Sushi entity from Core Data
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Sushi"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"ordinariePrice" ascending:YES]];
    
    NSError *error = nil;
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"type CONTAINS %@", self.sushiType];
    [fetchRequest setPredicate:pred];
    
    NSArray *fetchSushi = [[CCCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    self.sushiMenus = [fetchSushi mutableCopy];
    
    if ( ! [self.sushiMenus count] > 0) {
        // Iterate all the data in CCSushi if no data in Sushi entity
        for (NSMutableDictionary *sushiData in [CCSushi sushi]) {
            CCMenu *menu = [[CCMenu alloc] initWithSushiData:sushiData];
            NSArray *wordArray = [menu.sushiType componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSString *lastWord = [wordArray lastObject];
    
            if (self.sushiType == menu.sushiType) { // addObject if it is sushi
                [self.sushiMenus addObject:[self sushiWithName:menu]];
            }
            else if ([self.sushiType isEqual:lastWord]) { // adddObject if it is fat
                [self.sushiMenus addObject:[self sushiWithName:menu]];
            }
        }
    }

    // FetchRequest OrderBasket entity from Core Data
    NSFetchRequest *fetchRequestBasket = [NSFetchRequest fetchRequestWithEntityName:@"OrderBasket"];
    NSError *errorBasket = nil;
    
    NSArray *fetchBasket = [[CCCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequestBasket error:&errorBasket];
    self.orderBaskets = [fetchBasket mutableCopy];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.title = self.sushiType;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sushiMenus count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    CCSushiTableViewCell *cell = (CCSushiTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Sushi *selectedSushi = [self.sushiMenus objectAtIndex:indexPath.row];
    [cell.quantityStepper setHidden:YES];
    [cell.quantityLabel setHidden:YES];
    [cell.ingredientTextView setHidden:YES];
    [cell.lunchLabel setHidden:YES];
    [cell.lunchPriceLabel setHidden:YES];
    [cell.ordinarieLabel setHidden:YES];
    [cell.ordinariePriceLabel setHidden:YES];
    
    cell.sushiLabel.text = [NSString stringWithFormat:@"%@", selectedSushi.name];

    cell.ingredientTextView.text = selectedSushi.ingredient;
    cell.ingredientTextView.userInteractionEnabled = NO;

    if ([self.selectedIndexPath containsObject:indexPath]) {
        [cell.quantityStepper setHidden:NO];
        [cell.ingredientTextView setHidden:NO];
        [cell.lunchLabel setHidden:NO];
        [cell.lunchPriceLabel setHidden:NO];
        [cell.ordinarieLabel setHidden:NO];
        [cell.ordinariePriceLabel setHidden:NO];
        
        // no lunch price for Fat
        if ([self.sushiType isEqual: @"Fat"] || [self.sushiType isEqual:@"Omakase Sushi"] ) {
            [cell.lunchLabel setHidden:YES];
            [cell.lunchPriceLabel setHidden:YES];
        }
        else {
            cell.lunchPriceLabel.text = [NSString stringWithFormat:@"%@ kr", selectedSushi.lunchPrice];
        }
        
        cell.ordinariePriceLabel.text = [NSString stringWithFormat:@"%@ kr", selectedSushi.ordinariePrice];
      
        cell.quantityStepper.value = [selectedSushi.orderQuantity doubleValue];
        cell.quantityStepper.tag = indexPath.row;
        [cell.quantityStepper addTarget:self action:@selector(incrementStepper:) forControlEvents:UIControlEventValueChanged];
    }
    cell.quantityLabel.text = [NSString stringWithFormat:@"%@",selectedSushi.orderQuantity];
    int orderQuantity = [selectedSushi.orderQuantity intValue];
    
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
/* Helper method which persists a SUSHI object using Core Data to file system */
-(Sushi *)sushiWithName:(CCMenu *)menu
{
    NSManagedObjectContext *context = [CCCoreDataHelper managedObjectContext];

    Sushi *sushi = [NSEntityDescription insertNewObjectForEntityForName:@"Sushi" inManagedObjectContext:context];
    sushi.name = [NSString stringWithFormat:@"%@ %i",menu.sushiType, menu.sushiSize];
    sushi.type = menu.sushiType;
    sushi.ingredient = menu.sushiIngredient;
    sushi.lunchPrice = [NSNumber numberWithInt:menu.sushiLunchPrice];
    sushi.ordinariePrice = [NSNumber numberWithInt:menu.sushiOrdinariePrice];
    sushi.orderQuantity = [NSNumber numberWithInt:menu.sushiOrderQuantity];
    
    // NSManagedObjectContext is autosave in the background
    NSError *error = nil;
    if (![context save:&error]) { // &error is pointer of the pointer to error object
        NSLog(@"%@", error);    // we have an error
    }
    
    return sushi;
}


/* Helper method which persists a OrderBasket object using Core Data to file system */
-(OrderBasket *)orderBasketInsertObject
{
    NSManagedObjectContext *context = [CCCoreDataHelper managedObjectContext];
    OrderBasket *basket = [NSEntityDescription insertNewObjectForEntityForName:@"OrderBasket" inManagedObjectContext:context];
    
    NSError *error = nil;
    // NSManagedObjectContext is autosave in the background
    if (![context save:&error]) { // &error is pointer of the pointer to error object
        NSLog(@"%@", error);      // we have an error!
    }
    
    return basket;
}


-(void) updateOrderBasketObject: (Sushi *)selectedSushi
{
    if ([self.orderBaskets count] == 0) {
        [self.orderBaskets addObject:[self orderBasketInsertObject]];
        self.basket = [self.orderBaskets lastObject];
        selectedSushi.orderBasket = self.basket; // build relationship with OrderBasket entity
    }
    else {
        self.basket = [self.orderBaskets lastObject];
        selectedSushi.orderBasket = self.basket; // build relationship with OrderBasket entity
    }
    
    int orderQuantity = [selectedSushi.orderQuantity intValue];
    if (orderQuantity == 0) {
        selectedSushi.orderBasket = nil; // remove relationship with OrderBasket entity
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
    Sushi *sushi = [self.sushiMenus objectAtIndex:stepper.tag];
    sushi.orderQuantity = [NSNumber numberWithDouble:stepper.value];
    
    [self refreshCoreData];
    [self updateOrderBasketObject:sushi];

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
    for (Sushi *sushi in self.sushiMenus) {
        sushi.orderQuantity = [NSNumber numberWithInt:0];
        [self updateOrderBasketObject:sushi];
    }
    [self refreshCoreData];
    
    [self.tableView reloadData];
}
@end
