//
//  UITableView+NTVTableView.h
//  XHTVShortVideoProject
//
//  Created by 乔冬 on 2018/1/2.
//  Copyright © 2018年 XinHuaTV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (NTVTableView)
@property (nonatomic,strong) UITableView *ntvTableView;
- (void)ntvReloadRowTableViewForRow:(NSInteger )row inSection:(NSInteger)section;
- (void)ntvReloadRowTableViewInSection0ForRow:(NSInteger )row;
- (void)ntvReloadRowsTableViewWithIndexPaths:(NSArray *)rows;
- (void)ntvReloadRowsTableViewWithIndexPaths:(NSArray *)rows withRowAnimation:(UITableViewRowAnimation)animation;
- (void)ntvReloadData;
@end
