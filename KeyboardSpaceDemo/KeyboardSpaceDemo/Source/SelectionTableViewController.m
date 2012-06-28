//
//  SelectionTableViewController.m
//  KeyboardSpaceDemo
//
//  Created by Weipin Xia on 2/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectionTableViewController.h"

@interface SelectionTableViewController ()

@property (readwrite, retain) NSArray *demoControllers;

@end


NSString *const kDemoControllerClassKey = @"Class";
NSString *const kDemoControllerDescriptionKey = @"Description";

@implementation SelectionTableViewController

@synthesize demoControllers = demoControllers_;

- (void)initReloadable {
  self.demoControllers = [NSArray arrayWithObjects:
                          [NSDictionary dictionaryWithObjectsAndKeys:
                           @"StandardBehaviorController", kDemoControllerClassKey,
                           @"Standard Behavor", kDemoControllerDescriptionKey,                           
                           nil],                           
                          
                          [NSDictionary dictionaryWithObjectsAndKeys:
                           @"StandardBehavior2Controller", kDemoControllerClassKey,
                           @"Standard Behavor2", kDemoControllerDescriptionKey,                           
                           nil],                           

                          [NSDictionary dictionaryWithObjectsAndKeys:
                           @"StandardViewController", kDemoControllerClassKey,
                           @"Standard View", kDemoControllerDescriptionKey,                           
                           nil],                           
                          
                          [NSDictionary dictionaryWithObjectsAndKeys:
                           @"ContainedTableViewController", kDemoControllerClassKey,
                           @"Contained table view", kDemoControllerDescriptionKey,                           
                           nil],                           
                          nil];
}

- (void)deallocReloadable {
  self.demoControllers = nil;
}

- (void)dealloc {
  [self deallocReloadable];
  
  [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self initReloadable];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self deallocReloadable];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.demoControllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  NSDictionary *dict = [self.demoControllers objectAtIndex:indexPath.row];
  cell.textLabel.text = [dict objectForKey:kDemoControllerDescriptionKey];
  
  return cell;
}

#pragma mark - Table delegatw

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  NSDictionary *dict = [self.demoControllers objectAtIndex:indexPath.row];
  NSString *classString = [dict objectForKey:kDemoControllerClassKey];
  Class theClass = NSClassFromString(classString);
  
  UIViewController *controller = [[[theClass alloc] init] autorelease];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
