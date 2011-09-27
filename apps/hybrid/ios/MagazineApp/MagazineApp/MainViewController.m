//
//  MainViewController.m
//  MagazineApp
//
//  Created by Łukasz Serwatka on 11-06-27.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import "MainViewController.h"


@implementation MainViewController

@synthesize webView, webPageRequest, pagesPopoverController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)storeCurrentPage:(id)sender
{
    [self.webPageRequest setDelegate:nil];
    [self.webPageRequest cancel];
    
    self.webPageRequest = [ASIWebPageRequest requestWithURL:[NSURL URLWithString:self.webView.request.URL.absoluteString]];
    [self.webPageRequest setDelegate:self];
    [self.webPageRequest setDidFailSelector:@selector(webPageFetchFailed:)];
    [self.webPageRequest setDidFinishSelector:@selector(webPageFetchSucceeded:)];

    [self.webPageRequest setUrlReplacementMode:ASIReplaceExternalResourcesWithData];
    
    [self.webPageRequest setDownloadCache:[ASIDownloadCache sharedCache]];
    
    [self.webPageRequest setDownloadDestinationPath:[[ASIDownloadCache sharedCache] 
            pathToStoreCachedResponseDataForRequest:self.webPageRequest]];
    
    [self.webPageRequest startAsynchronous];
}

- (IBAction)listSavedPages:(id)sender
{
    PageRepository *pageRepository = [[PageRepository alloc] init];
    PageListController *pageListController = [[PageListController alloc] initWithStyle:UITableViewStylePlain];
    pageListController.parentController = self;
    
    self.pagesPopoverController = [[UIPopoverController alloc] initWithContentViewController:pageListController];               
    self.pagesPopoverController.delegate = self;
    
    CGRect sectionsButtonsRect = CGRectMake(0,0,0,0);
    
    [self.pagesPopoverController presentPopoverFromRect:sectionsButtonsRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    [pageListController setupDataSource:[pageRepository getStoredPages]];
    
    [pageListController release];
    [pageRepository release];
}

- (void)webPageFetchFailed:(ASIHTTPRequest *)request
{
    NSLog(@"%@",[request error]);
}

- (void)webPageFetchSucceeded:(ASIHTTPRequest *)request
{
    NSString *content = [NSString stringWithContentsOfFile:
                          [request downloadDestinationPath] encoding:[request responseEncoding] error:nil];
    
    // Save in the database
    
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSString *URL = self.webView.request.URL.absoluteString;
    
    PageRepository *pageRepository = [[PageRepository alloc] init];
    [pageRepository storeNewPageWith:title URL:URL content:content];
    [pageRepository release];
    
    UIAlertView *popupAlert = [[UIAlertView alloc] initWithTitle:@"Success"
														 message:[NSString stringWithFormat:@"Page '%@' was saved successfully", title]
														delegate:nil 
											   cancelButtonTitle:@"Done"
											   otherButtonTitles:nil];
	[popupAlert show];
	[popupAlert release];
}

- (void)loadPage:(Page *)page
{
    [self.webView loadHTMLString:page.content baseURL:[NSURL URLWithString:page.URL]];
}

- (void)dealloc
{
    [self.webView release];
    [self.webPageRequest release];
    [self.pagesPopoverController release];
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
    
    //Create a URL object.
	NSURL *url = [NSURL URLWithString:@"http://www.example.com"];
	
	//URL Requst Object
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
	[self.webView loadRequest:requestObj];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
