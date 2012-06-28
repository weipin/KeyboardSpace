//
//  ContainedTableViewController.h
//  KeyboardSpaceDemo
//
//  Created by Weipin Xia on 6/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StandardBehaviorController;
@interface ContainedTableViewController : UIViewController {
  StandardBehaviorController *tableController_;
}

@property (readonly) StandardBehaviorController *tableController;

@end
