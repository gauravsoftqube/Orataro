//
//  DBOperation.h
//  Example
//
//  Created by Softqube on 01/09/16.
//  Copyright © 2016 Softqube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBOperation : NSObject
{
}

+(void)OpenDatabase:(NSString*)path;  //Open the Database
//+(void)finalizeStatements;//Closing and do the final statement at application exits
+(void)checkCreateDB;
//+(int) getLastInsertId;
+(BOOL) executeSQL:(NSString *)sqlTmp;
+(NSMutableArray*) selectData:(NSString *)sql;


@end
