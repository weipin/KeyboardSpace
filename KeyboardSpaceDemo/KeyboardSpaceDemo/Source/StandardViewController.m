//
//  StandardViewController.m
//  KeyboardSpaceDemo
//
//  Created by Weipin Xia on 3/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "XWPKeyboardSpace.h"

#import "StandardViewController.h"


@implementation StandardViewController

- (void)initReloadable {
  [[XWPKeyboardSpace sharedInstance] attachToView:self.view];
}

- (void)deallocReloadable {
  [[XWPKeyboardSpace sharedInstance] deattachFromView];
  
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

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self.view endEditing:YES];
  
  return YES;
}


@end
