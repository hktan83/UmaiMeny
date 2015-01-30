//
//  CCBasketViewController.m
//  Umai Meny
//
//  Created by Caleb on 07/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCBasketViewController.h"
#import "CCBasketTableViewCell.h"
#import "SWRevealViewController.h"
#import "CCCoreDataHelper.h"
#import "Sushi.h"
#import "Varmratt.h"
#import "Sashimi.h"
#import "MakiMenu.h"
#import "Tillagg.h"
#import "Forratter.h"
#import "ForratterDetails.h"

@interface CCBasketViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSMutableArray *sushiBaskets;
@property (strong, nonatomic) NSMutableArray *varmrattBaskets;
@property (strong, nonatomic) NSMutableArray *sashimiBaskets;
@property (strong, nonatomic) NSMutableArray *makiBaskets;
@property (strong, nonatomic) NSMutableArray *tillaggBaskets;
@property (strong, nonatomic) NSMutableArray *forratterBaskets;
@property (nonatomic) int totalPrice;

- (IBAction)tommaBarButtonPressed:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UILabel *totalPriceLabel;

@property (strong, nonatomic) IBOutlet UIView *beloppView;



@end

@implementation CCBasketViewController

#pragma mark - Lazy Instantiation
-(NSMutableArray *)orders
{
    if (!_orders) {
        _orders = [[NSMutableArray alloc]init];
    }
    return _orders;
}

-(NSMutableArray *)sushiBaskets
{
    if (!_sushiBaskets) {
        _sushiBaskets = [[NSMutableArray alloc] init];
    }
    return _sushiBaskets;
}

-(NSMutableArray *)varmrattBaskets
{
    if (!_varmrattBaskets) {
        _varmrattBaskets = [[NSMutableArray alloc] init];
    }
    return _varmrattBaskets;
}

-(NSMutableArray *)sashimiBaskets
{
    if (!_sashimiBaskets) {
        _sashimiBaskets = [[NSMutableArray alloc] init];
    }
    return _sashimiBaskets;
}

-(NSMutableArray *)makiBaskets
{
    if (!_makiBaskets) {
        _makiBaskets = [[NSMutableArray alloc] init];
    }
    return _makiBaskets;
}

-(NSMutableArray *)tillaggBaskets
{
    if (!_tillaggBaskets) {
        _tillaggBaskets = [[NSMutableArray alloc] init];
    }
    return _tillaggBaskets;
}

-(NSMutableArray *)forratterBaskets
{
    if (!_forratterBaskets) {
        _forratterBaskets = [[NSMutableArray alloc] init];
    }
    return _forratterBaskets;
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
    // Do any additional setup after loading the view.
    //Change button color
    self.sidebarButton.tintColor = [UIColor redColor];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar
    self.sidebarButton.target = self.revealViewController;
    self.sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer]; // Disable it to remove gesture recognizer interfering
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.basket = [self fetchRequestOrderBasket];

    // convert NSSet to NSArray then to NSMutableArray
    self.sushiBaskets = [[self.basket.sushiOrders allObjects] copy];
    self.varmrattBaskets = [[self.basket.varmrattOrders allObjects] copy];
    self.sashimiBaskets = [[self.basket.sashimiOrders allObjects] copy];
    self.makiBaskets = [[self.basket.makiOrders allObjects] copy];
    self.tillaggBaskets = [[self.basket.tillaggOrders allObjects] copy];
    
    // Obtain ForratterDetails entity via Forratter entity
    for (Forratter *forratter in [self.basket.forratterOrders allObjects]) {
        NSArray *orderedForratter = [self orderForratter:forratter];
        
        for (int column = 0; column < orderedForratter.count ; column++) {
            ForratterDetails *forratterDetail = [orderedForratter objectAtIndex:column];
            int orderQuantity = [forratterDetail.orderQuantity intValue];
            if (orderQuantity > 0) {
                [self.forratterBaskets addObject:forratterDetail];
            }
        }
    }
    
    
    // Combine all orders into self.orders
    [self.orders addObjectsFromArray:self.sushiBaskets];
    [self.orders addObjectsFromArray:self.varmrattBaskets];
    [self.orders addObjectsFromArray:self.sashimiBaskets];
    [self.orders addObjectsFromArray:self.makiBaskets];
    [self.orders addObjectsFromArray:self.tillaggBaskets];
    [self.orders addObjectsFromArray:self.forratterBaskets];
    
    [self accumulateTotalPrice];
    
    
    // iPhone 4S adaption
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 480) {
        self.beloppView.frame = CGRectMake(0, screenBounds.size.height - 48, screenBounds.size.width, 48);
    }
    
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
    return [self.orders count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    CCBasketTableViewCell *cell = (CCBasketTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString *name = [[NSString alloc] init];
    NSNumber *orderQuantity = [[NSNumber alloc]init];
    NSNumber *price = [[NSNumber alloc] init];
    BOOL isLunchPrice;
    isLunchPrice = [self isLunchPrice];

    NSManagedObject *dish = [self.orders objectAtIndex:indexPath.row];
    
    if ([dish.entity.name isEqualToString:@"Sushi"]) {
        Sushi *sushi = [self.orders objectAtIndex:indexPath.row];
        name = sushi.name;
        orderQuantity = sushi.orderQuantity;
        if (isLunchPrice == YES) {
            price = [NSNumber numberWithInt:([sushi.lunchPrice intValue]*[sushi.orderQuantity intValue])];
        }
        else {
            price = [NSNumber numberWithInt:([sushi.ordinariePrice intValue]*[sushi.orderQuantity intValue])];
        }
    }
    else if ([dish.entity.name isEqualToString:@"Varmratt"]){
        Varmratt *varmratt = [self.orders objectAtIndex:indexPath.row];
        name = varmratt.name;
        orderQuantity = varmratt.orderQuantity;
        if (isLunchPrice == YES) {
            price = [NSNumber numberWithInt:([varmratt.lunchPrice intValue]*[varmratt.orderQuantity intValue])];
        }
        else {
            price = [NSNumber numberWithInt:([varmratt.ordinariePrice intValue]*[varmratt.orderQuantity intValue])];
        }
    }
    else if ([dish.entity.name isEqualToString:@"Sashimi"]){
        Sashimi *sashimi = [self.orders objectAtIndex:indexPath.row];
        name = sashimi.name;
        orderQuantity = sashimi.orderQuantity;
        price = [NSNumber numberWithInt:([sashimi.ordinariePrice intValue]*[sashimi.orderQuantity intValue])];
    }
    else if ([dish.entity.name isEqualToString:@"MakiMenu"]){
        MakiMenu *maki = [self.orders objectAtIndex:indexPath.row];
        name = maki.name;
        orderQuantity = maki.orderQuantity;
        price = [NSNumber numberWithInt:([maki.ordinariePrice intValue]*[maki.orderQuantity intValue])];
    }
    else if ([dish.entity.name isEqualToString:@"Tillagg"]){
        Tillagg *tillagg = [self.orders objectAtIndex:indexPath.row];
        name = tillagg.name;
        orderQuantity = tillagg.orderQuantity;
        price = [NSNumber numberWithInt:([tillagg.price intValue]*[tillagg.orderQuantity intValue])];
    }
    else if ([dish.entity.name isEqualToString:@"ForratterDetails"]){
        ForratterDetails *forratterDetail = [self.orders objectAtIndex:indexPath.row];
        NSString *attachedQuantityToLabel = [self attachedString:forratterDetail];
        name = [NSString stringWithFormat:@"%@ %@", forratterDetail.name, attachedQuantityToLabel];
        orderQuantity = forratterDetail.orderQuantity;
        price = [NSNumber numberWithInt:([forratterDetail.price intValue]*[forratterDetail.orderQuantity intValue])];
    }
    
    cell.dishLabel.text = name;
    cell.quantityLabel.text = [NSString stringWithFormat:@"%@", orderQuantity];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@ :-", price];

    return cell;
}



#pragma mark - Table View Delegate

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // delete row from data source
        NSManagedObject *dish = [self.orders objectAtIndex:indexPath.row];
        if ([dish.entity.name isEqualToString:@"Sushi"]) {
            Sushi *sushi = [self.orders objectAtIndex:indexPath.row];
            if (sushi.objectID == dish.objectID) {
                sushi.orderQuantity = [NSNumber numberWithInt:0];
                sushi.orderBasket = nil;
            }
        }
        if ([dish.entity.name isEqualToString:@"Varmratt"]) {
            Varmratt *varmratt = [self.orders objectAtIndex:indexPath.row];
            if (varmratt.objectID == dish.objectID) {
                varmratt.orderQuantity = [NSNumber numberWithInt:0];
                varmratt.orderBasket = nil;
            }
        }
        
        if ([dish.entity.name isEqualToString:@"Sashimi"]) {
            Sashimi *sashimi = [self.orders objectAtIndex:indexPath.row];
            if (sashimi.objectID == dish.objectID) {
                sashimi.orderQuantity = [NSNumber numberWithInt:0];
                sashimi.orderBasket = nil;
            }
        }
        
        if ([dish.entity.name isEqualToString:@"MakiMenu"]) {
            MakiMenu *maki = [self.orders objectAtIndex:indexPath.row];
            if (maki.objectID == dish.objectID) {
                maki.orderQuantity = [NSNumber numberWithInt:0];
                maki.orderBasket = nil;
            }
        }
        
        if ([dish.entity.name isEqualToString:@"Tillagg"]) {
            Tillagg *tillagg = [self.orders objectAtIndex:indexPath.row];
            if (tillagg.objectID == dish.objectID) {
                tillagg.orderQuantity = [NSNumber numberWithInt:0];
                tillagg.orderBasket = nil;
            }
        }
        
        if ([dish.entity.name isEqualToString:@"ForratterDetails"]) {
            ForratterDetails *forratterDetail = [self.orders objectAtIndex:indexPath.row];
            if (forratterDetail.objectID == dish.objectID) {
                forratterDetail.orderQuantity = [NSNumber numberWithInt:0];
            }
            
            // Only if the entire Forratter Entity group orderQuantity is Zero, then nil the forratter.orderBasket
            [self updateForratterEntityFromOrderBasket];
            
        }
        
        [self.orders removeObjectAtIndex:indexPath.row];
        [self refreshCoreData];
        [self accumulateTotalPrice];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [tableView reloadData];
    }
}




#pragma mark - Helper methods
-(void) updateForratterEntityFromOrderBasket
{
    int isForratterHasOrder = 0;
    
    // Check every ForrratterDetail.orderQuantity in Forratter entity
    for (Forratter *forratter in [self.basket.forratterOrders allObjects]) {
        NSArray *orderedForratter = [self orderForratter:forratter];
        
        for (int column = 0; column < orderedForratter.count ; column++) {
            ForratterDetails *forratterDetail = [orderedForratter objectAtIndex:column];
            int orderQuantity = [forratterDetail.orderQuantity intValue];
            if (orderQuantity > 0) {
                isForratterHasOrder++;
            }
        }
        
        if (isForratterHasOrder == 0) {
            forratter.orderBasket = nil;
        }
    }
    [self refreshCoreData];
}




-(void)refreshCoreData
{
    NSManagedObjectContext *context = [CCCoreDataHelper managedObjectContext];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"%@", error);
    }
}

-(OrderBasket *)fetchRequestOrderBasket
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"OrderBasket"];
    NSError *error = nil;
    NSArray *fetchMenus = [[CCCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchMenus count] > 0) {
        OrderBasket *basket = [fetchMenus objectAtIndex:0]; // only 1 OrderBasket in fetchMenus
        return basket;
    }
    else {
        OrderBasket *basket = nil;  // if nothing in the basket
        return basket;
    }
    
}


// method applies in viewDidLoad and commitEditingStyle
-(void)accumulateTotalPrice
{
    self.totalPrice = 0;
    BOOL isLunchPrice;
    isLunchPrice = [self isLunchPrice];
    
    for (Sushi *sushi in self.sushiBaskets) {
        if (isLunchPrice == YES) {
            self.totalPrice = self.totalPrice + [sushi.lunchPrice intValue]*[sushi.orderQuantity intValue];
        }
        else {
            self.totalPrice = self.totalPrice + [sushi.ordinariePrice intValue]*[sushi.orderQuantity intValue];
        }
    }
    for (Varmratt *varmratt in self.varmrattBaskets) {
        if (isLunchPrice == YES) {
            self.totalPrice = self.totalPrice + [varmratt.lunchPrice intValue]*[varmratt.orderQuantity intValue];
        }
        else {
            self.totalPrice = self.totalPrice + [varmratt.ordinariePrice intValue]*[varmratt.orderQuantity intValue];
        }
    }
    for (Sashimi *sashimi in self.sashimiBaskets) {
        self.totalPrice = self.totalPrice + [sashimi.ordinariePrice intValue]*[sashimi.orderQuantity intValue];
    }
    for (MakiMenu *maki in self.makiBaskets) {
        self.totalPrice = self.totalPrice + [maki.ordinariePrice intValue]*[maki.orderQuantity intValue];
    }
    for (Tillagg *tillagg in self.tillaggBaskets) {
        self.totalPrice = self.totalPrice + [tillagg.price intValue]*[tillagg.orderQuantity intValue];
    }
    
    for (ForratterDetails *forratterDetail in self.forratterBaskets) {
        self.totalPrice = self.totalPrice + [forratterDetail.price intValue]*[forratterDetail.orderQuantity intValue];
    }
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d kr",self.totalPrice];
}


- (IBAction)tommaBarButtonPressed:(UIBarButtonItem *)sender
{
    // reset all orderQuantity to be 0
    for (Sushi *sushi in self.sushiBaskets) {
        sushi.orderQuantity = [NSNumber numberWithInt:0];
        sushi.orderBasket = nil;
    }
    
    for (Varmratt *varmratt in self.varmrattBaskets) {
        varmratt.orderQuantity = [NSNumber numberWithInt:0];
        varmratt.orderBasket = nil;
    }
    
    for (Sashimi *sashimi in self.sashimiBaskets) {
        sashimi.orderQuantity = [NSNumber numberWithInt:0];
        sashimi.orderBasket = nil;
    }
    
    for (MakiMenu *maki in self.makiBaskets) {
        maki.orderQuantity = [NSNumber numberWithInt:0];
        maki.orderBasket = nil;
    }
    
    for (Tillagg *tillagg in self.tillaggBaskets) {
        tillagg.orderQuantity = [NSNumber numberWithInt:0];
        tillagg.orderBasket = nil;
    }
    
    for (ForratterDetails *forratterDetail in self.forratterBaskets) {
        forratterDetail.orderQuantity = [NSNumber numberWithInt:0];
        [self updateForratterEntityFromOrderBasket];
    }
    
    [self refreshCoreData];
    [self.orders removeAllObjects];
    [self accumulateTotalPrice];
    [self.tableView reloadData];
}

// Return ordered NSArray from NSSet Forratter
-(NSArray *)orderForratter: (Forratter *)forratter
{
    NSSet *scatteredForratter = forratter.forratterBundle;
    NSArray *unorderedForratter = [scatteredForratter allObjects];
    NSArray *orderedForratter = [unorderedForratter sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"size" ascending:YES]]];
    
    return orderedForratter;
}

// Attach string to label
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


// Lunch price only applies in sushi and varmratt
-(BOOL)isLunchPrice
{
    BOOL isLunchPrice = NO;
    NSDate *now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:now];
    NSDateComponents *timeComponents = [gregorian components:NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:now];
    
    NSInteger todayWeekday, hour, minute ;
    todayWeekday = weekdayComponents.weekday; // Sunday = 1, Saturday = 7
    hour = timeComponents.hour;
    minute = timeComponents.minute;
//    todayWeekday = 2;         // manipulate the weekday and time
//    hour = 14;                // manipulate the weekday and time
//    minute = 59;              // manipulate the weekday and time

    
    // lunch price applies on work day and 0800 ~ 1430
    if (todayWeekday > 1 && todayWeekday < 7 && (hour <= 14) ) {
        if (hour == 14 && minute <= 30) {
            NSLog(@"lunch price");
            isLunchPrice = YES;
        }
        NSLog(@"lunch price");
        isLunchPrice = YES;
    }
    else {
        NSLog(@"ordinarie price");
        isLunchPrice = NO;
    }
    return isLunchPrice;
}


@end
