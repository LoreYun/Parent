//
//  BulletinCell.m
//  SchoolMessage
//
//  Created by wulin on 15/1/31.
//  Copyright (c) 2015年 whwy. All rights reserved.
//

#import "HomeWrokListCell.h"

//{
//    "NoticeId": 1,
//    "NoticeTitle": "测试年级公告1",
//    "NoticeContent": "测试年级公告1测试年级公告1测试年级公告1测试年级公告1测试年级公告1测试年级公告1",
//    "FaQiRenId": 1,
//    "FaQiRenName": "管理员",
//    "CreateTime": "2014-12-31 11:44:25",
//    "CodeId": 11,
//    "SendType": "标签推",
//    "TopFlag": false,
//    "Recievers": "2014级高中"
//}

@interface HomeWorkListCell ()

@property (nonatomic , strong)UILabel *title ;
@property (nonatomic , strong)UILabel *content ;
@property (nonatomic , strong)UILabel *creator;
@property (nonatomic , strong)UILabel *timeLabel;
@property (nonatomic , strong)UIImageView *bgView;
@property (nonatomic , strong)UIView *readView;

@end

@implementation HomeWorkListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.readView = [[UIView alloc] initWithFrame:CGRectMake(5, 50,10,10)];
        self.readView.backgroundColor = [UtilManager getColorWithHexString:@"#18b4ed"];
        self.readView.layer.cornerRadius = 5;
        self.readView.layer.masksToBounds = YES;
        [self addSubview:self.readView];
        
        self.bgView = [[UIImageView alloc] init];
        [self addSubview:self.bgView];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(35, 25, 173, 19)];
        self.title.numberOfLines = 1;
        self.title.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.title];
        
        self.content = [[UILabel alloc] initWithFrame:CGRectMake(25, 50, self.frame.size.width-50, 32)];
        self.content.numberOfLines = 2;
        self.content.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.content];
        
        self.creator= [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-150-25,25, 150, 16)];
        self.creator.numberOfLines = 1;
        self.creator.font = [UIFont systemFontOfSize:13];
        self.creator.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.creator];
        
        self.timeLabel= [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-100-25-50, 50, 150, 16)];
        self.timeLabel.numberOfLines = 1;
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.timeLabel];
    }
    return self;
}


-(void)setupViews:(NSDictionary *)dic
{
    self.title.text = [dic objectForKey:@"SubjectName"];
    self.content.text = [dic objectForKey:@"HomeworkContent"];
    self.creator.text = [NSString stringWithFormat:@"发起人：%@",[dic objectForKey:@"TeacherName"]];
    self.timeLabel.text = [dic objectForKey:@"CreateTime"];
    
    CGSize size = [self.content.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(SCREEN_WIDTH-50, 40)];
    self.content.frame = CGRectMake(35, 50, size.width, size.height);
    self.timeLabel.frame = CGRectMake(SCREEN_WIDTH-150-25, CGRectGetMaxY(self.content.frame)+8, 150, 16);
    self.bgView.image = [[UtilManager imageNamed:@"homeWork_bg"] stretchableImageWithLeftCapWidth:30 topCapHeight:50];
    self.bgView.frame = CGRectMake(20,10,SCREEN_WIDTH-20,size.height+50+32);
    
    self.readView.frame = CGRectMake(5,(size.height+55+32-10)/2,10,10);
    NSNumber *num = [dic objectForKey:@"RealFlag"];
    self.readView.hidden = num.boolValue;
}

+(NSString *)identifier
{
    return @"HomeWorkListCell";
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
