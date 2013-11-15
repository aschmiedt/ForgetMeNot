//
//  FMNViewController.m
//  ForgetMeNot
//
//  Created by Abby Schmiedt on 11/6/13.
//  Copyright (c) 2013 Lucky7. All rights reserved.
//

#import "FMNViewController.h"
#import "textmessageViewController.h"
#import "PendingMessages.h"
#import "MessageComposerViewController.h"

@interface FMNViewController ()
@property NSMutableArray *messageArray;
@end

@implementation FMNViewController
- (void)viewDidLoad
{
    self.messageArray = [[NSMutableArray alloc] init];
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Data.plist"];
    self.messageArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    if(self.messageArray==nil){
        self.messageArray = [[NSMutableArray alloc] init];
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"textseg"]){
        textmessageViewController *vc = segue.destinationViewController;
        vc.messageArray=self.messageArray;
    }
    if([segue.identifier isEqualToString:@"tableseg"]){
        UINavigationController *vc = segue.destinationViewController;
        PendingMessages *vc2 = vc.topViewController;
        vc2.messageArray=self.messageArray;
    }
}
@end


