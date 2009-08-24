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
   NSLog(@"text = %@", textView.text);
   textView.text = [method objectForKey:@"body"];
   textView.font = [UIFont systemFontOfSize:14];
   [super viewDidLoad];
   self.title = [NSString stringWithFormat:@"%@#%@", [classInfo objectForKey:@"name"], [method objectForKey:@"names"]];
}

- (void)dealloc
{
    [super dealloc];
}

- (IBAction) searchSnippets
{
}

- (IBAction) tweet
{
}

@end