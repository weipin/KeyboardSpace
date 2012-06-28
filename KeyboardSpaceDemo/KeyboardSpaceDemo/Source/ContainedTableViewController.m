//
//  ContainedTableViewController.m
//  KeyboardSpaceDemo
//
//  Created by Weipin Xia on 6/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "XWPKeyboardSpace.h"

#import "StandardBehaviorController.h"

#import "ContainedTableViewController.h"


@implementation ContainedTableViewController

@dynamic tableController;

- (void)initReloadable {
  [self.view addSubview:self.tableController.view];
  self.tableController.view.frame = self.view.bounds;
  
  [[XWPKeyboardSpace sharedInstance] attachToView:self.view];
}

- (void)deallocReloadable {
  [[XWPKeyboardSpace sharedInstance] detachFromView];
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

#pragma mark - Accessor 

- (StandardBehaviorController *)tableController {
  if (tableController_) {
    return tableController_;
  }
  
  tableController_ = [[StandardBehaviorController alloc] init];
  return tableController_;
}

@end
