//
//  RootViewController.h
//  Rurimaphone
//
//  Created by mootoh on 8/24/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

@class Database;

@interface RootViewController : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
{
   Database *database;
   IBOutlet UITableView *table_view;
   IBOutlet UISearchBar *search_bar;
}

@end