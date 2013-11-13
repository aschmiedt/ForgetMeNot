//
//  textmessageViewController.h
//  ForgetMeNot
//
//  Created by Abby Schmiedt on 11/11/13.
//  Copyright (c) 2013 Lucky7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface textmessageViewController : UIViewController
@property NSMutableArray *messageArray;

//part of the hide keyboard code
- (IBAction)backgroundTouched:(id)sender;
- (IBAction)textfieldReturn:(id)sender;

@end
