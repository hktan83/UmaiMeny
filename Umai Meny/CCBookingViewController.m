//
//  CCBookingViewController.m
//  Umai Meny
//
//  Created by Caleb on 19/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCBookingViewController.h"
#import "SWRevealViewController.h"

static NSString *kCellID = @"Cell";                     // The first 3 cells contains name, telephone, and email
static NSString *kPersonerCellID = @"personerCell";     // the cell contains personer
static NSString *kDateCellID = @"dateCell";             // the cell with the appointment date
static NSString *kDatePickerCellID = @"datePickerCell"; // the cell contains date picker
static NSString *kCommentTextFieldID = @"commentTextFieldCell"; // the cell with textViewCell

// keep track of which row has date cells
#define kDateRow 1

#define SAVE_BOOKING_KEY @"saveBookingKey"

@interface CCBookingViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

// keep track which indexPath points to the cell with UIDatePicker
@property (nonatomic, strong) NSIndexPath *datePickerIndexPath;
@property (assign) NSInteger pickerCellRowHeight;
@property (nonatomic, retain) UITextField *activeField;
@property (nonatomic, strong) NSMutableArray *bookingDetails;

@end


@implementation CCBookingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Lazy Instantiation
-(NSMutableArray *)bookingDetails
{
    if (!_bookingDetails) {
        _bookingDetails = [[NSMutableArray alloc] initWithCapacity:6];
    }
    return _bookingDetails;
}

#pragma mark - Initialization
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
    
    // Set tableView DataSource and Delegate
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd MMMM yyyy  HH:mm"];
    
    // obtain the picker view cell's height, works because the cell was pre-defined in our storyboard
    UITableViewCell *pickerViewCellToCheck = [self.tableView dequeueReusableCellWithIdentifier:kDatePickerCellID];
    self.pickerCellRowHeight = pickerViewCellToCheck.frame.size.height;
    
    // The keyboard is dismissed when a drag begins
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    // Null the self.bookingDetails array
    for (NSInteger i = 0; i < 6; ++i) {
        [self.bookingDetails addObject:[NSNull null]];
    }

    // Unbox NSUserDefaults info
    NSArray *bookingDetailsAsPropertyList = [[NSUserDefaults standardUserDefaults] arrayForKey:SAVE_BOOKING_KEY];
    if (bookingDetailsAsPropertyList != nil) {
        // loading self.bookingDetails with NSUserDefaults
        for (NSInteger i = 0; i < 6; ++i) {
            [self.bookingDetails replaceObjectAtIndex:i withObject:bookingDetailsAsPropertyList[i]];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    // Here is where applies NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.bookingDetails forKey:SAVE_BOOKING_KEY];
    [userDefaults synchronize];
}


#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CGFloat rowHeight = self.tableView.rowHeight;
    if ([self hasInLineDatePicker] && (self.datePickerIndexPath.row == indexPath.row) && indexPath.section == 1) {
        rowHeight = self.pickerCellRowHeight;
    }
    return rowHeight;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    else {
        //use method hasInLineDatePicker method to know if we need to add an extra row for the dateCell or not
        NSInteger numberOfRows = 3;
        if ([self hasInLineDatePicker]) {
            numberOfRows ++;
        }
        return numberOfRows;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSString *cellID = kCellID; 
    
    if (indexPath.section == 1 && [self indexPathHasPicker:indexPath]) {
        //  the indexPath is the one containing the inline date picker
        cellID = kDatePickerCellID; // the current/opened date picker cell
    }
    else if (indexPath.section == 1 && [self indexPathHasDate:indexPath]) {
        cellID = kDateCellID;       // the date cell
    }
    else if (indexPath.section == 1 && indexPath.row == 0){
        cellID = kPersonerCellID;
    }
    else if (indexPath.section == 1) {
        cellID = kCommentTextFieldID;
    }
 
    cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (indexPath.section == 0) {
        
        UITextField *titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, (cell.contentView.bounds.size.height-30)/2, cell.contentView.bounds.size.width-30.0f, 30)];
        titleTextField.delegate = self;
        titleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;


        if (indexPath.row == 0) {
            titleTextField.tag = 1;
            titleTextField.placeholder = @"namn";
            titleTextField.keyboardType = UIKeyboardTypeDefault;
            titleTextField.returnKeyType = UIReturnKeyDone;
            if ([self.bookingDetails objectAtIndex:indexPath.row] != nil) {
                titleTextField.text = [self.bookingDetails objectAtIndex:indexPath.row];
            }
        }
        
        else if (indexPath.row == 1){
            titleTextField.tag = 2;
            titleTextField.placeholder = @"telefonnummer";
            titleTextField.keyboardType = UIKeyboardTypePhonePad;
            titleTextField.returnKeyType = UIReturnKeyDone;
            if ([self.bookingDetails objectAtIndex:indexPath.row] != nil) {
                titleTextField.text = [self.bookingDetails objectAtIndex:indexPath.row];
            }
        }
        
        else if (indexPath.row == 2){
            titleTextField.tag = 3;
            titleTextField.placeholder = @"example@gmail.com";
            titleTextField.keyboardType = UIKeyboardTypeEmailAddress;
            titleTextField.returnKeyType = UIReturnKeyDone;
            if ([self.bookingDetails objectAtIndex:indexPath.row] != nil) {
                titleTextField.text = [self.bookingDetails objectAtIndex:indexPath.row];
            }
        }
        [cell.contentView addSubview:titleTextField];
    }
    
    else if (indexPath.section == 1) {
        
        if ([cellID isEqualToString:kPersonerCellID]){
            cell.textLabel.text = @"Personer";
            UITextField *titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(200, (cell.contentView.bounds.size.height-30)/2, cell.contentView.bounds.size.width, 30)];
            titleTextField.delegate = self;
            titleTextField.adjustsFontSizeToFitWidth = YES;
            titleTextField.tag = 4;
            titleTextField.placeholder = @"personer";
            titleTextField.keyboardType = UIKeyboardTypeNumberPad;
            titleTextField.returnKeyType = UIReturnKeyDone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([self.bookingDetails objectAtIndex:indexPath.row+3] != nil) {
                titleTextField.text = [self.bookingDetails objectAtIndex:indexPath.row+3];
                
            }
            [cell.contentView addSubview:titleTextField];
        }
        
        else if ([cellID isEqualToString:kDateCellID]) {
            // we have date cell, populate their date field
            cell.textLabel.text = @"Datum";
            cell.detailTextLabel.text = [self.dateFormatter stringFromDate:[NSDate date]];
            if ([self.bookingDetails objectAtIndex:indexPath.row+3] != nil) {
                NSString *dateText = [self.dateFormatter stringFromDate:[self.bookingDetails objectAtIndex:indexPath.row+3]];
                cell.detailTextLabel.text = dateText;
            }
        }
        
        else if ([cellID isEqualToString:kCommentTextFieldID]){
            UITextField *titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, (cell.contentView.bounds.size.height-30)/2, cell.contentView.bounds.size.width, 30)];
            titleTextField.delegate = self;
            titleTextField.adjustsFontSizeToFitWidth = YES;
            titleTextField.tag = 5;
            titleTextField.placeholder = @"Kommenterar här";
            titleTextField.keyboardType = UIKeyboardTypeDefault;
            titleTextField.returnKeyType = UIReturnKeyDone;
            if ([self.bookingDetails objectAtIndex:indexPath.row+3] != nil) {
                titleTextField.text = [self.bookingDetails objectAtIndex:indexPath.row+3];
            }
            [cell.contentView addSubview:titleTextField];
        }
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate

/*
 if the selected cells is the cell that triggered the date picker to be shown the n we will hide the date picker.
 If it's a different cell then we will need to hide the current showing date picker, if any, then display the new one.
 */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView beginUpdates];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.reuseIdentifier == kDateCellID) {
        if ([self hasInLineDatePicker] && (self.datePickerIndexPath.row - 1 == indexPath.row)) {
            [self hideExistingPicker];
        }
        else {
            NSIndexPath *newPickerIndexPath = [self calculatedIndexPathForNewPicker:indexPath];
            if ([self hasInLineDatePicker]) {
                [self hideExistingPicker];
            }
            [self showNewPickerAtIndex:newPickerIndexPath];
            self.datePickerIndexPath = [NSIndexPath indexPathForRow:newPickerIndexPath.row + 1 inSection:1];
        }
    }
    else {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    [self.tableView endUpdates];
}


#pragma mark - masteringios

-(void)hideExistingPicker
{
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.datePickerIndexPath.row inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
     self.datePickerIndexPath = nil;
}

// If a date picker is visible and is above the currently selected index then we need to remember that the cell will be deleted
// from the table and adjust the index accordingly. If it is below then it won't impact the new date picker

-(NSIndexPath *)calculatedIndexPathForNewPicker:(NSIndexPath *)selectedIndexPath
{
    NSIndexPath *newIndexPath;
    if (([self hasInLineDatePicker]) && (self.datePickerIndexPath.row < selectedIndexPath.row)) {
        newIndexPath = [NSIndexPath indexPathForRow:selectedIndexPath.row - 1 inSection:1];
    }
    else {
        newIndexPath = [NSIndexPath indexPathForRow:selectedIndexPath.row inSection:1];
    }
    return newIndexPath;
}

-(void)showNewPickerAtIndex:(NSIndexPath *)indexPath
{
    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:1]];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
    
    UITableViewCell *cell = (UITableViewCell *) textField.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.section > 0 && indexPath.row > 0) {
        [self registerForKeyboardNotifications];
    }
    else {
        [self deregisterForKeyboardNotifications];
    }
}

// save the textField to self.bookingDetails
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
    UITableViewCell *cell = (UITableViewCell *) textField.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.section == 0) {
        [self.bookingDetails replaceObjectAtIndex:indexPath.row withObject:textField.text];
    }
    else if (indexPath.section == 1){
        [self.bookingDetails replaceObjectAtIndex:indexPath.row+3 withObject:textField.text];
    }
    NSLog(@"self.bookingDetails:%@",self.bookingDetails);
}


-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}


#pragma mark - Handling keyboard notifications
// RegisterForKeyboardNotification in textFieldDidBeginEditing:
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

// DeregisterForKeyboardNotification in textFieldDidBeginEditing:
-(void)deregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


// Called when the UIKeyboarDidShowNotification is sent

-(void)keyboardWasShown:(NSNotification *)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    
    // Start animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
}


// Called when the UIKeyboardWillHideNotification is sent
-(void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    // Once keyboard is hidden then bring back the table into original position
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(64, 0.0, 0.0 , 0.0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    
    // Start animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
    
}


#pragma mark - Helper methods

// check if the personer picker is shown or not based on the property we've just defined
-(BOOL)hasInLineDatePicker
{
    // Returns true if self.datePickerIndexPath is not equal to nil
    return (self.datePickerIndexPath != nil);
}

// Determines if the given indexPath points to a cell that contains the UIDatePicker
-(BOOL)indexPathHasPicker:(NSIndexPath *)indexPath
{
    return ([self hasInLineDatePicker] && self.datePickerIndexPath.row == indexPath.row);
}

// Determines if the given indexPath points to a cell that contains the date
-(BOOL)indexPathHasDate:(NSIndexPath *)indexPath
{
    BOOL hasDate = NO;
    
    if (indexPath.row == kDateRow || ([self hasInLineDatePicker] && (indexPath.section ==  1))) {
        hasDate = YES;
    }
    return hasDate;
}


#pragma mark - IBAction

- (IBAction)dateChange:(UIDatePicker *)sender
{
    NSIndexPath *targetedCellIndexPath = nil;
    
    if ([self hasInLineDatePicker]) {
        // inline date picker: update the cell's date "above" the date picker cell
        targetedCellIndexPath = [NSIndexPath indexPathForRow:self.datePickerIndexPath.row - 1 inSection:1];
    }
    else {
        // external date picker: update the current "selected" cell's date
        targetedCellIndexPath = [self.tableView indexPathForSelectedRow];
    }
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:targetedCellIndexPath];
    
    // update the cell's date string
    cell.detailTextLabel.text = [self.dateFormatter stringFromDate:sender.date];
    [self.bookingDetails replaceObjectAtIndex:4 withObject:sender.date];
    NSLog(@"self.bookingDetails :%@",self.bookingDetails);

    
}

#pragma mark - UIAlertView and UIAlertViewDelegate
- (IBAction)clearBarButtonPressed:(UIBarButtonItem *)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are you going to erase all the information?" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    UITextField *textField = (UITextField *)[self.tableView viewWithTag:1];
//    textField.text = @"";
//    
   if (buttonIndex == 1){
        // clear self.bookingDetails the entire array
        for (NSInteger i = 0; i < 6; ++i) {
            [self.bookingDetails replaceObjectAtIndex:i withObject:@""];
            // update NSUserDefault
        }
        // reload table
       [self.tableView reloadData];
    }
}


@end
