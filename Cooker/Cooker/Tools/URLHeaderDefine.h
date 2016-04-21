//
//  URLHeaderDefine.h
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#ifndef URLHeaderDefine_h
#define URLHeaderDefine_h


#define PICFRONT_URL @"http://pic.ecook.cn/web/" //图片拼接字符串

//首页
#define HOMEDATA_URL @"http://api.ecook.cn/public/getHomeData.shtml" //首页接口
#define RECOMMENDLIST_URL @"http://api.ecook.cn/public/getRecommendContentsByType.shtml" //精选专辑列表、每日菜单列表
#define COLLECTIONSORTDETAIL_URL @"http://api.ecook.cn/public/getCollectionSortDetailById.shtml" //精选专辑详情

//菜谱页面
#define RECIPEHOME_URL @"http://api.ecook.cn/public/getRecipeHomeData.shtml" //菜谱首页
#define RECIPELIST_URL @"http://api.ecook.cn/public/getRecipeListByType.shtml"  //新鲜菜、周最热的最新菜谱
#define COLLECTIONSORTLIST_URL @"http://api.ecook.cn/public/getCollectionSortListByType.shtml"  //新鲜菜、周最热的最新专辑
#define SUBCLASS_URL @"http://api.ecook.cn/public/getContentsBySubClassid.shtml"  //菜谱分类列表(一日三餐、主食小吃、视频等)
#define RECIPEDETAIL_URL @"http://api.ecook.cn/public/getRecipeListByIds.shtml"  //菜单详情
#define HASVIDEO_URL @"http://api.ecook.cn/public/hasVideoOrNot.shtml"  //判断是否有视频
#define SELECTUSER_URL @"http://api.ecook.cn/public/selectUserWeibo.shtml"  //菜单作者信息

//登录、注册页面
#define LOGINANDREGIST_URL @"http://api.ecook.cn/public/sendMobileRegisterCode.shtml" //登录、注册
#define VERIFYPASSWORD_URL @"http://api.ecook.cn/public/loginByMobileAndPassword.shtml" //登录验证密码
#define VERIFYMOBILE_URL @"http://api.ecook.cn/public/verifyMobileRegisterCode.shtml" //验证短信验证码
#define CREATEUSER_URL @"http://api.ecook.cn/public/createUser.shtml"  //注册 输入密码

#define SNANCK_URL @"http://api.meishi.cc/v5/class_list1.php?format=json" // 各地小吃


#endif /* URLHeaderDefine_h */
