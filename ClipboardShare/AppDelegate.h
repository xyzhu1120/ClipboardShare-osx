//
//  AppDelegate.h
//  ClipboardShare
//
//  Created by xyz on 13-11-21.
//  Copyright (c) 2013年 xyz. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NetworkService.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    NetworkService *ns;
    NSPasteboard *whichPboard;
}

@property (assign) IBOutlet NSWindow *window;

@end
