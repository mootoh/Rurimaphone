//
//  TweetViewController.h
//  Rurimaphone
//
//  Created by Motohiro Takayama on 8/25/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TweetViewController : UIViewController {
   IBOutlet UITextView *textView;
   NSString *prefix;
}

@property (nonatomic, retain) NSString *prefix;

@end
