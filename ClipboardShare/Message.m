//
//  Message.m
//  ClipboardShare
//
//  Created by xyz on 13-11-21.
//  Copyright (c) 2013年 xyz. All rights reserved.
//

#import "Message.h"

@implementation Message
-(Message *)initWithRawData:(NSString*)data{
    self = [super init];
    if (self != nil) {
        NSRange range;
        unsigned long pos;
        unsigned long oldpos;
        range = [data rangeOfString:@" "];
        pos = range.location;
        _type = [data substringWithRange:NSMakeRange(0, pos)];
        oldpos = ++pos;
        range = [data rangeOfString:@" " options:NULL range:NSMakeRange(pos, [data length] - pos)];
        pos = range.location;
        long len = [[data substringWithRange:NSMakeRange(oldpos, pos - oldpos)] integerValue];
        _content = [data substringWithRange:NSMakeRange(++pos, len)];
    }
    return self;
}

-(Message *)initFileRetMsg{
    self = [super init];
    if (self != nil) {
        _type = @"FILERET";
        _content = @"";
    }
    return self;
}

-(BOOL)isTEXT{
    if ([_type compare:@"TEXT"] == 0) {
        return true;
    } else
        return false;
}

-(BOOL) isFILE
{
    if ([_type compare:@"FILE"] == 0) {
        return true;
    } else
        return false;
}

-(BOOL) isFILEREADY
{
    if ([_type compare:@"FILEREADY"] == 0) {
        return true;
    } else
        return false;
}


-(void)setTextMsgWithContent:(NSString *)content{
    _type = @"TEXT";
    _content = content;
}

-(void)setFileMsgWithAddr:(NSString *)addr{
    _type = @"FILE";
    _content = addr;
}

-(void)setFILERETRIVEMsg{
    _type = @"FILERET";
    _content = @"";
}

-(NSString *)toString{
    return [NSString stringWithFormat:@"%@ %lu %@",_type,(unsigned long)_content.length,_content];
}

-(NSData *)toNSData
{
    return [[NSString stringWithFormat:@"%@ %lu %@",_type,(unsigned long)_content.length,_content]dataUsingEncoding:NSUTF8StringEncoding];
}

-(uint8_t *)toUint{
    NSData *tmp = [[NSString stringWithFormat:@"%@ %lu %@",_type,(unsigned long)_content.length,_content]dataUsingEncoding:NSUTF8StringEncoding];
    return (uint8_t *)[tmp bytes];
}
@end
