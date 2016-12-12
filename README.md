# BR_TablewTemplate
tablew的模版。减少系统代理方法 重复率

# 前言 目前处理开发阶段

## 使用场景
 * 系统的tablew 是开发中常用的 UI 控件，但是日常使用中，使用它的时候，需要实现很多代理，，如果 多个地方使用了tablew，那么代理就造成了重复率比较高，因此 诞生了BR_TablewTemplate (目前实现)
 * 后续希望实现 网络层＋ TablewTemplate
 
### 使用方式 
 ** 去掉了代理，那么意味着 需要 block 。 因此 BR_TablewTemplate 实现方式也是全部是 blcok，需要注意 retain circle
 * 根据需求选择初始化方法
 
   ![图片加载](BR_TablewTemplate/Resource/init_method.png)
 
  * 自定义高度的回调
  - (void)BR_addRowHeightBlcok:(BR_HeightForRowAtIndexPathBlcok)rowHeight;
  * 点击事件的回调
  - (void)BR_addDidSelectRowAtIndexPathBlcok:(BR_DidSelectRowAtIndexPathBlcok)selectedBlcok;
  * 删除cell 的回调，系统自带的方式删除
  - (void)BR_addDeleteCellIndexPathBlock:(BR_CellCommitEditingIndexPathBlock)deleteBlcok;
  * 更新 数据源  (ps:如果带有 删除功能，最好传引用，不要copy)
  - (void)BR_updateDataArrayBlock:(BR_GetTablewDataArrayBlcok)dataBlock;
  * 替换tablew，用于在已有的tablew 上面做处理
  - (void)BR_ReplaceTablew:(UITableView *)tablew;
  
### Pod 引入
   ** pod 引入 (如果没有搜索到 还未上传, ![试试](http://blog.cocoachina.com/article/29127))
   
   pod 'BRTablewTemplate', '~> 0.1.1'
    
    
### 使用实例

  ![图片加载](BR_TablewTemplate/Resource/user_demo.png)
