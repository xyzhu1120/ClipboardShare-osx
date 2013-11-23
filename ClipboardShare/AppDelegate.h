//
//  AppDelegate.h
//  ClipboardShare
//
//  Created by xyz on 13-11-21.
//  Copyright (c) 2013年 xyz. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NetworkService.h"
#import "Message.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    NetworkService *_ns;
    NSPasteboard *whichPboard;
}
- (IBAction)getFile:(id)sender;

@property (assign) IBOutlet NSWindow *window;

@end
