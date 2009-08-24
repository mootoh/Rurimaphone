//
//  Database.m
//  Rurimaphone
//
//  Created by mootoh on 8/24/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import "Database.h"
#import <sqlite3.h>

@interface Database (Private)
- (NSString *) databasePath;
@end

@implementation Database

- (id) init
{
   if (self = [super init]) {
      NSFileManager *fm = [NSFileManager defaultManager];
      
      // db path
      NSString *doc_dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
      NSString *db_path = [doc_dir stringByAppendingPathComponent:@"rurima.db"];
      
      NSError *error;
      if (! [fm fileExistsAtPath:db_path]) {      
         // The writable database does not exist, so copy the default to the appropriate location.
         // from path
         NSString *from_path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"rurima.db"];
         
         if (! [fm copyItemAtPath:from_path toPath:db_path error:&error])
            [[NSException
              exceptionWithName:@"file exception"
              reason:[NSString stringWithFormat:@"Failed to create writable database file with message '%@', from=%@, to=%@.", [error localizedDescription], from_path, db_path]
              userInfo:nil] raise];
      }
      
      if (SQLITE_OK != sqlite3_open([db_path UTF8String], &handle_))
         [[NSException
           exceptionWithName:@"LocalCacheException"
           reason:[NSString stringWithFormat:@"Failed to open sqlite file: path=%@, msg='%s LINE=%d'", db_path, sqlite3_errmsg(handle_), __LINE__]
           userInfo:nil] raise];
      
   }
   return self;
}

- (void) dealloc
{
   sqlite3_close(handle_);
   [super dealloc];
}

- (NSInteger) classCount
{
   sqlite3_stmt *stmt = nil;
   NSString *sql = @"SELECT count() from class";
   
   if (sqlite3_prepare_v2(handle_, [sql UTF8String], -1, &stmt, NULL) != SQLITE_OK)
      [[NSException
        exceptionWithName:@"DatabaseException"
        reason:[NSString stringWithFormat:@"Failed to prepare statement: msg='%s, LINE=%d'", sqlite3_errmsg(handle_), __LINE__]
        userInfo:nil] raise];
   
   if (sqlite3_step(stmt) != SQLITE_ROW) {
      NSLog(@"something bad happen in select");
      return -1;
   }
   
   NSInteger ret = sqlite3_column_int(stmt, 0);
   sqlite3_finalize(stmt);
   return ret;
}

- (NSArray *) classes
{
   sqlite3_stmt *stmt = nil;
   NSString *sql = @"SELECT name,body from class";
   
   if (sqlite3_prepare_v2(handle_, [sql UTF8String], -1, &stmt, NULL) != SQLITE_OK)
      [[NSException
        exceptionWithName:@"DatabaseException"
        reason:[NSString stringWithFormat:@"Failed to prepare statement: msg='%s, LINE=%d'", sqlite3_errmsg(handle_), __LINE__]
        userInfo:nil] raise];
   
   NSMutableArray *ret = [NSMutableArray array];
   
   while (sqlite3_step(stmt) == SQLITE_ROW) {      
      NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
      NSString *body = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];

      NSArray *keys = [NSArray arrayWithObjects:@"name", @"body", nil];
      NSArray *vals = [NSArray arrayWithObjects:name, body, nil];
      NSDictionary *dict = [NSDictionary dictionaryWithObjects:vals forKeys:keys];
      [ret addObject:dict];
   }

   sqlite3_finalize(stmt);
   return ret;
}

- (NSInteger) methodCount:(NSString *)forClass
{
   sqlite3_stmt *stmt = nil;
   NSString *sql = [NSString stringWithFormat:@"SELECT count() from method where class='%@'", forClass];
   
   if (sqlite3_prepare_v2(handle_, [sql UTF8String], -1, &stmt, NULL) != SQLITE_OK)
      [[NSException
        exceptionWithName:@"DatabaseException"
        reason:[NSString stringWithFormat:@"Failed to prepare statement: msg='%s, LINE=%d'", sqlite3_errmsg(handle_), __LINE__]
        userInfo:nil] raise];
   
   if (sqlite3_step(stmt) != SQLITE_ROW) {
      NSLog(@"something bad happen in select");
      return -1;
   }
   
   NSInteger ret = sqlite3_column_int(stmt, 0);
   sqlite3_finalize(stmt);
   return ret;
}

- (NSArray *) methods:(NSString *)forClass
{
   sqlite3_stmt *stmt = nil;
   NSString *sql = [NSString stringWithFormat:@"SELECT names,body from method where class='%@'", forClass];
   
   if (sqlite3_prepare_v2(handle_, [sql UTF8String], -1, &stmt, NULL) != SQLITE_OK)
      [[NSException
        exceptionWithName:@"DatabaseException"
        reason:[NSString stringWithFormat:@"Failed to prepare statement: msg='%s, LINE=%d'", sqlite3_errmsg(handle_), __LINE__]
        userInfo:nil] raise];
   
   NSMutableArray *ret = [NSMutableArray array];
   
   while (sqlite3_step(stmt) == SQLITE_ROW) {
      NSString *names = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
      NSString *body = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
      
      NSArray *keys = [NSArray arrayWithObjects:@"names", @"body", nil];
      NSArray *vals = [NSArray arrayWithObjects:names, body, nil];
      NSDictionary *dict = [NSDictionary dictionaryWithObjects:vals forKeys:keys];
      [ret addObject:dict];
   }
   
   sqlite3_finalize(stmt);
   return ret;
}

- (NSArray *) queryForClass:(NSString *)forString
{
   sqlite3_stmt *stmt = nil;
   NSString *sql = [NSString stringWithFormat:@"SELECT name,body FROM class WHERE name LIKE '%%%@%%' OR body LIKE '%%%@%%'", forString, forString];
   
   if (sqlite3_prepare_v2(handle_, [sql UTF8String], -1, &stmt, NULL) != SQLITE_OK)
      [[NSException
        exceptionWithName:@"DatabaseException"
        reason:[NSString stringWithFormat:@"Failed to prepare statement: msg='%s, LINE=%d'", sqlite3_errmsg(handle_), __LINE__]
        userInfo:nil] raise];
   
   NSMutableArray *ret = [NSMutableArray array];
   
   while (sqlite3_step(stmt) == SQLITE_ROW) {
      NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
      NSString *body = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
      
      NSArray *keys = [NSArray arrayWithObjects:@"name", @"body", nil];
      NSArray *vals = [NSArray arrayWithObjects:name, body, nil];
      NSDictionary *dict = [NSDictionary dictionaryWithObjects:vals forKeys:keys];
      [ret addObject:dict];
   }
   
   sqlite3_finalize(stmt);
   return ret;
}

- (NSArray *) queryForMethod:(NSString *)forString
{
   sqlite3_stmt *stmt = nil;
   NSString *sql = [NSString stringWithFormat:@"SELECT names,body FROM class WHERE names LIKE '%%%@%%' OR body LIKE '%%%@%%'", forString, forString];
   
   if (sqlite3_prepare_v2(handle_, [sql UTF8String], -1, &stmt, NULL) != SQLITE_OK)
      [[NSException
        exceptionWithName:@"DatabaseException"
        reason:[NSString stringWithFormat:@"Failed to prepare statement: msg='%s, LINE=%d'", sqlite3_errmsg(handle_), __LINE__]
        userInfo:nil] raise];
   
   NSMutableArray *ret = [NSMutableArray array];
   
   while (sqlite3_step(stmt) == SQLITE_ROW) {
      NSString *names = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
      NSString *body = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
      
      NSArray *keys = [NSArray arrayWithObjects:@"names", @"body", nil];
      NSArray *vals = [NSArray arrayWithObjects:names, body, nil];
      NSDictionary *dict = [NSDictionary dictionaryWithObjects:vals forKeys:keys];
      [ret addObject:dict];
   }
   
   sqlite3_finalize(stmt);
   return ret;
}

@end

@implementation Database (Private)

- (NSString *) databasePath
{
   NSString *path = [[NSBundle mainBundle] resourcePath];
   NSLog(@"%@", path);
   return path;
}

@end