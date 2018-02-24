//
//  DetailArrayModel.h
//  yxtd
//
//  Created by 覃宗雷 on 2018/2/12.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailArrayModel : NSObject

@property (nonatomic,copy) NSString*comment_num;
@property (nonatomic,copy) NSString*comment_content;
@property (nonatomic,copy) NSString*comment_user;
@property (nonatomic,copy) NSString*record_id;
@property (nonatomic,copy) NSString*nice_num;
@property (nonatomic,copy) NSString*flag;
@property (nonatomic,copy) NSString*addres;
@property (nonatomic,copy) NSString*time;
@property (nonatomic,copy) NSString*subject_catename;

//是否点赞判断
@property (nonatomic,copy) NSString*is_nice;


@property (nonatomic,strong) NSArray*content;
@property (nonatomic,strong) NSArray*img_url;


@end
