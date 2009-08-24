//
//  MethodViewController.h
//  Rurimaphone
//
//  Created by Motohiro Takayama on 8/24/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MethodViewController : UITableViewController
{
   NSDictionary *method;
}

@property (nonatomic,retain) NSDictionary *method;

@end