//
//  BRTablewViewModel.h
//  BRTablewViewModel
//
//  Created by gitBurning on 16/11/30.
//  Copyright © 2016年 BR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef UITableViewCell*(^BR_CellForRowAtIndexPathBlcok)(UITableView*tablew,NSIndexPath *indexPath,id model);
typedef id(^BR_HeightForHeaderInSectionBlcok)(UITableView *tablew,NSInteger section);
typedef id(^BR_HeightForFooderInSectionBlcok)(UITableView *tablew,NSInteger section);
typedef CGFloat(^BR_HeightForRowAtIndexPathBlcok)(UITableView *tablew,NSIndexPath*indexPath ,id model);
typedef void(^BR_DidSelectRowAtIndexPathBlcok)(UITableView *tablew,NSIndexPath*indexPath,id model);
//侧滑删除(1:系统自带的2:自定义删除)
typedef void(^BR_CellCommitEditingIndexPathBlock)(UITableView *tablew,NSIndexPath*indexPath,UITableViewCellEditingStyle style);

/**
 数据源

 @return return value description
 */
typedef NSArray*(^BR_GetTablewDataArrayBlcok)();
/**
 返回tablew，更新frame

 @param tablew <#tablew description#>
 */
typedef void(^BR_ConfigTablewBlock)(UITableView *tablew);

/*!
 *  @brief <#Description#>
 */
typedef NS_ENUM(NSUInteger, BR_TablewBaseViewType) {
    /*!
     *   多个section  每个section 一行
     */
    BR_TablewBaseViewType_MoreSectionOneRow,
    /*!
     *   1个section  每个section 多行
     */
    BR_TablewBaseViewType_OnSectionMoreRow,
    
    /*!
     *  @brief 多个section 每个section 多行 //暂时没有处理
     */
    BR_TablewBaseViewType_MoreSectionMoreRow
};

@interface BRTablewTempelte : NSObject

@property (nonatomic , strong, readonly) UITableView *tablewView;

/**
 初始化 不带fooder 和header

 @param isGrounp    <#isGrounp description#>
 @param rowType     <#rowType description#>
 @param cellBlcok   <#cellBlcok description#>
 @param configBlcok <#configBlcok description#>

 @return <#return value description#>
 */
-(instancetype)initWithIsGrounp:(BOOL)isGrounp rowType:(BR_TablewBaseViewType)rowType withCellInitBlcok:(BR_CellForRowAtIndexPathBlcok)cellBlcok configTablew:(BR_ConfigTablewBlock)configBlcok;


/**
 初始化 带header 不带 fooder

 @param isGrounp          类型
 @param rowType           tablew 数据类型
 @param cellBlcok         cell 回调
 @param headerHeightBlcok <#headerHeightBlcok description#>
 @param configBlcok       <#configBlcok description#>

 @return <#return value description#>
 */
-(instancetype)initWithIsGrounp:(BOOL)isGrounp rowType:(BR_TablewBaseViewType)rowType withCellInitBlcok:(BR_CellForRowAtIndexPathBlcok)cellBlcok withHeaderBlcok:(BR_HeightForHeaderInSectionBlcok)headerHeightBlcok configTablew:(BR_ConfigTablewBlock)configBlcok;;


/**
 初始化 不带header 带 fooder

 @param isGrounp          <#isGrounp description#>
 @param rowType           <#rowType description#>
 @param cellBlcok         <#cellBlcok description#>
 @param fooderHeightBlcok <#fooderHeightBlcok description#>
 @param configBlcok       <#configBlcok description#>

 @return <#return value description#>
 */
-(instancetype)initWithIsGrounp:(BOOL)isGrounp rowType:(BR_TablewBaseViewType)rowType withCellInitBlcok:(BR_CellForRowAtIndexPathBlcok)cellBlcok withFooderBlcok:(BR_HeightForFooderInSectionBlcok)fooderHeightBlcok configTablew:(BR_ConfigTablewBlock)configBlcok;;


/**
 初始化 带header 带 fooder

 @param isGrounp          <#isGrounp description#>
 @param rowType           <#rowType description#>
 @param cellBlcok         <#cellBlcok description#>
 @param headerHeightBlcok <#headerHeightBlcok description#>
 @param fooderHeightBlcok <#fooderHeightBlcok description#>
 @param configBlcok       <#configBlcok description#>

 @return <#return value description#>
 */
-(instancetype)initWithIsGrounp:(BOOL)isGrounp rowType:(BR_TablewBaseViewType)rowType withCellInitBlcok:(BR_CellForRowAtIndexPathBlcok)cellBlcok withHeaderBlcok:(BR_HeightForHeaderInSectionBlcok)headerHeightBlcok withFooderBlcok:(BR_HeightForFooderInSectionBlcok)fooderHeightBlcok configTablew:(BR_ConfigTablewBlock)configBlcok;;

/*!
 *  @brief 每行高度row 的回调
 */
- (void)BR_addRowHeightBlcok:(BR_HeightForRowAtIndexPathBlcok)rowHeight;

/*!
 *  @brief 点击每行的回调
 */
- (void)BR_addDidSelectRowAtIndexPathBlcok:(BR_DidSelectRowAtIndexPathBlcok)selectedBlcok;

- (void)BR_addDeleteCellIndexPathBlock:(BR_CellCommitEditingIndexPathBlock)deleteBlcok;
/*!
 *  @brief 配置数据源 (ps:如果带有 删除功能，最好传引用，不要copy)
 */
- (void)BR_updateDataArrayBlock:(BR_GetTablewDataArrayBlcok)dataBlock;


/**
  替换Tablew

 @param tablew tablew
 */
- (void)BR_ReplaceTablew:(UITableView *)tablew;

@end
