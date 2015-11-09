//
//  QueryResultCell.m
//  SchoolMessage
//
//  Created by wulin on 15/2/27.
//  Copyright (c) 2015年 whwy. All rights reserved.
//

#import "QueryResultCell.h"

@interface QueryResultCell ()

@property (nonatomic,strong) UIButton *subject;
@property (nonatomic,strong) UIButton *result;
@property (nonatomic,strong) UIButton *time;
@property (nonatomic,strong) UIButton *title;

@end

@implementation QueryResultCell
@synthesize subject,result,time,title;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSelfViews];
    }
    return self;
}

-(void)initSelfViews
{
    subject = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 72, 52)];
    subject.backgroundColor = [UIColor whiteColor];
    [subject setTitle:@"" forState:0];
    [subject setTitleColor:[UtilManager getColorWithHexString:@"#333333"] forState:0];
    subject.titleLabel.font=[UIFont systemFontOfSize:14];
    subject.layer.borderColor = [UtilManager getColorWithHexString:@"#333333"].CGColor;
    subject.layer.borderWidth = 1;
    [self addSubview:subject];
    
    result = [[UIButton alloc] initWithFrame:CGRectMake(72, 0, 72, 52)];
    result.backgroundColor = [UIColor whiteColor];
    [result setTitle:@"" forState:0];
    [result setTitleColor:[UtilManager getColorWithHexString:@"#333333"] forState:0];
    result.layer.borderColor = [UtilManager getColorWithHexString:@"#333333"].CGColor;
    result.layer.borderWidth = 1;
    result.titleLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:result];
    
    time = [[UIButton alloc] initWithFrame:CGRectMake(144, 0, 72, 52)];
    time.backgroundColor = [UIColor whiteColor];
    [time setTitle:@"" forState:0];
    [time setTitleColor:[UtilManager getColorWithHexString:@"#333333"] forState:0];
    time.layer.borderColor = [UtilManager getColorWithHexString:@"#333333"].CGColor;
    time.layer.borderWidth = 1;
    time.titleLabel.font=[UIFont systemFontOfSize:14];
    time.titleLabel.numberOfLines = 0;
    [self addSubview:time];
    
    title = [[UIButton alloc] initWithFrame:CGRectMake(216, 0, SCREEN_WIDTH-216-10, 52)];
    title.backgroundColor = [UIColor whiteColor];
    [title  setTitle:@"" forState:0];
    [title setTitleColor:[UtilManager getColorWithHexString:@"#333333"] forState:0];
    title.layer.borderColor = [UtilManager getColorWithHexString:@"#333333"].CGColor;
    title.layer.borderWidth = 1;
    title.titleLabel.font=[UIFont systemFontOfSize:14];
    title.titleLabel.numberOfLines = 0;
    [self addSubview:title];
    
    subject.enabled = NO;
    result.enabled = NO;
    title.enabled = NO;
    time.enabled = NO;
}

-(void)setUpCell:(NSDictionary *)dic
{
    [self.subject setTitle:[dic objectForKey:@"SubjectName"] forState:0];
    NSNumber *score = [dic objectForKey:@"Score"];
    [self.result setTitle:score.stringValue forState:0];
    NSString *timestring = [dic objectForKey:@"ExamTime"];
    
    [self.time setTitle:[[timestring componentsSeparatedByString:@" "] objectAtIndex:0] forState:0];
    [self.title setTitle:[dic objectForKey:@"ExamName"] forState:0];
}

- (void)awakeFromNib {
    // Initialization code
}

+(NSString *)identifier
{
    return @"QueryResultCell";
}

//{
//    "SubjectId": 3,
//    "SubjectName": "英语",
//    "Score": 50.00,
//    "ExamName": "2015年入学考试",
//    "ExamId": 2,
//    "ExamTime": "2015-01-18 12:27:11"
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
