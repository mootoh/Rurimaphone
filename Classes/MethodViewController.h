//
//  MethodViewController.h
//  Rurimaphone
//
//  Created by Motohiro Takayama on 8/24/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MethodViewController : UIViewController
{
   NSDictionary *classInfo;
   NSDictionary *method;
   IBOutlet UITextView *textView;
}

@property (nonatomic,retain) NSDictionary *classInfo;
@property (nonatomic,retain) NSDictionary *method;

- (IBAction) searchSnippets;
- (IBAction) tweet;

@end