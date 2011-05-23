//
//  Node.h
//  Reader
//
//  Created by Łukasz Serwatka on 11-05-03.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Node : NSObject {
    int id;
    NSString *name;
}

@property (nonatomic, assign) int id;
@property (nonatomic, retain) NSString *name;

@end
