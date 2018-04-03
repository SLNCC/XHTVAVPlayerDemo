//
//  NSObject+LocalCache.h
//  NewClient
//
//  Created by 郑昊鸣 on 16/6/8.
//  Copyright © 2016年 com.xinhuashixun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LocalCache)
// 数组存到本地文件文件
+ (void)localCacheWithArray:(NSArray *)dataArray fileName:(NSString *)fileName;

// 字典存到本地文件
+ (void)localCacheWithDictionary:(NSDictionary *)dict fileName:(NSString *)fileName;
// 存到本地文件
+ (void)localCacheWithResponse:(id )response fileName:(NSString *)fileName;

// 数据存到本地文件
+ (void)localCacheWithData:(id)data fileName:(NSString *)fileName;

// 读取缓存
+ (id)readLocalCacheWithFileName:(NSString *)fileName;

// 删除缓存
+ (void)deleteLocalCacheWithFileName:(NSString *)fileName;
@end
