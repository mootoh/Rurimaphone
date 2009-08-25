//
//  TweetViewController.m
//  Rurimaphone
//
//  Created by Motohiro Takayama on 8/25/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import "TweetViewController.h"


@implementation TweetViewController

@synthesize prefix;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
   [super viewDidLoad];
   self.title = prefix;
   
   UIImage *tweetImage = [UIImage imageNamed:@"23-bird.png"];
   UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithImage:tweetImage style:UIBarButtonItemStyleBordered target:self action:@selector(tweet)];   
   self.navigationItem.rightBarButtonItem = tweetButton;
   [tweetButton release];
   [tweetImage release];

   UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
   self.navigationItem.leftBarButtonItem = cancelButton;   
   [cancelButton release];
   
   [textView becomeFirstResponder];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void) tweet
{
   NSString *content = [NSString stringWithFormat:@"status=%@: %@ #rurima", prefix, textView.text];
   
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   NSLog(@"twitter account:%@, password=%@", [defaults stringForKey:@"username_preference"], [defaults stringForKey:@"password_preference"]);
   
   NSString *urlString = [NSString stringWithFormat:@"http://%@:%@@twitter.com/statuses/update.json",
                          [defaults stringForKey:@"username_preference"],
                          [defaults stringForKey:@"password_preference"]];
   
   NSURL *url = [NSURL URLWithString:urlString];
   NSMutableURLRequest *urlRequest = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
   [urlRequest setHTTPMethod:@"POST"];
   [urlRequest setHTTPBody:[content dataUsingEncoding:NSUTF8StringEncoding]];
   
   NSURLResponse *response;
   NSError *err;
   NSData *ret = [NSURLConnection sendSynchronousRequest:urlRequest
                                       returningResponse:&response
                                                   error:&err];
   
	NSString *result = [[[NSString alloc] initWithData:ret encoding:NSUTF8StringEncoding] autorelease];
   NSLog(@"NSURLConnection result = %@", result);
   [self dismissModalViewControllerAnimated:YES];
}

- (void) cancel
{
   [self dismissModalViewControllerAnimated:YES];
}
@end
