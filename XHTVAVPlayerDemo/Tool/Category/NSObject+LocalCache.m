
//  NSObject+LocalCache.m
//  NewClient
//
//  Created by 郑昊鸣 on 16/6/8.
//  Copyright © 2016年 com.xinhuashixun. All rights reserved.
//

#import "NSObject+LocalCache.h"

@implementation NSObject (LocalCache)
// 数组存到本地文件文件
+ (void)localCacheWithArray:(NSArray *)dataArray fileName:(NSString *)fileName {
    fileName = [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"#"];
    NSString *filePath = [[self getCachePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zz",fileName]];
    [NSKeyedArchiver archiveRootObject:dataArray toFile:filePath];
}

// 字典存到本地文件
+ (void)localCacheWithDictionary:(NSDictionary *)dict fileName:(NSString *)fileName {
    fileName = [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"#"];
    NSString *filePath = [[self getCachePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zz",fileName]];
    [NSKeyedArchiver archiveRootObject:dict toFile:filePath];
}

// 存到本地文件
+ (void)localCacheWithResponse:(id )response fileName:(NSString *)fileName {
    fileName = [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"#"];
    NSString *filePath = [[self getCachePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zz",fileName]];
    [NSKeyedArchiver archiveRootObject:response toFile:filePath];
}

// 数据存到本地文件
+ (void)localCacheWithData:(id)data fileName:(NSString *)fileName {
    if ([data isKindOfClass:[NSArray class]] || [data isKindOfClass:[NSDictionary class]]) {
        fileName = [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"#"];
        NSString *filePath = [[self getCachePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zz",fileName]];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        [fileManager removeItemAtPath:filePath error:&error];
        [NSKeyedArchiver archiveRootObject:data toFile:filePath];
    }
}

// 读取缓存
+ (id)readLocalCacheWithFileName:(NSString *)fileName {
    fileName = [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"#"];
    NSString *filePath = [[self getCachePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zz",fileName]];
    id result = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return result;
}

// 获取缓存路径
- (NSString *)getCachePath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (void)deleteLocalCacheWithFileName:(NSString *)fileName {
    fileName = [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"#"];
    NSString *filePath = [[self getCachePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zz",fileName]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    [fileManager removeItemAtPath:filePath error:&error];
}
@end
