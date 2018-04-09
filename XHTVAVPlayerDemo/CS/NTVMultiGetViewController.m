//
//  NTVMultiGetViewController.m
//  XHTVAVPlayerDemo
//
//  Created by 乔冬 on 2018/4/8.
//  Copyright © 2018年 XinHuaTV. All rights reserved.
//

#import "NTVMultiGetViewController.h"

@interface NTVAPP:NSObject
/** APP的名称 */
@property (nonatomic, strong) NSString *name;
/** APP的图片的url地址 */
@property (nonatomic, strong) NSString *icon;
/** APP的下载量 */
@property (nonatomic, strong) NSString *download;

+(instancetype)appWithDict:(NSDictionary *)dict;

@end


@implementation NTVAPP
+ (instancetype)appWithDict:(NSDictionary *)dict{
    NTVAPP *app = [[NTVAPP alloc]init];
    [app setValuesForKeysWithDictionary:dict];
    return app;
}
@end


@interface NTVMultiGetViewController ()<UITableViewDelegate,UITableViewDataSource>
/*TableView的数据源*/
@property (nonatomic,strong) NSArray *apps;
/*内存缓存*/
@property (nonatomic,strong) NSMutableDictionary *images;
/*列队*/
@property (nonatomic,strong) NSOperationQueue *queue;
/*操作缓存*/
@property (nonatomic,strong) NSMutableDictionary *operations;

@property (nonatomic,strong) UITableView *ntvBaseTableView;

@end

@implementation NTVMultiGetViewController
#pragma mark -- lazy

-(NSArray *)apps{
    if (_apps == nil) {
        
        NSArray *tempArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"apps" ofType:@".plist"]];
        //字典转模型Model
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in tempArray) {
            NTVAPP *app = [NTVAPP appWithDict:dict];
            [tempArr addObject:app];
            
        }
        _apps = tempArr.copy;
    }
    return _apps;
}
-(NSMutableDictionary *)images{
    if (!_images) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
}
-(NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc]init];
        //最大的并发数
        _queue.maxConcurrentOperationCount  = 5;
    }
    return _queue;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.ntvBaseTableView .frame = self.view.bounds;
    [self.view addSubview:self.ntvBaseTableView];
    [self.ntvBaseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"downloadcell"];
}
#pragma mark -- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.apps.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadcell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"downloadcell"];
    }
    NTVAPP *app = self.apps[indexPath.row];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.download;
    //设置图标
    //先去查看内幕才能缓存中该图片是否已经存在，如果存在，那么直接拿来用，否则去检查磁盘缓存
    //如果有磁盘缓存，那么保存一份到内存，设置图片，否则就直接下载
        //       1.没有下载过 2.重新打开程序
    cell.imageView.image = [UIImage imageNamed:@"icon_player_refresh"];
    //1.检查缓存是否有
    UIImage *image = [self.images objectForKey:app.icon];
    
    if (image) {
            cell.imageView.image = image;
            NSLog(@"%zd处使用内存了缓存中的图片",
                     indexPath.row);
    }else{
             //2.磁盘的情况
                //保存图片到沙盒缓存
                NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory , NSUserDomainMask , YES) lastObject];
                //获取图片的名称不能包括/
                NSString *fileName = [app.icon lastPathComponent];
                //拼接图片的全路径
                NSString *fullPath = [cache stringByAppendingString:fileName];
        
                //检查磁盘缓存
                NSData *imgeData = [NSData dataWithContentsOfFile:fullPath];
                //废除
                imgeData = nil;
                if (imgeData) {
                    UIImage *image = [UIImage imageWithData:imgeData];
                    cell.imageView.image = image;
                    NSLog(@"%zd处使用磁盘缓存中的图片",
                          indexPath.row);
                    //图片保存到内存缓存中
                    [self.images setObject:image forKey:app.icon];
                }else{
                    //检查图片是否正在下载，如果是存在这样的下载操作，那就不用添加了，否则添加下载任务
                    NSBlockOperation *download = [self.operations objectForKey:app.icon];
                    if(download){
                        
                    }else{
                        //清空cell原来的图片
                        cell.imageView.image = [UIImage imageNamed:@"icon_player_refresh"];
                        download = [NSBlockOperation blockOperationWithBlock:^{
                            NSURL *url = [NSURL URLWithString:app.icon];
                            NSData *data = [NSData dataWithContentsOfURL:url];
                            UIImage *image = [UIImage imageWithData:data];
                            NSLog(@"%zd",indexPath.row);
                            
                            //容错处理
                            if (image == nil) {
                                [self.images removeObjectForKey:app.icon];
                                return ;
                            }
                            NSLog(@"download---%@",[NSThread mainThread]);
                            //图片保存到内存中
                            [self.images setObject:image forKey:app.icon];
                            //线程通信
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                                cell.imageView.image = image;
                                NSLog(@"UI---%@",[NSThread mainThread]);
                                [self.ntvBaseTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                            }];
                            //写数据到沙盒
                            [imgeData writeToFile:fullPath atomically:YES];
                            //移除下载图片任务操作
                            [self.operations removeObjectForKey:app.icon];
                            
                        }];
                        //添加操作到缓存操作中
                        [self.operations setObject:download forKey:app.icon];
                        //添加操作到操作队列中
                        [self.queue addOperation:download];
                    }
                }
    }

    

    
    return cell;
}
#pragma mark -- UITableViewDelegate
//选中cell的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


#pragma mark -- lazy
-(UITableView *)ntvBaseTableView{
    if (_ntvBaseTableView == nil) {
        _ntvBaseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
//        _ntvBaseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ntvBaseTableView.delegate = self;
        _ntvBaseTableView.dataSource = self;
    }
    return _ntvBaseTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.images removeAllObjects];
    //取消队列的所有的操作
    [self.queue cancelAllOperations];
}
/*
 涉及到的知识点
        01 字典转模型
        02 存储数据到沙盒，从沙盒中加载数据
        03 占位图片的设置（cell的刷新问题）
        04 如何进行内存缓存（使用NSDictionary）
        05 在程序开发过程中的一些容错处理
        06 如何刷新tableView的指定行（解决数据错乱问题）
        07 NSOperation以及线程间通信相关知识
 */
/*
 出现的问题
    1. UI很不流畅--------> 开子线程下载图片
    2. 图片重复从网络中下载 --------> 把下载过的图片保存起来
    3. 图片不会自动刷新
    4. 当网络延迟时,图片又会重复下载
    5. 数据错乱现象.
    首先不考虑上面出现的问题,先把上面的效果图做好.然后再根据上面问题逐一解决.
 */
/*
    1.UI很不流畅 --- > 开子线程下载图片
    2.图片重复下载 ---> 先把之前已经下载的图片保存起来(字典)
    内存缓存--->磁盘缓存
    3.图片不会刷新--->刷新某行
    4.图片重复下载(图片下载需要时间,当图片还未完全下载之前,又要重新显示该图片)
    5.数据错乱 ---设置占位图片
*/
/*
     Documents:会备份,不允许
      Libray
      Preferences:偏好设置 保存账号
       caches:缓存文件
      tmp:临时路径(随时会被删除)
  */

@end
