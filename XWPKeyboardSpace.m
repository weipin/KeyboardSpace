//
//  XWPKeyboardSpace.m
//  
//
//  Created by Weipin Xia on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GTMObjectSingleton.h"

#import "XWPUIView+Accessing.h"
#import "XWPKeyboardSpace.h"

@interface XWPKeyboardSpace ()

@property (readwrite, assign) UIView *view;

@property (readwrite, assign) CGRect keyboardFrame;
@property (readwrite, assign) CGPoint viewContentOffsetBeforeKeyboardIsShown;

@end


@implementation XWPKeyboardSpace

@dynamic view;

@synthesize keyboardFrame = keyboardFrame_;
@synthesize viewContentOffsetBeforeKeyboardIsShown = viewContentOffsetBeforeKeyboardIsShown_;

GTMOBJECT_SINGLETON_BOILERPLATE(XWPKeyboardSpace, sharedInstance)

- (id)init {
  if (self = [super init]) {
    self.viewContentOffsetBeforeKeyboardIsShown = CGPointMake(0, -999);
  }
  
  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  
  [super dealloc];
}

#pragma mark - Accessor 

- (UIView *)view {
  return view_;
}

- (void)setView:(UIView *)view {
  [view_ autorelease];
  view_ = [view retain];
  
  self.viewContentOffsetBeforeKeyboardIsShown = CGPointMake(0, -999);

  [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)attachToView:(UIView *)view {
  [[NSNotificationCenter defaultCenter] removeObserver:self];

  self.view = view;
}

- (void)deattachFromView {
  self.view = nil;
}

#pragma mark - Notification

- (void)keyboardWillShow:(NSNotification *)notification {
  if (!self.view) {
    return;
  }
  
  NSDictionary *userInfo = [notification userInfo];  
  // Get the frame of the keyboard in window's coordinate system.
  NSValue* value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];  
  CGRect keyboardRect = [value CGRectValue];
  self.keyboardFrame = [self.view convertRect:keyboardRect fromView:nil];
  
  // Get the duration of the animation.
  NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
  NSTimeInterval animationDuration;
  [animationDurationValue getValue:&animationDuration];

  UIView *theView = [self.view xwp_firstResponder];
  if (!theView) {
    return;
  }
  
  CGRect theViewFrame = theView.frame;
//  theViewFrame = [self.view.window convertRect:theViewFrame fromView:self.view];
  if (!CGRectIntersectsRect(self.keyboardFrame, theViewFrame)) {
    return;
  }
  
  self.viewContentOffsetBeforeKeyboardIsShown = self.view.frame.origin;
  
  CGFloat offset = CGRectGetMaxY(theViewFrame) - CGRectGetMinY(self.keyboardFrame);
  _GTMDevAssert(offset > 0, @"");
  
  CGPoint contentOffset = self.view.frame.origin;
  contentOffset.y -= offset;
  
  // Animate the scrolling of the table view in sync with the keyboard's appearance.
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:animationDuration];
  
  CGRect frame = self.view.frame;
  frame.origin = contentOffset;
  self.view.frame = frame;
  
  [UIView commitAnimations];
}


- (void)keyboardWillHide:(NSNotification *)notification {  
  if (!self.view) {
    return;
  }

  if (-999 == self.viewContentOffsetBeforeKeyboardIsShown.y) {
    return;
  }

  NSDictionary *userInfo = [notification userInfo];
  
  NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
  NSTimeInterval animationDuration;
  [animationDurationValue getValue:&animationDuration];
  
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:animationDuration];
  
  CGRect frame = self.view.frame;
  frame.origin = self.viewContentOffsetBeforeKeyboardIsShown;
  self.view.frame = frame;
  
  [UIView commitAnimations];
  self.viewContentOffsetBeforeKeyboardIsShown = CGPointMake(0, -999); 
}


@end
