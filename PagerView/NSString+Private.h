//
//  NSString+Private.h
//  BlockExample
//
//  Created by hcc on 15/7/15.
//  Copyright (c) 2015年 pupuwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Private)

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end
