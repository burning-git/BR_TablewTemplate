//
//  BRTablewViewModel.m
//  BRTablewViewModel
//
//  Created by gitBurning on 16/11/30.
//  Copyright © 2016年 BR. All rights reserved.
//

#import "BRTablewTempelte.h"
/*!
 *  @brief 视图样式
 */
typedef NS_ENUM(NSUInteger, TablewBaseViewStyle) {
    /*!
     *  没有fooder 和header
     */
    TablewBaseViewStyle_NoFooderHeader=1,
    /*!
     *  无fooder 有header
     */
    TablewBaseViewStyle_NoFooderHadHeader,
    /*!
     *  有fooder 无header
     */
    TablewBaseViewStyle_HadFooderNoHeader,
    /*!
     *  有fooder 和header
     */
    TablewBaseViewStyle_HadFooderHadHeader
};
static NSString * heightForFooterInSectionMethod = @"tableView:heightForFooterInSection:";
static NSString * heightForHeaderInSectionMethod = @"tableView:heightForHeaderInSection:";
static NSString * commitEditingStyleMethod       = @"tableView:commitEditingStyle:forRowAtIndexPath:";

@interface BRTablewTempelte()<UITableViewDelegate,UITableViewDataSource>


@property (assign,nonatomic) BOOL isGrounp;

@property (copy,nonatomic) BR_CellForRowAtIndexPathBlcok cellBlcok;

@property (copy,nonatomic) BR_HeightForHeaderInSectionBlcok headerHeightBlcok;

@property (copy,nonatomic) BR_HeightForFooderInSectionBlcok fooderHeightBlcok;


@property (assign,nonatomic) BR_TablewBaseViewType currentRowType;

@property (assign,nonatomic,readonly) TablewBaseViewStyle  viewType;


/*!
 *  @brief 点击某一行
 */
@property (copy,nonatomic) BR_DidSelectRowAtIndexPathBlcok selectRowBlcok;

@property (copy,nonatomic) BR_HeightForRowAtIndexPathBlcok rowHeightBlcok;

@property (copy, nonatomic) BR_CellCommitEditingIndexPathBlock deleteCellBlock;

@property (copy, nonatomic) BR_GetTablewDataArrayBlcok dataArray;

@end
@implementation BRTablewTempelte


/*!
 *  @brief 重载 需要 过滤掉方法
 *
 *  @param aSelector <#aSelector description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)respondsToSelector:(SEL)aSelector
{
    NSLog(@"%@",NSStringFromSelector(aSelector));
    
    NSString *methodString = NSStringFromSelector(aSelector);

    //heightForFooterInSection
    switch (_viewType) {
        case TablewBaseViewStyle_NoFooderHeader: {
            
            if ([methodString isEqualToString:heightForFooterInSectionMethod]) {
                
                return NO;
                
            }
            if ([methodString isEqualToString:heightForHeaderInSectionMethod]) {
                
                return NO;
                
            }
            
            break;
        }
        case TablewBaseViewStyle_NoFooderHadHeader: {
            if ([methodString isEqualToString:heightForFooterInSectionMethod]) {
                
                return NO;
                
            }
            break;
        }
        case TablewBaseViewStyle_HadFooderNoHeader: {
            if ([methodString isEqualToString:heightForHeaderInSectionMethod]) {
                
                return NO;
                
            }
            break;
        }
        case TablewBaseViewStyle_HadFooderHadHeader: {
            
            break;
        }
    }
    
    return [super respondsToSelector:aSelector];
    
}
#pragma mark - 外部 api

/*FIXME:  初始化 不带fooder 和header */

-(instancetype)initWithIsGrounp:(BOOL)isGrounp rowType:(BR_TablewBaseViewType)rowType withCellInitBlcok:(BR_CellForRowAtIndexPathBlcok)cellBlcok configTablew:(BR_ConfigTablewBlock)configBlcok
{
    self = [super init];
    if (self) {
        
        _viewType = TablewBaseViewStyle_NoFooderHeader;
        
        _currentRowType = rowType;
        [self configPublicView:nil isGrounp:isGrounp withCellInitBlcok:cellBlcok withConfigBlcok:configBlcok];
        
    }
    return self;
}

/*FIXME:  初始化 带header 不带 fooder */
-(instancetype)initWithIsGrounp:(BOOL)isGrounp rowType:(BR_TablewBaseViewType)rowType withCellInitBlcok:(BR_CellForRowAtIndexPathBlcok)cellBlcok withHeaderBlcok:(BR_HeightForHeaderInSectionBlcok)headerHeightBlcok configTablew:(BR_ConfigTablewBlock)configBlcok
{
    
    self = [super init];
    if (self) {
        
        NSAssert(headerHeightBlcok, @"headerHeightBlcok 初始化不能为空");
        _viewType = TablewBaseViewStyle_NoFooderHadHeader;
        _currentRowType = rowType;
        _headerHeightBlcok = headerHeightBlcok;
        [self configPublicView:nil isGrounp:isGrounp withCellInitBlcok:cellBlcok withConfigBlcok:configBlcok];

    }
    return self;
    
}

/*FIXME:  初始化 不带header 带 fooder */
-(instancetype)initWithIsGrounp:(BOOL)isGrounp rowType:(BR_TablewBaseViewType)rowType withCellInitBlcok:(BR_CellForRowAtIndexPathBlcok)cellBlcok withFooderBlcok:(BR_HeightForFooderInSectionBlcok)fooderHeightBlcok configTablew:(BR_ConfigTablewBlock)configBlcok
{
    self = [super init];
    if (self) {
        
        NSAssert(fooderHeightBlcok, @"fooderHeightBlcok 初始化不能为空");
        _viewType = TablewBaseViewStyle_HadFooderNoHeader;
        _currentRowType = rowType;
        
        _fooderHeightBlcok = fooderHeightBlcok;
        [self configPublicView:nil isGrounp:isGrounp withCellInitBlcok:cellBlcok withConfigBlcok:configBlcok];
        
    }
    return self;
    
}

/*FIXME:  初始化 带header 带 fooder */
-(instancetype)initWithIsGrounp:(BOOL)isGrounp rowType:(BR_TablewBaseViewType)rowType withCellInitBlcok:(BR_CellForRowAtIndexPathBlcok)cellBlcok withHeaderBlcok:(BR_HeightForHeaderInSectionBlcok)headerHeightBlcok withFooderBlcok:(BR_HeightForFooderInSectionBlcok)fooderHeightBlcok configTablew:(BR_ConfigTablewBlock)configBlcok
{
    self = [super init];
    if (self) {
        
        NSAssert(fooderHeightBlcok, @"fooderHeightBlcok 初始化不能为空");
        _currentRowType = rowType;
        
        _fooderHeightBlcok = fooderHeightBlcok;
        
        NSAssert(headerHeightBlcok, @"headerHeightBlcok 初始化不能为空");
        
        _viewType = TablewBaseViewStyle_HadFooderHadHeader;
        
        _headerHeightBlcok = headerHeightBlcok;
        
        [self configPublicView:nil isGrounp:isGrounp withCellInitBlcok:cellBlcok withConfigBlcok:configBlcok];
        
    }
    return self;
    
}

-(void)configPublicView:(id)info isGrounp:(BOOL)isGrounp withCellInitBlcok:(BR_CellForRowAtIndexPathBlcok)cellBlcok withConfigBlcok:(BR_ConfigTablewBlock)configBlock
{
    NSAssert(cellBlcok, @"cell 初始化不能为空");
    _cellBlcok = cellBlcok;
    _isGrounp = isGrounp;
    
    
    //先处理默认数据(1) 再处理UI(2)
    
    
    //(1)
    [self BR_updateDataArrayBlock:^NSArray *{
        
        return nil;
    }];
    
    //(2)
    UITableView *tablew ;
    if (isGrounp) {
        tablew = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    else{
        tablew = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    
    if (configBlock) {
        configBlock(tablew);
    }
   
    [self addTablewDetegate:tablew];
}

- (void)addTablewDetegate:(UITableView *)tablew {
    
    tablew.delegate = self;
    tablew.dataSource = self;
    tablew.tableFooterView = [UIView new];
    _tablewView = tablew;
}

#pragma mark ---- Interface 


/*FIXME: 每行高度row 的回调 */
- (void)BR_addRowHeightBlcok:(BR_HeightForRowAtIndexPathBlcok)rowHeight {
    
    _rowHeightBlcok = rowHeight;
    
}

/*FIXME: 点击每行的回调 */

- (void)BR_addDidSelectRowAtIndexPathBlcok:(BR_DidSelectRowAtIndexPathBlcok)selectedBlcok {
    
    _selectRowBlcok = selectedBlcok;
}

- (void)BR_updateDataArrayBlock:(BR_GetTablewDataArrayBlcok)dataBlock {
    _dataArray = dataBlock;
}

- (void)BR_addDeleteCellIndexPathBlock:(BR_CellCommitEditingIndexPathBlock)deleteBlcok {
    
    _deleteCellBlock = deleteBlcok;
    
}

- (void)BR_ReplaceTablew:(UITableView *)tablew {
    
    [self addTablewDetegate:tablew];
    [tablew reloadData];
    
}

#pragma mark --- tablewDelegate 
#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSInteger count = self.dataArray().count;
    
    switch (self.currentRowType) {
        case BR_TablewBaseViewType_MoreSectionOneRow: {
            
            break;
        }
        case BR_TablewBaseViewType_OnSectionMoreRow: {
            count = 1;
            break;
        }
        case BR_TablewBaseViewType_MoreSectionMoreRow: {
            
            break;
        }
    }
    
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    NSInteger count = self.dataArray().count;
    
    switch (self.currentRowType) {
        case BR_TablewBaseViewType_MoreSectionOneRow: {
            count = 1;
            break;
        }
        case BR_TablewBaseViewType_OnSectionMoreRow: {
            
            break;
        }
        case BR_TablewBaseViewType_MoreSectionMoreRow: {
            
            break;
        }
    }
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    id model = [self getRowModel:indexPath];
    
    UITableViewCell *cell = self.cellBlcok(tableView,indexPath,model);
    // Configure the cell...
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.headerHeightBlcok) {
//        CGFloat height = self.headerHeightBlcok(tableView,section);
        NSNumber * height =[self detailHeaderFooderViewHeight:tableView section:section isFooder:NO isHeight:YES];

        return [height floatValue];
    }else{
        return 100;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectRowBlcok) {
        id model = [self getRowModel:indexPath];
        
        self.selectRowBlcok(tableView,indexPath,model);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.fooderHeightBlcok) {
        NSNumber * height = [self detailHeaderFooderViewHeight:tableView section:section isFooder:YES isHeight:YES];
        return height.floatValue;
        
    }else{
        return 100;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = [self getRowModel:indexPath];
    CGFloat height = tableView.rowHeight;
    if (self.rowHeightBlcok) {
        
        height  = self.rowHeightBlcok(tableView,indexPath,model);
    }
    
    return height;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.deleteCellBlock) {
        return UITableViewCellEditingStyleDelete;
        
    }
    else{
        return UITableViewCellEditingStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.deleteCellBlock && editingStyle == UITableViewCellEditingStyleDelete) {
        self.deleteCellBlock(tableView,indexPath,editingStyle);
    }
}

-(id)getRowModel:(NSIndexPath*)indexPath
{
    id model = nil;
    switch (self.currentRowType) {
        case BR_TablewBaseViewType_MoreSectionOneRow: {
            model  = [self.dataArray() objectAtIndex:indexPath.section];
            break;
        }
        case BR_TablewBaseViewType_OnSectionMoreRow: {
            model  = [self.dataArray() objectAtIndex:indexPath.row];
            
            break;
        }
        case BR_TablewBaseViewType_MoreSectionMoreRow: {
            
            break;
        }
    }
    return model;
}


- (id)detailHeaderFooderViewHeight:(UITableView*)tablew section:(NSInteger )section isFooder:(BOOL)isFooder isHeight:(BOOL)isHeight{
    
    id temp = nil;
    
    if (isFooder) {
        temp = self.fooderHeightBlcok(tablew,section);
    }
    else{
        temp = self.headerHeightBlcok(tablew,section);
    }
    
    CGFloat height = 0.0;
    UIView *view;
    if ([temp isKindOfClass:[NSNumber class]]) {
        height = [temp floatValue];
    }
    else if ([temp isKindOfClass:[UIView class]]){
        view = temp;
        height = CGRectGetHeight(view.frame);
    }
    return isHeight?@(height):view;
    
}

#pragma mark --- setter



@end
