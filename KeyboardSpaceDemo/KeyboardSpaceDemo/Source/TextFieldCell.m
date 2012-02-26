//
//  TextFieldCell.m
//  KeyboardSpaceDemo
//
//  Created by Weipin Xia on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

@synthesize textField = textField_;

- (void)dealloc {
  self.textField = nil;
  
  [super dealloc];
}

@end
