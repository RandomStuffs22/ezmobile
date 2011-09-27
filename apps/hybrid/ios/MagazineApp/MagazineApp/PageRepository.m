//
//  PageRepository.m
//  MagazineApp
//
//  Created by Łukasz Serwatka on 11-06-27.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import "PageRepository.h"


@implementation PageRepository

@synthesize databaseFilePath;

- (id)init
{
	if((self = [super init]))
	{
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		self.databaseFilePath = [documentsDirectory stringByAppendingPathComponent:@"magazine.db"];
	}
	
	return self;
}

- (NSMutableArray *)getStoredPages
{
    NSMutableArray *pages;
    
    sqlite3 *database;

	if(sqlite3_open([self.databaseFilePath UTF8String],&database) == SQLITE_OK)
	{
		const char *sql = "SELECT * FROM Page";

  		sqlite3_stmt *statement;

		int returnValue = sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK;

        if (returnValue != SQLITE_OK)
            NSLog(@"Error: failed to prepare sql statement for method '%@' with message: '%s'.", @"getStoredPages", sqlite3_errmsg(database));
		else
			pages = [self translateToObjects:statement];

		sqlite3_finalize(statement);
	}

	sqlite3_close(database);

    return pages;
}

- (void)storeNewPageWith:(NSString *)title URL:(NSString *)url content:(NSString *)content
{
    sqlite3 *database;
	
	if(sqlite3_open([self.databaseFilePath UTF8String],&database) == SQLITE_OK)
	{
        // Begins Transaction.
		sqlite3_exec(database, "BEGIN", 0, 0, 0);
        
		sqlite3_stmt *statement;
        
        const char *sql = "INSERT INTO Page(Title, URL, Content) VALUES(?, ?, ?)";
		
		if(sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK)
			NSLog(@"Error: failed to prepare sql statement for method '%@' with message: '%s'.", @"storeNewPageWith", sqlite3_errmsg(database));
		
        sqlite3_bind_text(statement, 1, [title UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [url UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [content UTF8String], -1, SQLITE_TRANSIENT);
		
		if(SQLITE_DONE != sqlite3_step(statement))
			NSLog(@"Error: failed to execute query with message: '%s'.", sqlite3_errmsg(database));
        
		sqlite3_finalize(statement);
        
        // Commits transaction.
		sqlite3_exec(database, "COMMIT", 0, 0, 0);
	}
	
	sqlite3_close(database);
}

- (NSMutableArray *)translateToObjects:(sqlite3_stmt *)statement
{
	NSMutableArray *result = [[[NSMutableArray alloc] init] autorelease];
	
	while (sqlite3_step(statement) == SQLITE_ROW) 
	{
        Page *page = [[Page alloc] init];
        
		page.id = sqlite3_column_int(statement, 0);		
        page.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
		page.URL = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
		page.content = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
		
		[result addObject:page];
		
		[page release];
	}
	
	return result;
}

- (void)dealloc 
{
	[self.databaseFilePath release];
	[super dealloc];
}

@end
