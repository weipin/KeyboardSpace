//
//  TextViewCell.h
//  KeyboardSpaceDemo
//
//  Created by Weipin Xia on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewCell : UITableViewCell {
  UITextView *textView_;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;

@end
