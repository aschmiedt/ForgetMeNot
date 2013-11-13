//
//  textmessageViewController.m
//  ForgetMeNot
//
//  Created by Abby Schmiedt on 11/11/13.
//  Copyright (c) 2013 Lucky7. All rights reserved.
//

#import "textmessageViewController.h"

@interface textmessageViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *dateField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UITextView *messageField;
@property NSMutableArray *messageArray;

@end

@implementation textmessageViewController
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
    
    //This array holds the different messages
    
    
    NSLog(@"%@", self.messageArray);

    
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
    self.messageArray = [[NSMutableArray alloc] init];
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Data.plist"];
    self.messageArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    if(self.messageArray==nil){
        self.messageArray = [[NSMutableArray alloc] init];
    }
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end