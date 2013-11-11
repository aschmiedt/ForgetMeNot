//
//  EmailViewController.h
//  ForgetMeNot
//
//  Created by Jamie on 11/11/13.
//  Copyright (c) 2013 Lucky7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmailViewController : UIViewController <UITextFieldDelegate>
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *itemText;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
