//
//  Page.m
//  MagazineApp
//
//  Created by Łukasz Serwatka on 11-06-28.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import "Page.h"


@implementation Page

@synthesize id, title, URL, content;

- (void)dealloc 
{
	[self.title release];
    [self.URL release];
    [self.content release];
	[super dealloc];
}

@end
