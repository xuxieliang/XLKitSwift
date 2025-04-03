# YXKitOC

#### 使用说明

一、基类（李鹏飞）

1.YXBaseVC

  /** 是否需要开启侧滑 */
  - (BOOL)isPanBackGestureEnable;
  /** 设置返回按钮图片 */
  - (void)setupBackItemWithImage:(UIImage *)image;
  /** 默认返回上一级菜单 可以重写 */
  - (void)backAction;
  /** 设置导航条右侧按钮 */
  - (void)setupRightButtonWithItems:(NSArray *)buttonArray;
  /** 自定义导航栏标题 */
  - (void)setNavigationTitle:(NSString *)title font:(UIFont *)font textColor:(UIColor *)color;

2.YXBaseNavController

  引用的第三方类库UINavigationController+FDFullscreenPopGesture，详细功能见        
  UINavigationController+FDFullscreenPopGesture.h

3.YXBaseTabBarController

  /** 设置指定tabar 小红点的值 */
  - (void)setBadgeValue:(NSString *)badgeValue index:(NSInteger)index;
  /** 数组中字典格式@{@"title":@"title1",@"image":@"image1.png",@"selectedImage":@"simage1.png",@"class":xxxVC}
  注:xxxVC是示例对象
  */
  - (instancetype)initWithItems:(NSArray *)items;

二、下拉菜单（李鹏飞）
1.YXPullDownMenuView菜单barView
@protocol YXPullDownMenuViewDataSource <NSObject>

@required

/// 菜单的DataSource 通过index区分每个按钮下拉赋值的view
/// @param pullDownMenu YXPullDownMenuView
/// @param menuIndex 菜单的index
- (UIView *)itemViewForPullDownMenu:(YXPullDownMenuView *)pullDownMenu menuIndex:(NSInteger)menuIndex;

selectedColor /**< 选中之后的颜色 */
nomarlColor /** 初始颜色 */
titles /** 标题数组 */

2.YXFiltersShowView（下拉菜单选中后展示view，可以点x清除选中）
isDefault /**< 是默认值的话不展示 */
title /**< 显示的内容 */
key /**< 用于于请求服务器的参数名称 */
filterPageIndex /**< 筛选页索引,默认NSNotFound */
customObject /**< 扩展字段，可以自定义实现特殊功能 */

@protocol YXFiltersShowViewDelegate <NSObject>

@optional
- (void)filterDidSelectedAtIndex:(NSInteger)index; /* 点中显示项代理 */
- (void)filterScrollViewClearSelected:(YXFiltersShowView *)filterView; /* 清空显示项代理 */

/// 添加YXFilterObject，如果key和value都相同，进行替换
- (void)mergeFilterObject:(YXFilterObject *)object;

/// 删除YXFilterObject，遍历listarray，如果tag不为空且相等则删除
- (void)removeFilterObjet:(YXFilterObject *)object;

///刷新数据
- (void)reloadData;

3.YXDictionaryFilterView（下拉展示的view，list）

4.YXMenuFilterProtocol（协议）

@protocol YXMenuFilterProtocol <NSObject>
@required

/// 已获取该筛选数据
/// @param filterPage 筛选视图
/// @param data 筛选源数据
/// @param filterObject 筛选历史集合，一个YXFilterObject对应显示一条数据
- (void)filterPage:(UIView *)filterPage didSelectedData:(id)data filterObject:(YXFilterObject *)filterObject;

/// 筛选视图关闭
/// @param contentView 当前筛选视图
- (void)didCloseOfContentFilterView:(UIView *)contentView;

/// 重置数据
- (void)resetData;

5.YXMenuFilterManager（下拉菜单管理类）
@protocol YXMenuFilterManagerDataSource <NSObject>

@required

/// 设置筛选项标题
/// @param menuFilterManager 筛选管理器
- (NSArray *)titlesOfFilterInYXMenuFilterManager:(YXMenuFilterManager *)menuFilterManager;

/// 设置筛选项内容
/// @param menuFilterManager 筛选管理器
/// @param index 筛选项索引
- (UIView *)viewOfFilterInYXMenuFilterManager:(YXMenuFilterManager *)menuFilterManager index:(NSInteger)index;

@end


@protocol YXMenuFilterManagerDelegate <NSObject>

@optional

/// 高度发生变化，列表frame需要刷新
- (void)menuFilterManager:(YXMenuFilterManager *)menuFilterManager viewHeightDidUpdate:(CGFloat)newHeight;

@required

/// 已选择筛选数据
/// @param menuFilterManager 筛选管理器
/// @param filterView 筛选视图
/// @param data 已得筛选数据
- (void)menuFilterManager:(YXMenuFilterManager *)menuFilterManager filterView:(UIView *)filterView didSelectedData:(id)data;

/// 移除已选择数据
/// @param menuFilterManager 筛选管理器
/// @param object 被删除的已选择数据
/// @param filterPage 被删除的已选择数据所在视图
/// @param filterPageIndex 被删除的已选择数据所在视图的索引
- (void)menuFilterManager:(YXMenuFilterManager *)menuFilterManager didRemoveFilterObject:(YXFilterObject *)object filterPage:(UIView *)filterPage filterPageIndex:(NSInteger)filterPageIndex;

使用方法
1.在VC中初始化YXMenuFilterManager和YXDictionaryFilterView

/// 初始化YXMenuFilterManager对象，设置代理
- (YXMenuFilterManager *)menuFilterManager {
    if (!_menuFilterManager) {
        _menuFilterManager = [[YXMenuFilterManager alloc] initWithShowInView:self.view];
        _menuFilterManager.dataSource = self;
        _menuFilterManager.delegate = self;
    }
    return _menuFilterManager;
}
/// 初始化下拉展示的列表VIEW
- (YXDictionaryFilterView *)filter1 {
    if (!_filter1) {
        _filter1 = [[YXDictionaryFilterView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.bounds.size.height - 44)];
        /// 设置筛选页代理为YXMenuFilterManager对象
        _filter1.menuFilterDelegate = self.menuFilterManager;
        _filter1.dataSource =  @[
                                @{ @"content" : @"title",
                                   @"key" : @"key" },
                                @{ @"content" : @"title1",
                                @"key" : @"key1: }];
    }
    return _filter1;
}

2.在viewDidLoad中加入代码[self.menuFilterManager reloadData];

3.实现datasource和代理

#pragma mark - YXMenuFilterManagerDataSource

/// 添加筛选管理器步骤6，添加YXMenuFilterManagerDataSource
- (NSArray *)titlesOfFilterInYXMenuFilterManager:(YXMenuFilterManager *)menuFilterManager {
    return @[@"筛选1", @"筛选2", @"筛选3"];
}

- (UIView *)viewOfFilterInYXMenuFilterManager:(YXMenuFilterManager *)menuFilterManager index:(NSInteger)index {
    switch (index) {
    case 0:
        return self.filter1;
    case 1:
        return self.filter2;
    case 2:
        return self.filter3;
    default:
        return nil;
    }
}

/// 刷新列表frame
- (void)reloadTableFrame {
    self.tableView.height = self.view.height - self.pullDownMenu.height;
    self.tableView.frame = CGRectMake(0, self.menuFilterManager.height, self.tableView.frame.size.width, self.view.height - self.menuFilterManager.height);
}

/// 添加YXMenuFilterManagerDataSource
#pragma mark - YXMenuFilterManagerDelegate

/// 已选筛选条件导致已选筛选条高度发生变化时的代理
- (void)menuFilterManager:(YXMenuFilterManager *)menuFilterManager viewHeightDidUpdate:(CGFloat)newHeight {
    [self reloadTableFrame];
}

/// 已选筛选条件代理
- (void)menuFilterManager:(YXMenuFilterManager *)menuFilterManager filterView:(UIView *)filterView didSelectedData:(id)info {
    if (self.filter1 == filterView) {
    } else if (self.auditStatusFilter == filterView) {
    } else if (self.whetherOpenAccountFilter == filterView) {
    }
}

/// 移除已选筛选条件的代理
- (void)menuFilterManager:(YXMenuFilterManager *)menuFilterManager didRemoveFilterObject:(YXFilterObject *)object filterPage:(UIView *)filterPage filterPageIndex:(NSInteger)filterPageIndex {

}

