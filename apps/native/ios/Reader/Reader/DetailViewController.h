//
//  DetailViewController.h
//  Reader
//
//  Created by Łukasz Serwatka on 11-05-02.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "Node.h"

@interface DetailViewController : UIViewController {
    Node *node;
    IBOutlet UIWebView *webView;
    NSMutableData *jsonData;
    NSURLConnection *connectionInProgress;
}

@property (nonatomic, retain) Node *node;

- (id)initWithNode:(Node *)object;
- (void)loadData;

@end
