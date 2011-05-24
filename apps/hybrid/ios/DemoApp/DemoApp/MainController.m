//
//  MainController.m
//  DemoApp
//
//  Created by Lukasz Serwatka on 11-04-11.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import "MainController.h"


@implementation MainController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Create a URL object
    NSURL *url = [NSURL URLWithString:@"www.example.com"];
    
    // Create a Request object
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    [webView release];
    webView = nil;
}

- (void)dealloc
{
    [webView release];
    [super dealloc];
}

@end
