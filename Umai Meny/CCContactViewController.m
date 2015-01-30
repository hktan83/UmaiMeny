//
//  CCInfoViewController.m
//  Umai Meny
//
//  Created by Caleb on 07/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCContactViewController.h"
#import "SWRevealViewController.h"

@interface CCContactViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSArray *numberArray;

@end

@implementation CCContactViewController

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
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.umaiContacts = @{@"Umai": @"035120030", @"Mobil": @"0704977111", @"Adress": @"Lars Montinsväg 29, 30292 Halmstad, Sweden", @"epost": @"marklow622@gmail.com", @"hemsidan": @"www.sushiumai.com"};
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    else {
        return 1;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Umai";
            cell.detailTextLabel.text = self.umaiContacts[@"Umai"];
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"Mobil";
            cell.detailTextLabel.text = self.umaiContacts[@"Mobil"];
        }

    }
    else if (indexPath.section == 1){
        cell.textLabel.text = @"Adress";
        cell.detailTextLabel.text = self.umaiContacts[@"Adress"];
    }
    
    else if (indexPath.section == 2) {
        cell.textLabel.text = @"epost";
        cell.detailTextLabel.text = self.umaiContacts[@"epost"];
    }
    
    else if (indexPath.section == 3) {
        cell.textLabel.text = @"hemsidan";
        cell.detailTextLabel.text = self.umaiContacts[@"hemsidan"];
    }

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Contacts
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSString *alertMsg = [[NSString alloc] initWithFormat:@"Ring %@", self.umaiContacts[@"Umai"]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:alertMsg delegate:self cancelButtonTitle:@"Nej" otherButtonTitles:@"Ja", nil];
            alert.tag = indexPath.row;
            [alert show];
//            [self phoneCall:self.umaiContacts[@"Umai"]];
        }
        else if (indexPath.row == 1) {
            NSString *alertMsg = [[NSString alloc] initWithFormat:@"Ring %@", self.umaiContacts[@"Mobil"]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:alertMsg delegate:self cancelButtonTitle:@"Nej" otherButtonTitles:@"Ja", nil];
            alert.tag = indexPath.row;
            [alert show];
//            [self phoneCall:self.umaiContacts[@"Mobil"]];
        }
    }
    
    // Address
    if (indexPath.section == 1) {
        Class mapItemClass = [MKMapItem class];
        if (mapItemClass && [mapItemClass respondsToSelector: @selector(openMapsWithItems:launchOptions:)]) {
            // Create a MKMapItem to pass to the Maps app
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            [geocoder geocodeAddressString:self.umaiContacts[@"Adress"] completionHandler:^(NSArray *placemarks, NSError *error) {
                // Process the placemark
                if (error) {
                    NSLog(@"Error %@", error.description);
                }
                if (placemarks && placemarks.count>0) {
                    CLPlacemark *placemarker = placemarks[0];
                    CLLocation *location = placemarker.location;
                    CLLocationCoordinate2D coordinate = location.coordinate;
//                    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(+56.66094872,+12.80639275);
                    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
                    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
                    [mapItem setName:@"Umai"];
                    // Pass the map item to the Maps app
                    [mapItem openInMapsWithLaunchOptions:nil];
                }
            }];
        }
    }
    
    // epost
    if (indexPath.section == 2) {
//        NSString *mailToStr = [[NSString alloc] initWithFormat:@"mailto:marklow622@gmail.com"];
//        NSURL *mailToURL = [[NSURL alloc] initWithString:mailToStr];
//        [[UIApplication sharedApplication] openURL:mailToURL];
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setSubject:@"Bokning"];
        [controller setMessageBody:@"" isHTML:NO];
        if (controller) {
            [self presentViewController:controller animated:YES completion:^{

            }];
        }
    }
    
    // hemsidan
    if (indexPath.section == 3) {
//        UIApplication *mySafari = [UIApplication sharedApplication];
        NSString *URLString = [[NSString alloc] initWithFormat:@"http://%@", self.umaiContacts[@"hemsidan"]];
        NSURL *myURL = [[NSURL alloc] initWithString:URLString];
        [[UIApplication sharedApplication] openURL:myURL];
    }
}

#pragma mark - Alert View

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && alertView.tag == 0) {
//        NSLog(@"alert.tag =%ld", (long)alertView.tag);
        [self phoneCall:self.umaiContacts[@"Umai"]];
    }
    else if (buttonIndex == 1 && alertView.tag == 1) {
        [self phoneCall:self.umaiContacts[@"Mobil"]];
    }
}

#pragma mark -helper methods

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"email sent");
    }
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"email sending done");
    }];
}

-(void)phoneCall:(NSString *)phoneNumber
{
    NSString *phoneStr = [[NSString alloc] initWithFormat:@"tel:%@", phoneNumber];
    NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
    [[UIApplication sharedApplication] openURL:phoneURL];
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *myString;
//    if (section == 0) {
//        myString= @"section 0";
//    }
//    else if (section == 1) {
//        myString = @"section 1";
//    }
//    return myString;
//}


@end
