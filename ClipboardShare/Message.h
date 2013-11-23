//
//  Message.h
//  ClipboardShare
//
//  Created by xyz on 13-11-21.
//  Copyright (c) 2013年 xyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject{
    NSString *_type;
    NSString *_content;
}

-(Message *)initWithRawData:(NSString*)data;
-(Message *)initFileRetMsg;
-(BOOL) isTEXT;
-(BOOL) isFILE;
-(BOOL) isFILEREADY;
-(NSString *)toString;
-(uint8_t *)toUint8;
//-(int) length;
-(NSData*)toNSData;
@end
