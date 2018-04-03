//
//  NTVTabBarController.m
//  AVPlayerDemo
//
//  Created by 乔冬 on 2018/3/26.
//  Copyright © 2018年 XinHuaTV. All rights reserved.
//

#import "NTVTabBarController.h"
#import "NTVNavigationController.h"
@interface NTVTabBarController ()

@end

@implementation NTVTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewControllers];
}

- (void)addChildViewControllers{
    
    NSString *path =  [[NSBundle mainBundle] pathForResource:@"MainVCSettings" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSArray *dictArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    for (NSDictionary *dict in dictArr) {
        [self addChildViewControllerWithChildVcName:dict[@"vcName"] Text:dict[@"title"] ImageName:dict[@"imageName"]];
    }
}
- (void)addChildViewControllerWithChildVcName:(NSString *)childVcName
                                         Text:(NSString *)title
                                    ImageName:(NSString *)imgName
{
    UIViewController *vc = [[NSClassFromString(childVcName) alloc]init];
    vc.title = title;
//    UIImage *normalImg  = [UIImage imageNamed:imgName];
//    UIImage *selectedImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",imgName,@"_selected"]];
//    vc.tabBarItem.image = [normalImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc.tabBarItem.selectedImage = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NTVNavigationController *nav = [[NTVNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
