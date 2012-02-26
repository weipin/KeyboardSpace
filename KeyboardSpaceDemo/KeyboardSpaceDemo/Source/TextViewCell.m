//
//  TextViewCell.m
//  KeyboardSpaceDemo
//
//  Created by Weipin Xia on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TextViewCell.h"

@implementation TextViewCell

@synthesize textView = textView_;

- (void)dealloc {
  self.textView = nil;
  
  [super dealloc];
}

@end
