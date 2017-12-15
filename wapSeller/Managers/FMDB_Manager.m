//
//  FMDB_Manager.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/4.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "FMDB_Manager.h"
#import <FMDB.h>

@interface FMDB_Manager ()
@property(nonatomic,strong)FMDatabase *db;
@end

@implementation FMDB_Manager
+ (instancetype)defaultManager{
    static FMDB_Manager *fmdb_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmdb_manager = [[FMDB_Manager alloc] init];
    });
    return fmdb_manager;
}

- (void)open{
    //open
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"activitylist.db"];
    self.db = [FMDatabase databaseWithPath:dbPath];
    //creat table
    if ([self.db open]) {
        BOOL res = [self.db executeUpdate:@"CREATE TABLE activitylist_table(activityName text,onlineStatus text,buyerBackRate text,activityStartDate text,activityEndDate text,orderPrices text,shopReceive text,orderRebatePrices text)"];
        if (res) {
            //successfull
            //NSLog(@"creat table successful");
        }else{
            //NSLog(@"creat table failed");
        }
    }
}



- (void)addData:(NSDictionary *)activityDic{
    NSString *activityName = [NSString stringWithFormat:@"%@",activityDic[@"activityName"]];
    NSString *onlineStatus = [NSString stringWithFormat:@"%@",activityDic[@"onlineStatus"]];
    NSString *buyerBackRate = [NSString stringWithFormat:@"%@",activityDic[@"buyerBackRate"]];
    NSString *activityStartDate = [NSString stringWithFormat:@"%@",activityDic[@"activityStartDate"]];
    NSString *activityEndDate   = [NSString stringWithFormat:@"%@",activityDic[@"activityEndDate"]];
    NSString *orderPrices = [NSString stringWithFormat:@"%@",activityDic[@"orderPrices"]];
    NSString *shopReceive = [NSString stringWithFormat:@"%@",activityDic[@"shopReceive"]];//shopReceive  financialReceive
    
    NSString *orderRebatePrices = [NSString stringWithFormat:@"%@",activityDic[@"orderRebatePrices"]];
    
    //insert
    if ([self.db open]) {
        BOOL res = [self.db executeUpdate:@"INSERT INTO activitylist_table(activityName,onlineStatus,buyerBackRate,activityStartDate,activityEndDate,orderPrices,shopReceive,orderRebatePrices) VALUES (?,?,?,?,?,?,?,?)",activityName,onlineStatus,buyerBackRate,activityStartDate,activityEndDate,orderPrices,shopReceive,orderRebatePrices];
        if (res) {
            //NSLog(@"insert successful");
        }else{
            //NSLog(@"insert failed");
        }
    }
}


- (void)close{
    [self.db close];
}

- (void)clear{
    if ([self.db open]) {
        NSString *deleteData = [NSString stringWithFormat:@"delete from activitylist_table"];
        BOOL success = [self.db executeUpdate:deleteData];
        if (success) {
            NSLog(@"delegate successful");
        }else{
            NSLog(@"delegate failed");
        }
    }
}

//search
- (NSMutableArray *)searchData{
    if ([self.db open]) {
        NSString *sql     = [NSString stringWithFormat:@"SELECT * FROM activitylist_table"];
        FMResultSet *rset = [self.db executeQuery:sql];
        NSMutableArray *mutableArray = [NSMutableArray array];
        while ([rset next]) {
            NSDictionary *dic = [NSDictionary dictionary];
            NSString *activityName = [rset stringForColumn:@"activityName"];
            NSString *onlineStatus = [rset stringForColumn:@"onlineStatus"];
            NSString *buyerBackRate = [rset stringForColumn:@"buyerBackRate"];
            NSString *activityStartDate = [rset stringForColumn:@"activityStartDate"];
            NSString *activityEndDate = [rset stringForColumn:@"activityEndDate"];
            NSString *orderPrices = [rset stringForColumn:@"orderPrices"];
            NSString *shopReceive = [rset stringForColumn:@"shopReceive"];
            
            NSString *orderRebatePrices = [rset stringForColumn:@"orderRebatePrices"];
            
            dic = @{@"activityName":activityName,@"onlineStatus":onlineStatus,@"buyerBackRate":buyerBackRate,@"activityStartDate":activityStartDate,@"activityEndDate":activityEndDate,@"orderPrices":orderPrices,@"shopReceive":shopReceive,@"orderRebatePrices":orderRebatePrices};
            [mutableArray addObject:dic];
        }
        //NSLog(@"mutableArray --- %@",mutableArray);
        return mutableArray;
    }
    return nil;
}



@end
