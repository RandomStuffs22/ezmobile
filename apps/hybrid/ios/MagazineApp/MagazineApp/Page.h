//
//  Page.h
//  MagazineApp
//
//  Created by Łukasz Serwatka on 11-06-28.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Page : NSObject {
    int id;
    NSString *title;
    NSString *URL;
    NSString *content;
}

@property (nonatomic, assign) int id;
@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, copy, readwrite) NSString *URL;
@property (nonatomic, copy, readwrite) NSString *content;

@end
