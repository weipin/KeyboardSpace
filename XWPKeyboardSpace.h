//
//  XWPKeyboardSpace.h
//  
//
//  Created by Weipin Xia on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class XWPKeyboardSpace;
@protocol XWPKeyboardSpaceDelegate <NSObject>

- (BOOL)keyboardSpace:(XWPKeyboardSpace *)keyboardSpace shouldLayoutFirstResponder:(UIView *)firstResponder;

@end


@interface XWPKeyboardSpace : NSObject {
  id<XWPKeyboardSpaceDelegate> delegate_;
  UIView *view_;
  
  // Will be used to restore original offset, and y == -999 means we have never done such scroll yet.
  CGPoint viewContentOffsetBeforeKeyboardIsShown_;  
}

@property (readwrite, assign) id<XWPKeyboardSpaceDelegate> delegate;

+ (id)sharedInstance;

- (void)attachToView:(UIView *)view;
- (void)attachToView:(UIView *)view withDelegate:(id<XWPKeyboardSpaceDelegate>)delegate;
- (void)detachFromView;

@end
