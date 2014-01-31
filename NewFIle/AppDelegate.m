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

     
        //make a file name to write the data to using the documents directory:
        NSString *fileName = [NSString stringWithFormat:@"%@aNewFile.temp",
                              [descriptor stringValue]];
        //create content - four lines of text
        NSString *content = @"";
        //save content to the documents directory
        BOOL success = [content writeToFile:fileName
                atomically:YES
                encoding:NSStringEncodingConversionAllowLossy
                error:nil];
        
       
        // bring finder to the front
        NSAppleScript *script = [[NSAppleScript alloc] initWithSource:
                                 @"tell application \"System Events\" to set frontmost of process \"Finder\" to true"];
        NSDictionary *errors = nil;
        NSAppleEventDescriptor *descriptor = [script executeAndReturnError:&errors];
   
        
        
        
        NSString *script4 =[NSString stringWithFormat:@"tell application \"Finder\" to reveal %@",fileName];
        NSLog(script4);
        // bring finder to the front
        NSAppleScript *script2 = [[NSAppleScript alloc] initWithSource: script4];
        
        NSDictionary *errors2 = nil;
        NSAppleEventDescriptor *descriptor2 = [script2 executeAndReturnError:&errors2];
        
        
        // press enter to start the renaming process
        CGEventRef event;
        event = CGEventCreateKeyboardEvent (NULL, (CGKeyCode)36, true);
        CGEventPost(kCGSessionEventTap, event);
        CFRelease(event);
        
        
        // pointless error check to remove error warning.
        if ((errors != nil) || (descriptor == nil)){}
        
        // terminate the program
        [[NSApplication sharedApplication] terminate:nil];
    }
    
}



@end


