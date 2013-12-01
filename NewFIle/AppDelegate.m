//
//  AppDelegate.m
//  NewFIle
//
//  Created by Calum on 01/12/2013.
//  Copyright (c) 2013 Calum. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate





- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:
                             @"tell application \"Finder\"\n"
                             "  return POSIX path of (target of window 1 as alias)\n"
                             "end tell"];
    NSDictionary *errors = nil;
    NSAppleEventDescriptor *descriptor = [script executeAndReturnError:&errors];
    
    if ((errors != nil) || (descriptor == nil)) {
        // There is no opened window or an error occured
    } else {
        // what was retrieved by the script
        NSLog([descriptor stringValue]);
     
        //make a file name to write the data to using the documents directory:
        NSString *fileName = [NSString stringWithFormat:@"%@/aNewFile",
                              [descriptor stringValue]];
        //create content - four lines of text
        NSString *content = @"";
        //save content to the documents directory
        [content writeToFile:fileName
                  atomically:NO
                    encoding:NSStringEncodingConversionAllowLossy
                       error:nil];
       
        
        NSAppleScript *script = [[NSAppleScript alloc] initWithSource:
                                 @"tell application \"System Events\" to set frontmost of process \"Finder\" to true"];
        NSDictionary *errors = nil;
        NSAppleEventDescriptor *descriptor = [script executeAndReturnError:&errors];
        NSLog([descriptor stringValue]);
        [[NSApplication sharedApplication] terminate:nil];
    }
    
}



@end


