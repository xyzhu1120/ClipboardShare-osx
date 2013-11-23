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

-(int)sendMessage:(Message*)msg
{
    NSData *tmp = msg.toNSData;
    [outputStream write:(uint8_t*)[tmp bytes] maxLength:[tmp length]];
    return 0;
}

-(void)receiveFile
{
    CFReadStreamRef readStream2;
    CFWriteStreamRef writeStream2;
    CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (__bridge CFStringRef)_hosIP, 8884, &readStream2, &writeStream2);
    NSInputStream *inputStream2;
    NSOutputStream *outputStream2;
    inputStream2 = (__bridge_transfer NSInputStream *)readStream2;
    outputStream2 = (__bridge_transfer NSOutputStream *)writeStream2;
    [inputStream2 setDelegate:self];
    [outputStream2 setDelegate:self];
    [inputStream2 scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream2 scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream2 open];
    [outputStream2 open];

}
-(void)stream:(NSStream*)stream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode) {
        case NSStreamEventHasBytesAvailable:{
            NSLog(@"Receive a FILe");
            uint8_t buf[1024];
            unsigned long len = 0;
            while((len = [(NSInputStream *)stream read:buf maxLength:1024])>0){
                NSString *s = [[NSString alloc]initWithBytes:buf length:len encoding:NSUTF8StringEncoding];
                NSLog(s);
            }
        }
        case NSStreamEventEndEncountered:
            [stream close];
            [stream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            //[stream release];
            stream = nil;
            break;
        default:
            break;
    }
}

-(void)dealloc
{
    [inputStream close];
    [outputStream close];
    NSLog(@"Networkservice dealloc");
}
@end
