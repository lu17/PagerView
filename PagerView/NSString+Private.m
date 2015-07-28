//
//  NSString+Private.m
//  BlockExample
//
//  Created by hcc on 15/7/15.
//  Copyright (c) 2015年 pupuwang. All rights reserved.
//

#import "NSString+Private.h"

@implementation NSString (Private)


- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize textSize;
    //NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0) {
        
        if (CGSizeEqualToSize(size, CGSizeZero)) {
            
            textSize =  [self sizeWithAttributes:@{NSFontAttributeName:font}];
        }
        else{
            
            NSStringDrawingOptions option = NSStringDrawingUsesLineFragmentOrigin;
            //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（译者注：字体大小+行间距=行高）
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
            CGRect rect = [self boundingRectWithSize:size
                                             options:option
                                          attributes:attributes
                                             context:nil];
            textSize = rect.size;
        }
        
    }
    else{
        
        if (CGSizeEqualToSize(size, CGSizeZero)) {
            
            textSize =[self sizeWithFont:font];
        }
        else{
            
            textSize =[self  sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
        }
    }
    return textSize;
}

@end
