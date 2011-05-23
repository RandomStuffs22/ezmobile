//
//  DetailViewController.m
//  Reader
//
//  Created by Łukasz Serwatka on 11-05-02.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import "DetailViewController.h"


@implementation DetailViewController

@synthesize node;

- (id)initWithNode:(Node *)object
{
    self = [self initWithNibName:@"DetailViewController" bundle:nil];
    if (self) {
        self.node = object;
        self.title = object.name;
    }
    return self;
}

- (void)loadData
{   
    // A URL to the eZ Publish resource
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.example.com/api/ezp/content/node/%i?OutputFormat=xhtml", node.id]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData 
                                         timeoutInterval:30];
    if (connectionInProgress)
    {
        [connectionInProgress cancel];
        [connectionInProgress release];
    }
    
    [jsonData release];
    jsonData = [[NSMutableData alloc] init];
    
    connectionInProgress = [[NSURLConnection alloc] initWithRequest:request 
                                                           delegate:self 
                                                   startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [jsonData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Get JSON string from server response
    NSString *jsonString = [[[NSString alloc] initWithData:jsonData 
                                                  encoding:NSUTF8StringEncoding] autorelease];

    // Load content inside a WebView
    [webView loadHTMLString:[[jsonString JSONValue] objectForKey:@"renderedOutput"] baseURL:nil];
}

- (void)dealloc
{
    [node release];
    [webView release];
    [jsonData release];
    [connectionInProgress release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    
    [webView release];
    webView = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
