//
//  ClassViewController.h
//  Rurimaphone
//
//  Created by mootoh on 8/24/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ClassViewController : UITableViewController
{
   NSDictionary *classInfo;
}

@property (nonatomic, retain) NSDictionary *classInfo;
@end
