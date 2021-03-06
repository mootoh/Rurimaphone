//
//  RurimaphoneAppDelegate.m
//  Rurimaphone
//
//  Created by mootoh on 8/24/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

#import "RurimaphoneAppDelegate.h"
#import "RootViewController.h"


@implementation RurimaphoneAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	[window addSubview:[navigationController view]];
   [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end