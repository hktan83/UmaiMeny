//
//  CCForratterTableViewController.m
//  Umai Meny
//
//  Created by Caleb on 06/07/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCForratterTableViewController.h"
#import "CCCoreDataHelper.h"
#import "Forratter.h"
#import "ForratterDetails.h"

@interface CCForratterTableViewController ()
@property (strong, nonatomic) NSMutableArray *images; // for without core data for image loading

@end

@implementation CCForratterTableViewController

#pragma mark - lazy instantiation
-(NSMutableArray *)images
{
    if (!_images) {
        _images = [[NSMutableArray alloc] init];
    }
    return _images;
}

-(NSMutableArray *)forratterMenus
{
    if (!_forratterMenus) {
        _forratterMenus = [[NSMutableArray alloc] init];
    }
    return _forratterMenus;
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

    // FetchRequest Forratter entity from Core Data
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Forratter"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO],nil];

    NSError *error = nil;
    
    NSArray *fetchForratter = [[CCCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    self.forratterMenus = [fetchForratter mutableCopy];
    
    // This FOR loop reserves for images loading, it is faster than loading image from core data
    for (NSMutableDictionary *data in [CCForratter forratter]) {
        NSString *imageName = data[FORRATTER_IMAGE];
        CCMenu *menu = [[CCMenu alloc] initWithForratterData:data andImage:[UIImage imageNamed:imageName]];
        [self.images addObject:menu];
    }
    
    
    if (![self.forratterMenus count] > 0) {
        // Iterate all the data in CCForratter if no data in Forratter entity
        for (NSMutableDictionary *data in [CCForratter forratter]) {
            NSString *imageName = data[FORRATTER_IMAGE];
            CCMenu *menu = [[CCMenu alloc] initWithForratterData:data andImage:[UIImage imageNamed:imageName]];
            [self.images addObject:menu];
            [self.forratterMenus addObject:[self forratterWithName:menu]];
        }
    }
    
    // FetchRequest OrderBasket entity from Core Data
    NSFetchRequest *fetchRequestBasket = [NSFetchRequest fetchRequestWithEntityName:@"OrderBasket"];
    NSError *errorBasket = nil;
    
    NSArray *fetchBasket = [[CCCoreDataHelper managedObjectContext]executeFetchRequest:fetchRequestBasket error:&errorBasket];
    self.orderBaskets = [fetchBasket mutableCopy];
    NSLog(@"self.orderBaskets :%@", self.orderBaskets);
    
    self.title = @"Förrätter";
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
    return [self.forratterMenus count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCForratterTableViewCell *cell = (CCForratterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CCMenu *menu = [self.images objectAtIndex:indexPath.row];
    cell.image.image = menu.forratterImage;

    Forratter *selectedForratter = [self.forratterMenus objectAtIndex:indexPath.row];
    cell.dishNameLabel.text = selectedForratter.name;
    
    NSArray *orderedForratter = [self orderForratter:selectedForratter];

    // Show the necessary priceButtons and quantityLabels
    for (int i = 0; i < orderedForratter.count; i++) {
        [cell.priceButtons[i] setHidden:NO];
        [cell.quantityLabels[i] setHidden:NO];
        
        ForratterDetails *forratterDetail = [orderedForratter objectAtIndex:i];

        UIButton *priceButton = cell.priceButtons[i];
        NSString *attachedStringToPriceButton = [self attachedString:forratterDetail];
        
        // setting title on each priceButton
        [priceButton setTitle:[NSString stringWithFormat:@"%@ %@kr", attachedStringToPriceButton,forratterDetail.price] forState:UIControlStateNormal];
        
        UILabel *quantityLabel = cell.quantityLabels[i];
        quantityLabel.text = [NSString stringWithFormat:@"%@", forratterDetail.orderQuantity];

        // convert NSNumber to int, otherwise cannot do comparison in "if else"
        
        int quantityInt = [forratterDetail.orderQuantity intValue];
        if (quantityInt == 0) [cell.quantityLabels[i] setHidden:YES];
        else [cell.quantityLabels[i] setHidden:NO];
        
    }
    
    // Hide the unnecessary priceButtons and quantityLabels
    for (int i = 3; i >= orderedForratter.count; i--) {
        [cell.priceButtons[i] setHidden:YES];
        [cell.quantityLabels[i] setHidden:YES];
    }
    
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - CCForratterTableViewCellDelegate
- (void)updateQuantityLabel:(UIButton *)sender atWhichColumn:(int)column
{
    // stackoverflow.com search @"Access iOS7 hidden UITableViewCellScrollView
    UITableViewCell *cell = (UITableViewCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    Forratter *selectedForratter = [self.forratterMenus objectAtIndex:indexPath.row];
 
    NSArray *orderedForratter = [self orderForratter:selectedForratter];
    ForratterDetails *forratterDetail = [orderedForratter objectAtIndex:column];
    forratterDetail.orderQuantity = [NSNumber numberWithInt:[forratterDetail.orderQuantity intValue] + 1];
    
    [self refreshCoreData];
    [self updateOrderBasketObject:selectedForratter];
    
    [self.tableView reloadData];
}

-(void)setZeroQuantitylabel:(UIButton *)button
{
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    Forratter *selectedForratter = [self.forratterMenus objectAtIndex:indexPath.row];
    
    NSArray *orderedForratter = [self orderForratter:selectedForratter];
    
    for (int column = 0; column < orderedForratter.count ; column++) {
        ForratterDetails *forratterDetail = [orderedForratter objectAtIndex:column];
        forratterDetail.orderQuantity = [NSNumber numberWithInt:0];
    }
    
    selectedForratter.orderBasket = nil;
    
    [self refreshCoreData];
//    [self updateOrderBasketObject:selectedForratter];

    [self.tableView reloadData];
}


#pragma mark - Helper methods
/* Helper method which persists a Forratter object using Core Data to file system */
-(Forratter *)forratterWithName: (CCMenu *)menu
{
    NSManagedObjectContext *context = [CCCoreDataHelper managedObjectContext];
    
    Forratter *forratter = [NSEntityDescription insertNewObjectForEntityForName:@"Forratter" inManagedObjectContext:context];
    forratter.name = [NSString stringWithFormat:@"%@", menu.forratter];
    [self forratterDetailsWithName:menu forratterObject:forratter]; // relate ForratterDetails object which is same name
    
    // NSManagedObjectContext is autosave in the background
    NSError *error = nil;
    if (![context save:&error]) {   // &error is pointer of the pointer to error object
        NSLog(@"%@", error);        // we have an error
    }
    
    return forratter;
}


/* Helper method which persists a ForratterDetails object using Core Data to file system */
-(void)forratterDetailsWithName: (CCMenu *)menu forratterObject: (Forratter *)forratter
{
    NSManagedObjectContext *context = [CCCoreDataHelper managedObjectContext];
    
    for (int i = 0; i < menu.forratterSize.count; i++) {
        ForratterDetails *forratterDetails = [NSEntityDescription insertNewObjectForEntityForName:@"ForratterDetails" inManagedObjectContext:context];
        forratterDetails.name = menu.forratter;
        forratterDetails.price = menu.forratterPrice[i];
        forratterDetails.size = menu.forratterSize[i];
        forratterDetails.orderQuantity = menu.forratterOrderQuantity[i];
        // relate ForratterDetails object to Forratter objects
        if ([forratterDetails.name isEqualToString:forratter.name]) {
            forratterDetails.forratters = forratter;
        }
    }
    
    // NSManagedObjectContext is autosave in the background
    NSError *error = nil;
    if (![context save:&error]) {   // &error is pointer of the pointer to error object
        NSLog(@"%@", error);        // we have an error
    }
}


// Return ordered NSArray from NSSet Forratter
-(NSArray *)orderForratter: (Forratter *)forratter
{
    NSSet *scatteredForratter = forratter.forratterBundle;
    NSArray *unorderedForratter = [scatteredForratter allObjects];
    NSArray *orderedForratter = [unorderedForratter sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"size" ascending:YES]]];
    
    return orderedForratter;
}

/* Helper method which persists a OrderBasket object using Core Data to file system */
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

-(void)updateOrderBasketObject: (Forratter *)selectedForratter
{
    if ([self.orderBaskets count] == 0) {
        [self.orderBaskets addObject:[self orderBasketInsertObject]];
        self.basket = [self.orderBaskets lastObject];
        selectedForratter.orderBasket = self.basket;    //build relationship with OrderBasket entity
    }
    
    else {
        self.basket = [self.orderBaskets lastObject];
        selectedForratter.orderBasket = self.basket;    // build relationship with OrderBasket entity
    }

}


// Saving data
-(void)refreshCoreData
{
    NSManagedObjectContext *context = [CCCoreDataHelper managedObjectContext];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"%@",error);
    }
}


// Attach string to price button
- (NSString *) attachedString: (ForratterDetails *)forratterDetail
{
    NSString *attachedString = [[NSString alloc] init];
    if ([forratterDetail.name isEqualToString:@"Extra ris"])
        attachedString = [NSString stringWithFormat:@""];
    else if ([forratterDetail.name isEqualToString:@"Tempura jätteräkor"])
        attachedString = [NSString stringWithFormat:@"%@par", forratterDetail.size];
    else if ([forratterDetail.name isEqualToString:@"Vegetarisk mini-vårrulle"])
        attachedString = [NSString stringWithFormat:@"%@st", forratterDetail.size];
    else if ([forratterDetail.name isEqualToString:@"Risnätvårrulle"])
        attachedString = [NSString stringWithFormat:@"%@st", forratterDetail.size];
    else if ([forratterDetail.name isEqualToString:@"Edamame bönor (40g)"])
        attachedString = [NSString stringWithFormat:@""];
    else if ([forratterDetail.name isEqualToString:@"Gyoza dumpling"])
        attachedString = [NSString stringWithFormat:@"%@st", forratterDetail.size];
    else if ([forratterDetail.name isEqualToString:@"Kycklingvingar"])
        attachedString = [NSString stringWithFormat:@"%@st", forratterDetail.size];
    
    return attachedString;
}



@end
