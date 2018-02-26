//
//  GuanZhuFansDetailViewController.m
//  yxtd
//
//  Created by qin on 2018/2/6.
//  Copyright © 2018年 qin. All rights reserved.
//

#define padding 10
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

//myfamily
#define myFamilyHeaderHeight 80
#define makeBookButtonHeight 60

#define imageTag 2000


#import "GuanZhuFansDetailViewController.h"
#import "DetailHeaderView.h"
#import "DetailTableViewCell.h"
#import "ShowUserContentHttp.h"
#import "MyFocusParam.h"
#import "DetailFansAndFocusModel.h"
#import "DetailArrayModel.h"



#import "ShowImageViewController.h"
#import "ReplyInputView.h"
#import "DetailShowImageViewController.h"

@interface GuanZhuFansDetailViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,weak) UIButton *replyButton; //点击后弹出的评论按钮
@property (nonatomic,weak) ReplyInputView *replyInputView;
@property (nonatomic,assign)BOOL flag;  //用于键盘出现时函数调用多次的情况

//用于view的移动，使评论框落在cell下面，没想到别的方法
@property (nonatomic,assign)float replyViewDraw;








/**
 *  存放详情页头部的模型
 */
@property (nonatomic, strong) DetailFansAndFocusModel *userHeaderModel;

@property (nonatomic,strong) DetailHeaderView*headerView;

@property (nonatomic,strong)UITableView*tableView;

@property (nonatomic,strong) NSMutableArray*dataArray;

@end

@implementation GuanZhuFansDetailViewController


//懒加载发布动态话题的内容
-(NSMutableArray*)dataArray{

    if (!_dataArray) {

        _dataArray=[NSMutableArray array];
    }

    return _dataArray;
}

/**
 *  懒加载-当前查看用户的头部信息模型
 */
- (DetailFansAndFocusModel *)userHeaderModel:(NSDictionary *)dict
{
    if(!_userHeaderModel)
    {
        _userHeaderModel = [[DetailFansAndFocusModel alloc] initWithDictionary:dict error:nil];

        //传值
        self.headerView.model=_userHeaderModel;
    }
    return _userHeaderModel;
}


-(DetailHeaderView*)headerView{

    if (_headerView==nil) {

        _headerView=[[DetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, 205)];
        _headerView.backgroundColor=[UIColor lightGrayColor];
        _headerView.is_admin=self.is_admin;
        _headerView.user_id=self.user_id;
    }

    return _headerView;
}


-(UITableView*)tableView{
    
    
    if (!_tableView) {
        
        _tableView=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DetailTableViewCell class] forCellReuseIdentifier:@"FamilyGroupCell"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //获取数据
    [self getFansAndFocusDetailHttpData];
    
    
    
    __weak GuanZhuFansDetailViewController*blockSelf=self;
    self.headerView.buttonBackBlock = ^{

        [blockSelf dismissViewControllerAnimated:YES completion:nil];
    };


    [self.view addSubview:self.headerView];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(0);
    }];
    
    
    self.flag = YES;
    
    //获取通知中心
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    //注册为被通知者
    [notificationCenter addObserver:self selector:@selector(keyChange:) name:UIKeyboardDidShowNotification object:nil];
    
  

    
}

#pragma mark -获取关注和粉丝发布话题的详情数据接口
-(void)getFansAndFocusDetailHttpData{


    NSUserDefaults *userInformation = [NSUserDefaults standardUserDefaults];

    NSString*api_tokenStr=[userInformation objectForKey:@"api_token"];

    NSString*member_idStr=[userInformation objectForKey:@"member_id"];

    MyFocusParam*params=[[MyFocusParam alloc] init];

    params.api_token=api_tokenStr;

    params.member_id=member_idStr;

    params.user_id=self.user_id;

    params.is_admin=self.is_admin;


    NSLog(@"api_token值-----------：%@",api_tokenStr);
    NSLog(@"member_idStr----------:%@",member_idStr);
    NSLog(@"user_id---------------:%@",self.user_id);
    NSLog(@"is_admin--------------:%@",self.is_admin);

    [ShowUserContentHttp httpShowUserContent:params success:^(id responseObject) {

        NSLog(@"粉丝和关注详情页的数据显示================：%@",responseObject);


        if ([responseObject[@"code"] integerValue]==200) {


                self.userHeaderModel=nil;

              NSDictionary*info=responseObject[@"data"];

                [self userHeaderModel:info];


               NSArray*array=info[@"list"];
            
            NSMutableArray *models = [NSMutableArray arrayWithCapacity:[array count]];

            for (NSDictionary*tempDict in array) {

                DetailArrayModel*model=[DetailArrayModel familyGroupWithDict:tempDict];
                
                
                DetailFansAndFocusCellFrame *familyGroupFrame = [[DetailFansAndFocusCellFrame alloc]init];
                familyGroupFrame.modelGroup =model;
//                familyGroupFrame.model=self.userHeaderModel;
                
                [models addObject:familyGroupFrame];
            
               self.dataArray=[models copy];
                
                [self.tableView reloadData];

            }
        
            

        }
        


    } failure:^(NSError *error) {


        NSLog(@"获取用户详情页头部信息失败");


    }];


}

#pragma mark -表格视图的代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"速度快撒活动空间十分快速========：%@",self.dataArray);
    return self.dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //虽然返回1，但是每个indexpath的section为0
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    DetailTableViewCell *cell = [DetailTableViewCell cellWithTableView:tableView];
    cell.cellFrame = self.dataArray[indexPath.row];


    [cell.replyButton addTarget:self action:@selector(replyAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.replyButton.tag = indexPath.row;   //评论时可以知道加到第几行
    cell.imageBlock = ^(NSArray *imageViews, NSInteger clickTag) {

        DetailShowImageViewController *vc = [[DetailShowImageViewController alloc] init];

        vc.clickTag = clickTag;
        vc.imageViews = imageViews;

        [self presentViewController:vc animated:YES completion:nil];

    };
    return cell;
}

//
//-(NSMutableArray *)familyGroupData
//{
//    if (!_familyGroupData) {
//        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"FamilyGroup.plist" ofType:nil];
//        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
//        NSMutableArray *models = [NSMutableArray arrayWithCapacity:[dictArray count]];
//        for (NSDictionary *dict in dictArray) {
//
//            DetailArrayModel *familyGroup = [DetailArrayModel familyGroupWithDict:dict];
//
//            DetailFansAndFocusCellFrame *familyGroupFrame = [[DetailFansAndFocusCellFrame alloc]init];
//            familyGroupFrame.modelGroup = familyGroup;
//
//            [models addObject:familyGroupFrame];
//        }
//        _familyGroupData = [models copy];
//    }
//
//    return _familyGroupData;
//}


-(void)replyAction:(UIButton *)sender
{
    DetailTableViewCell *cell = (DetailTableViewCell *)sender.superview.superview;
    
    self.replyViewDraw = [cell convertRect:cell.bounds toView:self.view.window].origin.y + cell.frame.size.height;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:indexPath];
    
    
    CGRect replyButtonF = CGRectMake(sender.frame.origin.x , rectInTableView.origin.y+sender.frame.origin.y - 2, 0,20);
       NSLog(@"%f",self.replyButton.frame.origin.y);
    NSLog(@"%f",rectInTableView.origin.y+sender.frame.origin.y - 2);
    
    
    if (self.replyButton && self.replyButton.frame.origin.y != (rectInTableView.origin.y+sender.frame.origin.y - 2-padding)) {
        [self.replyButton removeFromSuperview];      //以防用户按了一个评论又按另一个
        self.replyButton = nil;
    }
    [self initReplyButton:replyButtonF];
    if (self.replyButton) {
        self.replyButton.tag = sender.tag;
    }
}


-(void)initReplyButton:(CGRect)replyButtonF
{
    if (!self.replyButton) {
        UIButton *replyButton = [UIButton buttonWithType:0];
        replyButton.layer.cornerRadius = 5;
        replyButton.backgroundColor = [UIColor colorWithRed:33/255.0 green:37/255.0 blue:38/255.0 alpha:1.0];
        replyButton.frame = replyButtonF;
        [replyButton setTitleColor:[UIColor whiteColor] forState:0];
        replyButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [replyButton addTarget:self action:@selector(replyMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView addSubview:replyButton];
        self.replyButton = replyButton;
        
        [UIView animateWithDuration:0.25f animations:^{
            CGRect replyButtonDurF;
            replyButtonDurF.size.height = replyButtonF.size.height + 2*padding;
            replyButtonDurF.origin.y = replyButtonF.origin.y - padding;
            replyButtonDurF.origin.x = replyButtonF.origin.x - 60;
            replyButtonDurF.size.width = 60;
            replyButton.frame = replyButtonDurF;
        } completion:^(BOOL finished) {
            [replyButton setTitle:@"评论" forState:0];
        }];
        
    }
    else
    {
        [UIView animateWithDuration:0.25f animations:^{
            self.replyButton.frame = replyButtonF;    //只是为了有收缩的动画效果
        } completion:^(BOOL finished) {
            [self.replyButton removeFromSuperview];
            self.replyButton = nil;
        }];
        
    }
}

-(void)replyMessage:(UIButton *)sender
{
    if (self.replyButton) {
        [self initReplyInputView:sender.tag];
        [self.replyButton removeFromSuperview];
        self.replyButton = nil;
    }
}

-(void)initReplyInputView:(NSInteger) tag
{
    ReplyInputView *replyInputView = [[ReplyInputView alloc]initWithFrame:CGRectMake(0, self.view.bounds.origin.y + self.view.frame.size.height - 105, screenWidth, 54) andAboveView:self.view];
    
    self.flag = YES;
    //回调输入框的contentSize,改变工具栏的高度
    [replyInputView setContentSizeBlock:^(CGSize contentSize) {
        [self updateHeight:contentSize];
    }];
    
    [replyInputView setReplyAddBlock:^(NSString *replyText, NSInteger inputTag) {
        replyText = [@"浮夸：" stringByAppendingString:replyText];
        DetailFansAndFocusCellFrame *familyGroupFrameNeedChanged = self.dataArray[inputTag];
        DetailArrayModel *newFamilyGroup = familyGroupFrameNeedChanged.modelGroup;
        //做个中转
        NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
        [mutaArray addObjectsFromArray:newFamilyGroup.content];
        [mutaArray addObject:replyText];
        newFamilyGroup.img_url = mutaArray;
        
        familyGroupFrameNeedChanged.replysF = nil;
        familyGroupFrameNeedChanged.picturesF = nil;
        familyGroupFrameNeedChanged.modelGroup = newFamilyGroup;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:inputTag inSection:0];  //nsindexpath初始化方法
        [self.tableView reloadRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    replyInputView.replyTag = tag;    //值为cell所在的行
    [self.view addSubview:replyInputView];
    self.replyInputView = replyInputView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailFansAndFocusCellFrame *frame = self.dataArray[indexPath.row];
    return frame.cellHeight;
    

}

//更新replyView的高度约束
-(void)updateHeight:(CGSize)contentSize
{
    float height = contentSize.height + 20;
    CGRect frame = self.replyInputView.frame;
    frame.origin.y -= height - frame.size.height;  //高度往上拉伸
    frame.size.height = height;
    self.replyInputView.frame = frame;
}

//键盘出来的时候调整replyView的位置
-(void) keyChange:(NSNotification *) notify
{
    NSDictionary *dic = notify.userInfo;
    CGRect keyboardRect = [dic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    if (keyboardRect.size.height >250 && self.flag) {
        [UIView animateWithDuration:[dic[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            
            [UIView setAnimationCurve:[dic[UIKeyboardAnimationCurveUserInfoKey] doubleValue]];
            
            CGRect frame = self.replyInputView.frame;
            frame.origin.y = frame.origin.y - keyboardRect.size.height + 52;
            self.replyInputView.frame = frame;
            
            CGPoint point = self.tableView.contentOffset;
            
            point.y -= (frame.origin.y - self.replyViewDraw);
            self.tableView.contentOffset = point;
        }];
        self.flag = NO;
        
    }
}



//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//
//   return self.dataArray.count;
//
//}
//
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    DetailTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:detailCellID];
//
//    [cell fillCellWithModel:self.dataArray[indexPath.row] indexPath:indexPath];
//
//    DetailArrayModel*model=self.dataArray[indexPath.row];
//
//    self.imageArray=(NSMutableArray*)model.img_url;
//
//    //头像传值
//    cell.model=self.userHeaderModel;
//
//    //图片点击的下标
//    cell.indexPath = indexPath;
//
//    //图片传值
//    cell.dataArray = model.img_url;
//
//    //发布的内容
//    cell.contentArray=model.content;
//
//
//    cell.backgroundColor=[UIColor lightGrayColor];
//
//    self.labelHeight=cell.getLabelCellHeight;
//
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//
//    return cell;
//
//
//}
//
//
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//
//    return 300;
//
//
//}
//


@end
