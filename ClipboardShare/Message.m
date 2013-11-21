//
//  Message.m
//  ClipboardShare
//
//  Created by xyz on 13-11-21.
//  Copyright (c) 2013年 xyz. All rights reserved.
//

#import "Message.h"

@implementation Message
-(void)initWithRawData:(NSString*)data{
    NSRange range;
    int pos;
    int oldpos;
    range = [data rangeOfString:@" "];
    pos = range.location;
    _type = [data substringWithRange:NSMakeRange(0, pos)];
    oldpos = pos++;
    //pos = [data chara]
}
@end
