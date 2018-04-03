//
//  UITableView+NTVTableView.m
//  XHTVShortVideoProject
//
//  Created by 乔冬 on 2018/1/2.
//  Copyright © 2018年 XinHuaTV. All rights reserved.
//

#import "UITableView+NTVTableView.h"
static char *ntvRelodTableView = "ntvRelodTableView";
@implementation UITableView (NTVTableView)
-(void)setNtvTableView:(UITableView *)ntvTableView{
        objc_setAssociatedObject(self,ntvRelodTableView , ntvTableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UITableView *)ntvTableView{
   return  objc_getAssociatedObject(self, ntvRelodTableView);
}

- (void)ntvReloadData{
    [self.ntvTableView reloadData];
}

- (void)ntvReloadRowsTableViewWithIndexPaths:(NSArray *)rows{
  
    [self.ntvTableView reloadRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationNone];
}
- (void)ntvReloadRowsTableViewWithIndexPaths:(NSArray *)rows withRowAnimation:(UITableViewRowAnimation)animation {
    
    [self.ntvTableView reloadRowsAtIndexPaths:rows withRowAnimation:animation];
}
- (void)ntvReloadRowTableViewInSection0ForRow:(NSInteger )row {
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.ntvTableView reloadRowsAtIndexPaths:@[indexPath1] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)ntvReloadRowTableViewForRow:(NSInteger )row inSection:(NSInteger)section{
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:row inSection:section];
    [self.ntvTableView reloadRowsAtIndexPaths:@[indexPath1] withRowAnimation:UITableViewRowAnimationNone];
}
@end
