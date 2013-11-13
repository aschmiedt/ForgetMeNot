//
//  textmessageViewController.m
//  ForgetMeNot
//
//  Created by Abby Schmiedt on 11/11/13.
//  Copyright (c) 2013 Lucky7. All rights reserved.
//

#import "textmessageViewController.h"
#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface textmessageViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *dateField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UITextView *messageField;


@end

@interface ccViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *numberField;

- (IBAction)showPicker:(id)sender;

@end


@implementation textmessageViewController

//hide keyboard (only works for textField for now
@synthesize nameField;
@synthesize numberField;
@synthesize messageField;

- (IBAction)backgroundTouched:(id)sender {
    [nameField resignFirstResponder];
    [numberField resignFirstResponder];
    [messageField resignFirstResponder];
}

- (IBAction)textfieldReturn:(id)sender {
    [sender resignFirstResponder];
}


- (IBAction)saveButton:(id)sender {
    //this dictionary holds the recipients name, number, and message
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:self.nameField.text forKey:@"Name"];
    [dict setObject:self.dateField.date forKey:@"Date"];
    [dict setObject:self.numberField.text forKey:@"Number"];
    [dict setObject:self.messageField.text forKey:@"Message"];
    
    //This code writes the dictionary to a file in the phone
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    [self.messageArray addObject:dict];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Data.plist"];
    [self.messageArray writeToFile:plistPath atomically:YES];

    
    NSLog(@"%@", self.messageArray);
    //If i wanted to create a method to convert the date into a string so that I can display it in a table where would I do that?
    
    [self.messageField resignFirstResponder];
    
    NSDate *pickerDate = [self.dateField date];
    
    // Schedule the notification
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = pickerDate;
    
    localNotification.alertBody = self.messageField.text;
    
    localNotification.alertAction = @"Show me the item";
    
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
    
    // Request to reload table view data
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    
    
    // Dismiss the view controller
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    [self.messageField resignFirstResponder];
    
    return NO;
    

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
	// Do any additional setup after loading the view.
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showPicker:(id)sender
{
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentModalViewController:picker animated:YES];
}
- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissModalViewControllerAnimated:YES];
}


- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    [self displayPerson:person];
    [self dismissModalViewControllerAnimated:YES];
    
    return NO;
}

- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

- (void)displayPerson:(ABRecordRef)person
{
    NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                                    kABPersonFirstNameProperty);
    self.nameField.text = name;
    
    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"[None]";
    }
    self.numberField.text = phone;
    CFRelease(phoneNumbers);
}

@end
