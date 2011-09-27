//
//  MainViewController.h
//  MagazineApp
//
//  Created by Łukasz Serwatka on 11-06-27.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIWebPageRequest.h"
#import "ASIDownloadCache.h"
#import "PageRepository.h"
#import "PageListController.h"

@interface MainViewController : UIViewController <UIPopoverControllerDelegate> {
    IBOutlet UIWebView *webView;
    ASIWebPageRequest *webPageRequest;
    UIPopoverController *pagesPopoverController;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) ASIWebPageRequest *webPageRequest;
@property (nonatomic, retain) UIPopoverController *pagesPopoverController;

- (IBAction)storeCurrentPage:(id)sender;
- (IBAction)listSavedPages:(id)sender;
- (void)loadPage:(Page *)page;

@end
