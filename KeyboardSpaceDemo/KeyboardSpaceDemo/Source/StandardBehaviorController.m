//
//  StandardBehaviorController.m
//  KeyboardSpaceDemo
//
//  Created by Weipin Xia on 2/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TextFieldCell.h"

#import "StandardBehaviorController.h"

const NSUInteger kStandardBehaviorControllerRows = 40;

@implementation StandardBehaviorController

- (void)initReloadable {
  UINib *nib = [UINib nibWithNibName:@"TextFieldCell" bundle:nil];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"TextFieldCell"];
}

- (void)deallocReloadable {
  
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
  return kStandardBehaviorControllerRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"TextFieldCell";
  
  TextFieldCell *cell = (TextFieldCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  cell.textField.delegate = self;
  
  return cell;
}

#pragma mark - Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self.view endEditing:YES];
  
  return YES;
}


@end
