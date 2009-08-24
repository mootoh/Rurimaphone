//
//  Database.h
//  Rurimaphone
//
//  Created by mootoh on 8/24/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sqlite3.h>

@interface Database : NSObject
{
   sqlite3  *handle_;
}

- (NSInteger) classCount;
- (NSArray *) classes;

- (NSInteger) methodCount:(NSString *)forClass;
- (NSArray *) methods:(NSString *)forClass;

@end