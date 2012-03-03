//
//  XWPUIView+Accessing.m
//  FJSP
//
//  Created by Xia on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XWPUIView+Accessing.h"


@implementation UIView (XWPUIViewAccessing)

- (id)xwp_firstResponder {
  if (self.isFirstResponder) {
    return self;     
  }
  
  for (UIView *i in self.subviews) {
    UIView *found = [i xwp_firstResponder];
    if (!found) {
      continue;
    }
    return found;
  }
  
  return nil;
}

@end
