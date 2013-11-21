//
//  NetworkService.m
//  ClipboardShare
//
//  Created by xyz on 13-11-21.
//  Copyright (c) 2013年 xyz. All rights reserved.
//

#import "NetworkService.h"

@implementation NetworkService

-(NetworkService*) initWithIP:(NSString *)ip andPort:(int)port anddelegate:(id)del{

    self = [super init];
    if (self != nil) {
        _hosIP = ip;
        _port = port;
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (__bridge CFStringRef)_hosIP, _port, &readStream, &writeStream);
        
        inputStream = (__bridge_transfer NSInputStream *)readStream;
        outputStream = (__bridge_transfer NSOutputStream *)writeStream;
        [inputStream setDelegate:del];
        [outputStream setDelegate:del];
        [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [inputStream open];
        [outputStream open];
    }
    return self;
}


-(void)dealloc
{
    [inputStream close];
    [outputStream close];
    NSLog(@"Networkservice dealloc");
}
@end
