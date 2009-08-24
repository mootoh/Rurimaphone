//
//  ClassViewController.m
//  Rurimaphone
//
//  Created by mootoh on 8/24/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import "ClassViewController.h"
#import "MethodViewController.h"
#import "Database.h"

@implementation ClassViewController

@synthesize classInfo;
@synthesize database;
@synthesize methods;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

- (void)viewDidLoad {
   [super viewDidLoad];
   self.title = [classInfo objectForKey:@"name"];
   self.methods = [database methods:[classInfo objectForKey:@"name"]];
   
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
   [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
   //[self.navigationController setNavigationBarHidden:YES animated:NO];
}
*/

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   if (section == 0) {
      return 1;
   } else {
      return methods.count;
   }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   static NSString *CellIdentifierForAbstract = @"ClassViewCellAbstract";
   static NSString *CellIdentifierForMethod = @"ClassViewCellMethod";

   UITableViewCell *cell = nil;
   if (indexPath.section == 0) {
      cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierForAbstract];
      if (cell == nil) {
         cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierForAbstract] autorelease];
      }
   } else {
      cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierForMethod];
      if (cell == nil) {
         cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifierForMethod] autorelease];
      }
   }
    
   if (indexPath.section == 0) {
      cell.textLabel.font = [UIFont systemFontOfSize:12];
      cell.textLabel.numberOfLines = 16;
      cell.textLabel.text = [classInfo objectForKey:@"body"];
   } else {
      cell.textLabel.text = [[methods objectAtIndex:indexPath.row] objectForKey:@"names"];
      NSString *body = [[methods objectAtIndex:indexPath.row] objectForKey:@"body"];
      
      if (body.length > 80) body = [body substringToIndex:80];
      cell.detailTextLabel.text = body;
   }

   return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   if (indexPath.section == 0) return;
	MethodViewController *anotherViewController = [[MethodViewController alloc] initWithNibName:@"MethodView" bundle:nil];
   anotherViewController.classInfo = classInfo;
   anotherViewController.method = [methods objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:anotherViewController animated:YES];
	[anotherViewController release];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.section == 0) {
      return 44.0f * 5.0f;
   }
   return 44.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   if (section == 0)
      return @"Abstract";
   return @"methods";
}

- (void)dealloc
{
   [methods release];
   [database release];
   [super dealloc];
}

- (IBAction) searchSnippets
{
}

- (IBAction) tweet
{
}

@end