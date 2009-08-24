//
//  MethodViewController.m
//  Rurimaphone
//
//  Created by Motohiro Takayama on 8/24/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import "MethodViewController.h"


@implementation MethodViewController
@synthesize method, classInfo;

- (void)viewDidLoad {
   [super viewDidLoad];
   self.title = [NSString stringWithFormat:@"%@#%@", [classInfo objectForKey:@"name"], [method objectForKey:@"names"]];

   UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(16, 16, 320-16*2, 400)];
   textView.editable = NO;
   textView.text = [method objectForKey:@"body"];
   [self.view addSubview:textView];
   [textView release];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)dealloc
{
    [super dealloc];
}


@end

