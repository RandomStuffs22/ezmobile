//
//  main.m
//  DemoApp
//
//  Created by Lukasz Serwatka on 11-04-11.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
