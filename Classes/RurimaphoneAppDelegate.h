//
//  RurimaphoneAppDelegate.h
//  Rurimaphone
//
//  Created by mootoh on 8/24/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

@interface RurimaphoneAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

