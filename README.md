# BR_TablewTemplate
tablew的模版。减少系统代理方法 重复率

# 前言 目前处理开发阶段

## 使用场景
 * 系统的tablew 是开发中常用的 UI 控件，但是日常使用中，使用它的时候，需要实现很多代理，，如果 多个地方使用了tablew，那么代理就造成了重复率比较高，因此 诞生了BR_TablewTemplate (目前实现)
 * 后续希望实现 网络层＋ TablewTemplate
 
### 使用方式 
 * 去掉了代理，那么意味着 需要 block 。 因此 BR_TablewTemplate 实现方式也是全部是 blcok，需要注意 retain circle
 
