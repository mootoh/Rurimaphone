//
//  ClassViewController.h
//  Rurimaphone
//
//  Created by mootoh on 8/24/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Database;

@interface ClassViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
   NSDictionary *classInfo;
   Database *database;
   NSArray *methods;
   IBOutlet UITableView *table_view;
}

@property (nonatomic, retain) NSDictionary *classInfo;
@property (nonatomic, retain) Database *database;
@property (nonatomic, retain) NSArray *methods;

- (IBAction) searchSnippets;
- (IBAction) tweet;

@end