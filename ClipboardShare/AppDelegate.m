//
//  AppDelegate.m
//  ClipboardShare
//
//  Created by xyz on 13-11-21.
//  Copyright (c) 2013年 xyz. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    _ns = [[NetworkService alloc]initWithIP:@"218.193.187.165" andPort:8885 anddelegate:self];
    whichPboard = [NSPasteboard generalPasteboard];
}

-(void)stream:(NSStream*)stream handleEvent:(NSStreamEvent)eventCode{
    switch (eventCode) {
        case NSStreamEventHasBytesAvailable:{
            NSLog(@"Receive packet");
            //NSMutableData *data = [[NSMutableData alloc]init];
            uint8_t buf[1024];
            unsigned int len = 0;
            len = [(NSInputStream *)stream read:buf maxLength:1024];
            NSString *s = [[NSString alloc]initWithBytes:buf length:len encoding:NSUTF8StringEncoding];
            Message *tmpmsg = [[Message alloc]initWithRawData:s];
            if (tmpmsg.isTEXT) {
                [whichPboard clearContents];
                [whichPboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
                [whichPboard setString:s forType:NSStringPboardType];
            } else if(tmpmsg.isFILE){
                //NSAlert *alert = [NSAlert alertWithMessageText:@"FIile" defaultButton:@"Get it" alternateButton:@"Ignore" otherButton:nil informativeTextWithFormat:@"Nothing"];
                //[alert beginSheetModalForWindow:[self window] modalDelegate:self didEndSelector:@selector(alertEnded:code:context:) contextInfo:nil];
                
                //NSRunAlertPanel(@"a FILE", @"FILE", @"Get it", @"ignore", nil);
                NSUserNotification *notification = [[NSUserNotification alloc]init];
                
                notification.title = @"File";
                notification.informativeText = @"FILE";
                notification.soundName = NSUserNotificationDefaultSoundName;
                
                notification.hasActionButton = YES;
                notification.actionButtonTitle = @"OK";
                notification.otherButtonTitle = @"Cancel";
                
                [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
                [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
            } else if ( [tmpmsg isFILEREADY] ){
                [_ns receiveFile];
            }
            NSLog(s);

            break;
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

-(void) alertEnded:(NSAlert *)alert code:(int)choice context:(void *)v{
    NSLog(@"Receive");
}

-(void) userNotificationCenter:(NSUserNotificationCenter *)cneter didActivateNotification:(NSUserNotification *)notification{
    NSLog(@"click");
    [_window makeKeyAndOrderFront:self];
}

- (IBAction)getFile:(id)sender {
    NSLog(@"try to retrive the file");
    Message *msg = [[Message alloc]initFileRetMsg];
    [_ns sendMessage:msg];
    
}
@end
