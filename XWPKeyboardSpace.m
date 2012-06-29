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

@property (readwrite, assign) CGPoint viewContentOffsetBeforeKeyboardIsShown;

@end


@implementation XWPKeyboardSpace

@synthesize delegate = delegate_;
@dynamic view;

@synthesize viewContentOffsetBeforeKeyboardIsShown = viewContentOffsetBeforeKeyboardIsShown_;

GTMOBJECT_SINGLETON_BOILERPLATE(XWPKeyboardSpace, sharedInstance)

- (id)init {
  if (self = [super init]) {
    self.viewContentOffsetBeforeKeyboardIsShown = CGPointMake(0, -999);
    
  }
  
  return self;
}

- (void)dealloc {
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
  
  if (view) {
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    BOOL available = (&UIKeyboardWillChangeFrameNotification != NULL);
    if (available) {
      [[NSNotificationCenter defaultCenter] addObserver:self 
                                               selector:@selector(keyboardWillChangeFrame:)
                                                   name:UIKeyboardWillChangeFrameNotification
                                                 object:nil];  
    }  
    
  } else {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
        
  }
}

- (void)attachToView:(UIView *)view withDelegate:(id<XWPKeyboardSpaceDelegate>)delegate {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  
  self.view = view;
  self.delegate = delegate;
}

- (void)attachToView:(UIView *)view {
  [self attachToView:view withDelegate:nil];
}

- (void)detachFromView {
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
  CGRect keyboardFrame = [self.view convertRect:keyboardRect fromView:nil];
  
  // Get the duration of the animation.
  NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
  NSTimeInterval animationDuration;
  [animationDurationValue getValue:&animationDuration];

  UIView *theView = [self.view xwp_firstResponder];
  if (!theView) {
    return;
  }
  
  if (self.delegate && ![self.delegate keyboardSpace:self shouldLayoutFirstResponder:theView]) {
    return;
  }
  
  CGRect theViewFrame = [self.view convertRect:theView.bounds fromView:theView];
  if (CGRectGetMaxY(theViewFrame) < CGRectGetMinY(keyboardFrame)) {
    return;
  }
  
  self.viewContentOffsetBeforeKeyboardIsShown = self.view.frame.origin;
  
  CGFloat offset = CGRectGetMaxY(theViewFrame) - CGRectGetMinY(keyboardFrame);
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

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
  if (!self.view) {
    return;
  }
  
  if (!self.view.window) {
    return;
  }
  
  CGRect windowRect = self.view.window.frame;
  CGRect windowFrame = [self.view convertRect:windowRect fromView:nil];
  
  NSDictionary *userInfo = [notification userInfo];
  
  NSValue* value = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];  
  CGRect beginKeyboardRect = [value CGRectValue];
  CGRect beginKeyboardFrame = [self.view convertRect:beginKeyboardRect fromView:nil];
  
  value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];  
  CGRect endKeyboardRect = [value CGRectValue];
  CGRect endKeyboardFrame = [self.view convertRect:endKeyboardRect fromView:nil];
  
  // ignore keyboard show/hide frame changes
  if (!CGRectIntersectsRect(windowFrame, beginKeyboardFrame)
      || !CGRectIntersectsRect(windowFrame, endKeyboardFrame)) {
    return;
  }
  
  // Get the duration of the animation.
  NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
  NSTimeInterval animationDuration;
  [animationDurationValue getValue:&animationDuration];
  
  UIView *theView = [self.view xwp_firstResponder];
  if (!theView) {
    return;
  }
  
  CGRect theViewFrame = theView.frame;
  CGFloat offset = CGRectGetMaxY(theViewFrame) - CGRectGetMinY(endKeyboardFrame);
  
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

@end
