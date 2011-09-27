//
//  PageRepository.h
//  MagazineApp
//
//  Created by Łukasz Serwatka on 11-06-27.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Page.h"

@interface PageRepository : NSObject {
@private
	NSString *databaseFilePath;
}

@property (nonatomic, retain) NSString *databaseFilePath;

- (void)storeNewPageWith:(NSString *)title URL:(NSString *)url content:(NSString *)content;
- (NSMutableArray *)getStoredPages;
- (NSMutableArray *)translateToObjects:(sqlite3_stmt *)statement;

@end
