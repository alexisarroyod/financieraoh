//
//  BaseDatoUtil.m
//  Alianza Lima
//
//  Created by Alexis Arroyo Diaz on 9/06/15.
//  Copyright (c) 2015 Alexis Arroyo Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilDataBase : NSObject

+(NSString *)getDataBasePath;
+(NSString *)getPath;
+(void) checkAndCreateDatabase;

- (NSArray *)ejecutarSelect:(NSString *)select;
- (void)ejecutarInsert:(NSString *)insert;
- (void)ejecutarDelete:(NSString *)deleteString;
- (void)ejecutarUpdate:(NSString *)update;

@end
