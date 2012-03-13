//
//  XWPKeyboardSpace.h
//  
//
//  Created by Weipin Xia on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface XWPKeyboardSpace : NSObject {
  UIView *view_;
  
  // Will be used to restore original offset, and y == -999 means we have never done such scroll yet.
  CGPoint viewContentOffsetBeforeKeyboardIsShown_;  
}

+ (id)sharedInstance;

- (void)attachToView:(UIView *)view;
- (void)detachFromView;

@end
