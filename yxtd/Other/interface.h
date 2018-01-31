//
//  interface.h
//  yxtd
//
//  Created by qin on 2017/11/13.
//  Copyright © 2017年 qin. All rights reserved.
//

#ifndef interface_h
#define interface_h


#define httpUrl @"http://www.yixitongda.com/"

//登录
#define LoginMemberLogin @"" httpUrl@"/admin/MemberLogin"

//注册
#define RegiserMobileNumber @"" httpUrl@"/admin/MemberReg"

//注册短信验证码
#define RegiserGetSms @""  httpUrl@"/admin/sms"

//用户协议
#define UserAgreement @""  httpUrl@"/admin/text"


//我的信息(头像,昵称,关注,粉丝,动态)
#define MineUserMessage @""  httpUrl@"/admin/mydata"

//积分商城的可兑换商品
#define JiFenStoreCanDuiHuan @""  httpUrl@"admin/convertible"

//积分商城已兑换商品
#define JiFenStoreOverDuiHuan @""  httpUrl@"admin/hasChange"

//积分商城赛事奖品
#define JiFenStoreSaiShiGoods @""  httpUrl@"admin/ActivityPrizes"

#endif /* interface_h */
