//
//  StandardBehavior2Controller.m
//  KeyboardSpaceDemo
//
//  Created by Weipin Xia on 2/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TextViewCell.h"

#import "StandardBehavior2Controller.h"

const NSUInteger kStandardBehaviorController2Rows = 40;

@implementation StandardBehavior2Controller

- (void)initReloadable {
  UINib *nib = [UINib nibWithNibName:@"TextViewCell" bundle:nil];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"TextViewCell"];
  
  self.tableView.rowHeight = 172.0;
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
  return kStandardBehaviorController2Rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"TextViewCell";
  
  TextViewCell *cell = (TextViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  cell.textView.delegate = self;
  
  return cell;
}

#pragma mark - Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
  self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                                          target:self 
                                                                                          action:@selector(done:)] autorelease];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
  self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - Action

- (IBAction)done:(id)sender {
  [self.view endEditing:YES];
}

@end
