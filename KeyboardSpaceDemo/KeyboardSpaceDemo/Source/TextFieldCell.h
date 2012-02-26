//
//  TextFieldCell.h
//  KeyboardSpaceDemo
//
//  Created by Weipin Xia on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldCell : UITableViewCell {
  UITextField *textField_;
}

@property (nonatomic, retain) IBOutlet UITextField *textField;

@end
