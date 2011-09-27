//
//  PageListController.h
//  MagazineApp
//
//  Created by Łukasz Serwatka on 11-06-27.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Page.h"
#import "MainViewController.h"

@interface PageListController : UITableViewController {
    NSMutableArray *datasource;
    UIViewController *parentController;
}

@property (nonatomic, retain) NSMutableArray *datasource;
@property (nonatomic, retain) UIViewController *parentController;

- (void)setupDataSource:(NSMutableArray *)data;

@end
