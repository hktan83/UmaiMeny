//
//  CCSashimiTableViewController.m
//  Umai Meny
//
//  Created by Caleb on 07/07/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCSashimiTableViewController.h"
#import "CCSashimiTableViewCell.h"
#import "CCCoreDataHelper.h"
#import "CCMenu.h"
#import "CCSashimi.h"
#import "CCMakiMenu.h"
#import "Sashimi.h"
#import "MakiMenu.h"

@interface CCSashimiTableViewController ()
- (IBAction)tommaBarButtonPressed:(UIBarButtonItem *)sender;

@end

@implementation CCSashimiTableViewController

#pragma mark - lazy instantiation 
// Only applies to Maki Menu
-(NSMutableArray *) menus
{
    if (!_menus) {
        _menus = [[NSMutableArray alloc] init];
    }
    return _menus;
}

-(NSMutableArray *) sashimiMenus
{
    if (!_sashimiMenus) {
        _sashimiMenus = [[NSMutableArray alloc] init];
    }
    return _sashimiMenus;
}

-(NSMutableArray *) makiMenus
{
    if (!_makiMenus) {
        _makiMenus = [[NSMutableArray alloc] init];
    }
    return _makiMenus;
}


-(NSMutableArray *) selectedIndexPath
{
    if (!_selectedIndexPath) {
        _selectedIndexPath = [[NSMutableArray alloc] init];
    }
    return _selectedIndexPath;
}

- (NSMutableArray *)orderBaskets
{
    if (!_orderBaskets) {
        _orderBaskets = [[NSMutableArray alloc] init];
    }
    return _orderBaskets;
}

#pragma mark - View Controller

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
    
    if ([self.menuType isEqual: @"sashimi"]) {
        // FetchRequest Sashimi entity from Core Data
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Sashimi"];
        fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"ordinariePrice" ascending:YES]];
        
        NSError *error = nil;
        NSArray *fetchSashimi = [[CCCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
        
        self.sashimiMenus = [fetchSashimi mutableCopy];
        
        // This FOR loop reserves for Images loading, it is faster than loading image from core data
        for (NSMutableDictionary *data in [CCSashimi sashimi]) {
            NSString *imageName = data[SASHIMI_IMAGE];
            CCMenu *menu = [[CCMenu alloc] initWithSashimiData:data andImage:[UIImage imageNamed:imageName]];
            [self.menus addObject:menu];
        }
        
        if (![self.sashimiMenus count] > 0) {
            // Iterate all the data in CCSashimi if no data in Sashimi entity
            for (NSMutableDictionary *data in [CCSashimi sashimi]) {
                NSString *imageName = data[SASHIMI_IMAGE];
                CCMenu *menu = [[CCMenu alloc] initWithSashimiData:data andImage:[UIImage imageNamed:imageName]];
                [self.sashimiMenus addObject:[self sashimiWithName:menu]];
            }
        }
    }
    
    else if ([self.menuType isEqual:@"Maki Meny"]){
        // FetchRequest MakiManu entity from Core Data
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MakiMenu"];
//        fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"ordinariePrice" ascending:YES]]; no sortDescriptor due to it mess up with images
        
        NSError *error = nil;
        NSArray *fetchMaki = [[CCCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
        
        self.makiMenus = [fetchMaki mutableCopy];
        
        // This FOR loop reserves for Images loading, it is faster than loading image from core data
        for (NSMutableDictionary *data in [CCMakiMenu maki]) {
            NSString *imageName = data[MAKI_IMAGE];
            CCMenu *menu = [[CCMenu alloc] initWithMakiMenuData:data andImage:[UIImage imageNamed:imageName]];
            [self.menus addObject:menu];
        }
        
        if (![self.makiMenus count] > 0) {
            // Iterate all the data in CCMakiMenu if no data in MakiMenu entity
            for (NSMutableDictionary *data in [CCMakiMenu maki]) {
                NSString *imageName = data[MAKI_IMAGE];
                CCMenu *menu = [[CCMenu alloc] initWithMakiMenuData:data andImage:[UIImage imageNamed:imageName]];
                [self.makiMenus addObject:[self makiMenuWithName:menu]];
            }
        }
 
    }
    
    // FetchRequest OrderBasket entity from Core Data
    NSFetchRequest *fetchRequestBasket = [NSFetchRequest fetchRequestWithEntityName:@"OrderBasket"];
    NSError *errorBasket = nil;
    
    NSArray *fetchBasket = [[CCCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequestBasket error:&errorBasket];
    self.orderBaskets = [fetchBasket mutableCopy];
    
    self.title = self.menuType;
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
    if ([self.menuType isEqual: @"sashimi"]) {
        return [self.sashimiMenus count];
    }
    else {
        return [self.makiMenus count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCSashimiTableViewCell *cell = (CCSashimiTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CCMenu *menu = [self.menus objectAtIndex:indexPath.row];

    
    [cell.quantityStepper setHidden:YES];
    [cell.ordinarieLabel setHidden:YES];
    [cell.priceLabel setHidden:YES];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Sashimi section
    if ([self.menuType isEqual: @"sashimi"]) {
        Sashimi *selectedSashimi = [self.sashimiMenus objectAtIndex:indexPath.row];
        cell.dishNameLabel.text = selectedSashimi.name;
        cell.ingredientTextView.text = selectedSashimi.ingredient;
        cell.imageView.image = menu.sashimiImage;
        cell.priceLabel.text = [NSString stringWithFormat:@"%@ kr", selectedSashimi.ordinariePrice];
        
        // This IF loop runs when cell is expanding
        if ([self.selectedIndexPath containsObject:indexPath]) {
            [cell.quantityStepper setHidden:NO];
            [cell.ordinarieLabel setHidden:NO];
            [cell.priceLabel setHidden:NO];
            
            cell.quantityStepper.value = [selectedSashimi.orderQuantity doubleValue];
            cell.quantityStepper.tag = indexPath.row;
            [cell.quantityStepper addTarget:self action:@selector(incrementStepper:) forControlEvents:UIControlEventValueChanged];
        }
        
        cell.quantityLabel.text = [NSString stringWithFormat:@"%@", selectedSashimi.orderQuantity];
        int orderQuantity = [selectedSashimi.orderQuantity intValue];
        
        if (orderQuantity == 0) {
            [cell.quantityLabel setHidden:YES];
        }
        else [cell.quantityLabel setHidden:NO];
    }
    
    // Maki Meny section
    if ([self.menuType isEqual:@"Maki Meny"]) {
        MakiMenu *selectedMaki = [self.makiMenus objectAtIndex:indexPath.row];
        cell.dishNameLabel.text = selectedMaki.name;
        cell.ingredientTextView.text = selectedMaki.ingredient;
        cell.imageView.image = menu.makiMenuImage;
        cell.priceLabel.text = [NSString stringWithFormat:@"%@ kr", selectedMaki.ordinariePrice];
        
        // This IF loop runs when cell is expanding
        if ([self.selectedIndexPath containsObject:indexPath]) {
            [cell.quantityStepper setHidden:NO];
            [cell.ordinarieLabel setHidden:NO];
            [cell.priceLabel setHidden:NO];
            
            cell.quantityStepper.value = [selectedMaki.orderQuantity doubleValue];
            cell.quantityStepper.tag = indexPath.row;
            [cell.quantityStepper addTarget:self action:@selector(incrementStepper:) forControlEvents:UIControlEventValueChanged];
        }
        
        cell.quantityLabel.text = [NSString stringWithFormat:@"%@", selectedMaki.orderQuantity];
        int orderQuantity = [selectedMaki.orderQuantity intValue];

        if (orderQuantity == 0) {
            [cell.quantityLabel setHidden:YES];
        }
        else [cell.quantityLabel setHidden:NO];

    }

    return cell;
}


#pragma mark - Table View delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Future development, cell expands according to the total height of several components
    if ([self.selectedIndexPath containsObject:indexPath]) {
        return 130;
    }
    
    else {
        return 85;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self addOrRemoveSelectedIndexPath:indexPath];
}


#pragma mark - Helper methods
/* Helper method which persists a Sashimi object using Core Data to file system */
-(Sashimi *)sashimiWithName:(CCMenu *)menu
{
    NSManagedObjectContext *context = [CCCoreDataHelper managedObjectContext];
    
    Sashimi *sashimi = [NSEntityDescription insertNewObjectForEntityForName:@"Sashimi" inManagedObjectContext:context];
    sashimi.name = [NSString stringWithFormat:@"%@", menu.sashimi];
    sashimi.ingredient = menu.sashimiIngredient;
    sashimi.ordinariePrice = [NSNumber numberWithInt:menu.sashimiPrice];
    sashimi.orderQuantity = [NSNumber numberWithInt:menu.sashimiOrderQuantity];
    sashimi.image = nil ; // This applies when image data is being compressed
    
    // This applies when image data is being compressed
//    UIImage *image = menu.sashimiImage;
//    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
//    sashimi.image = imageData;
    
    // NSManagedObjectContext is autosave in the background
    NSError *error = nil;
    if (![context save:&error]) { // &error is pointer of the pointer to error object
        NSLog(@"%@", error); // we have an error
    }
    
    return sashimi;
}

-(MakiMenu *)makiMenuWithName:(CCMenu *)menu
{
    NSManagedObjectContext *context = [CCCoreDataHelper managedObjectContext];

    MakiMenu *maki = [NSEntityDescription insertNewObjectForEntityForName:@"MakiMenu" inManagedObjectContext:context];
    maki.name = [NSString stringWithFormat:@"%@", menu.makiMenu];
    maki.ingredient = menu.makiIngredient;
    maki.ordinariePrice = [NSNumber numberWithInt:menu.makiPrice];
    maki.orderQuantity = [NSNumber numberWithInt:menu.makiOrderQuantity];
    maki.image = nil; // This applies when image data is being compressed
    
    // NSManagedObjectContext is autosave in the background
    NSError *error = nil;
    if (![context save:&error]) {   // &error is pointer of the pointer to error object
        NSLog(@"%@", error) ;       // we have an error
    }
    
    return maki;
    
}


/* Helper method which persists a OrderBasket object using Core Data to file system */
-(OrderBasket *)orderBasketInsertObject
{
    NSManagedObjectContext *context = [CCCoreDataHelper managedObjectContext];
    OrderBasket *basket = [NSEntityDescription insertNewObjectForEntityForName:@"OrderBasket" inManagedObjectContext:context];
    
    NSError *error = nil;
    // NSManagedObjectContext is autosave in the background
    if (![context save:&error]) {   // &error is pointer of the pointer to error object
        NSLog(@"%@", error);        // we have an error!
    }
    
    return basket;
}


-(void) updateOrderBasketWithSashimi: (Sashimi *)selectedSashimi
{
    if ([self.orderBaskets count] == 0) {
        [self.orderBaskets addObject:[self orderBasketInsertObject]];
        self.basket = [self.orderBaskets lastObject]; // only one object exists
        selectedSashimi.orderBasket = self.basket; // build relationship with OrderBasket entity
    }
    else {
        self.basket = [self.orderBaskets lastObject];
        selectedSashimi.orderBasket = self.basket; // build relationship with OrderBasket entity
    }
    
    int orderQuantity = [selectedSashimi.orderQuantity intValue];
    if (orderQuantity == 0) {
        selectedSashimi.orderBasket = nil;
    }
    
    [self refreshCoreData];
}


-(void) updateOrderBasketWithMaki: (MakiMenu *)selectedMaki
{
    if ([self.orderBaskets count] == 0) {
        [self.orderBaskets addObject:[self orderBasketInsertObject]];
        self.basket = [self.orderBaskets lastObject]; // only one object exists
        selectedMaki.orderBasket = self.basket; // build relationship with OrderBasket entity
    }
    else {
        self.basket = [self.orderBaskets lastObject];
        selectedMaki.orderBasket = self.basket; // build relationship with OrderBasket entity
    }
    
    int orderQuantity = [selectedMaki.orderQuantity intValue];
    if (orderQuantity == 0) {
        selectedMaki.orderBasket = nil;
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
    if ([self.menuType isEqual: @"sashimi"]) {
        Sashimi *sashimi = [self.sashimiMenus objectAtIndex:stepper.tag];
        sashimi.orderQuantity = [NSNumber numberWithDouble:stepper.value];
        [self updateOrderBasketWithSashimi:sashimi];
    }
    else if ([self.menuType isEqual:@"Maki Meny"]){
        MakiMenu *maki = [self.makiMenus objectAtIndex:stepper.tag];
        maki.orderQuantity = [NSNumber numberWithDouble:stepper.value];
        [self updateOrderBasketWithMaki:maki];
    }
    
    [self refreshCoreData];
    
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



- (IBAction)tommaBarButtonPressed:(UIBarButtonItem *)sender
{
    // reset all orderQuantity to be 0
    if ([self.menuType isEqual: @"sashimi"]) {
        for (Sashimi *sashimi in self.sashimiMenus) {
            sashimi.orderQuantity = [NSNumber numberWithInt:0];
            [self updateOrderBasketWithSashimi:sashimi];
        }
    }

    else if ([self.menuType isEqual:@"Maki Meny"]){
        for (MakiMenu *maki in self.makiMenus) {
            maki.orderQuantity = [NSNumber numberWithInt:0];
            [self updateOrderBasketWithMaki:maki];
        }
    }
    
    [self refreshCoreData];
    [self.tableView reloadData];
}
@end
