//
//  Database.m
//  Rurimaphone
//
//  Created by mootoh on 8/24/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import "Database.h"

@implementation Database

- (id) init
{
   if (self = [super init]) {
      [self readClasses];
      [self readMethods];
   }
   return self;
}

- (void) dealloc
{
}

- (void) readClasses
{
}

- (void) readMethods
{
}

@end
