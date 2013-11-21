//
//  NetworkService.h
//  ClipboardShare
//
//  Created by xyz on 13-11-21.
//  Copyright (c) 2013年 xyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkService : NSObject{
    NSString *_hosIP;
    int _port;
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
}

-(NetworkService*) initWithIP:(NSString *)ip andPort:(int)port anddelegate:(id)del;

@end
