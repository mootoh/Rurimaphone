//
//  CodeSearchResultViewController.h
//  Rurimaphone
//
//  Created by Motohiro Takayama on 8/25/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeSearchResultViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource>
{
   IBOutlet UITableView *table_view;
   NSArray *result;
   NSString *queryFor;
}

@property (nonatomic, retain) NSArray *result;
@property (nonatomic, retain) NSString *queryFor;

@end