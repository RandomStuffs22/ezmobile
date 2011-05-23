//
//  JSONTableViewController.h
//  Reader
//
//  Created by Łukasz Serwatka on 11-05-02.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "Node.h"
#import "DetailViewController.h"

@interface JSONTableViewController : UITableViewController {
    NSMutableArray *nodes;
    NSMutableData *jsonData;
    NSURLConnection *connectionInProgress;
}

- (void)loadData;

@end
