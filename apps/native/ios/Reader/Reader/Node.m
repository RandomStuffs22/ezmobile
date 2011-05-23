//
//  Node.m
//  Reader
//
//  Created by Łukasz Serwatka on 11-05-03.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import "Node.h"


@implementation Node

@synthesize id, name;

- (void)dealloc
{
    [self.name release];
    [super dealloc];
}

@end
