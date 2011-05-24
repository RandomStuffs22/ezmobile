//
//  MainController.h
//  DemoApp
//
//  Created by Lukasz Serwatka on 11-04-11.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainController : UIViewController <UIWebViewDelegate> {
    IBOutlet UIWebView *webView;
}

@end
