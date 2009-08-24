//
//  CodeSearchViewController.h
//  Rurimaphone
//
//  Created by Motohiro Takayama on 8/25/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CodeSearchViewController : UIViewController
{
   IBOutlet UIWebView *webView;
   NSString *url;
}

@property (nonatomic, retain) NSString *url;
@end
