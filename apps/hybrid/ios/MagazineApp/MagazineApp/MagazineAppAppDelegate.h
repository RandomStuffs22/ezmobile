//
//  MagazineAppAppDelegate.h
//  MagazineApp
//
//  Created by Łukasz Serwatka on 11-06-27.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface MagazineAppAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (void)createEditableCopyOfDatabaseIfNeeded;

@end
