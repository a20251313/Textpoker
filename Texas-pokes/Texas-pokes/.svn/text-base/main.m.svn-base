//
//  main.m
//  Texas-pokes
//
//  Created by popo on 12-6-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RJFMainAppDelegate.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>



int main(int argc, char *argv[])
{
    @autoreleasepool
    {
#if DEBUG
        pid_t   ppid = getppid();
        if (ppid == 1)
        {
            NSString  *strFileName = @"log0.txt";
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            strFileName = [documentsDirectory stringByAppendingPathComponent:strFileName];
            
            NSFileManager  *fileManger = [NSFileManager defaultManager];
            BOOL  bHasLogFile = YES;
            int i = 0;
            do {
                if ([fileManger fileExistsAtPath:strFileName])
                {
                    strFileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"log%d.txt",i]];
                    i++;
                }else
                {
                    bHasLogFile = NO;
                }
            } while (bHasLogFile);
            // freopen([strFileName UTF8String],"w",stdout);
            freopen([strFileName UTF8String],"w",stderr);
            
        }
#endif
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([RJFMainAppDelegate class]));
    }
}




