//
//  UtilDataBase.m
//  financieraoh
//
//  Created by Alexis Arroyo Diaz on 24/04/19.
//  Copyright © 2019 Alexis Arroyo Diaz. All rights reserved.
//


#import "UtilDataBase.h"
#import <sqlite3.h>
#define DATABASE_NAME @"bdFinancieraOH_v2.sqlite"

@interface UtilDataBase()

@property(readonly,nonatomic)sqlite3 *base;

@end

@implementation UtilDataBase


-(id)init{
    self = [super init];
    
    if (self){
        [UtilDataBase checkAndCreateDatabase];
    }
    return self;
}


+(void) checkAndCreateDatabase
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dataBasePath = [UtilDataBase getDataBasePath];
    success = [fileManager fileExistsAtPath:dataBasePath];
    if(!success){
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME];
        [fileManager copyItemAtPath:databasePathFromApp toPath:dataBasePath error:nil];
    }
}


+(NSString *)getDataBasePath
{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *rutaPath = [documentsDir stringByAppendingPathComponent:DATABASE_NAME];
    //NSLog(@" UtilDataBase/getDataBasePath/rutaPath = %@ ", rutaPath);
    return rutaPath;
}

+(NSString *)getPath
{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *rutaPath = [documentsDir stringByAppendingPathComponent:@"/"];
    return rutaPath;
}

- (NSArray *)ejecutarSelect:(NSString *)select
{
    NSMutableArray *arrayResult = [[NSMutableArray alloc] init];
    [self openDataBase];
    NSString *sql = select;
    sqlite3_stmt *compiledStatement;
    if (sqlite3_prepare_v2(self.base, [sql UTF8String], -1, &compiledStatement, nil)==SQLITE_OK) {
        while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
            
            int tot = sqlite3_column_count(compiledStatement);
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            for (int i=0; i<tot; i++) {
                NSString *obj = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, i)];
                NSString *key = [NSString stringWithUTF8String:(char *)sqlite3_column_name(compiledStatement, i)];
                [data setObject:obj forKey:key];
            }
            [arrayResult addObject:data];
        }
    }
    [self closeDataBase];
    
    return [arrayResult copy];
}

- (void)ejecutarInsert:(NSString *)insert
{
    [self openDataBase];
    const char *sql = [insert UTF8String];
    sqlite3_stmt *stmt = nil;
    if(sqlite3_prepare_v2(self.base, sql, -1, &stmt, NULL)==SQLITE_OK){
    }
    if (sqlite3_step(stmt)!=SQLITE_DONE) {
        NSLog(@"ERROR: %s", sqlite3_errmsg(self.base));
    }
    [self closeDataBase];
}

- (void)ejecutarDelete:(NSString *)deleteString
{
    [self openDataBase];
    const char *sql = [deleteString UTF8String];
    if (sqlite3_exec(self.base, sql, NULL, NULL, NULL)!=SQLITE_OK) {
        NSLog(@"ERROR: %s", sqlite3_errmsg(self.base));
    }
    [self closeDataBase];
}

- (void)ejecutarUpdate:(NSString *)update
{
    [self openDataBase];
    const char *sql = [update UTF8String];
    sqlite3_stmt *stmt = nil;
    if(sqlite3_prepare_v2(self.base, sql, -1, &stmt, NULL)==SQLITE_OK){
    }
    if (sqlite3_step(stmt)!=SQLITE_DONE) {
        NSLog(@"ERROR: %s", sqlite3_errmsg(self.base));
    }
    [self closeDataBase];
}

#pragma mark - General Methods
-(void)openDataBase{
    NSString *dataBasePath = [UtilDataBase getDataBasePath];
    if(sqlite3_open([dataBasePath UTF8String], &_base) != SQLITE_OK)
    {
        sqlite3_close(self.base);
    }
}

-(void)closeDataBase{
    sqlite3_close(self.base);
}

@end
