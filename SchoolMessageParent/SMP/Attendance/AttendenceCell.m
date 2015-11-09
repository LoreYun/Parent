//
//  AttendenceCell.m
//  SchoolMessage
//
//  Created by LI on 15/2/10.
//  Copyright (c) 2015年 whwy. All rights reserved.
//

#import "AttendenceCell.h"

@interface AttendenceCell ()

@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong) UILabel * timeLabel;

@property (nonatomic,strong) UILabel * statuesLabel;

@end

@implementation AttendenceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initViews];
    }
    
    return self;
}

-(void)initViews
{
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(4.5,12,55,16)];
    self.nameLabel.textColor = [UtilManager getColorWithHexString:@"333333"];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.nameLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(4.5,12,SCREEN_WIDTH-80,16)];
    self.timeLabel.textColor = [UtilManager getColorWithHexString:@"333333"];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.timeLabel];
    
    self.statuesLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80-55,12,55,16)];
    self.statuesLabel.textColor = [UtilManager getColorWithHexString:@"333333"];
    self.statuesLabel.font = [UIFont systemFontOfSize:15];
    self.statuesLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.statuesLabel];
    
    UIView *div = [[UIView alloc] initWithFrame:CGRectMake(0, 37.5, SCREEN_WIDTH-80, 0.5)];
    [self addSubview:div];
    div.backgroundColor = [UIColor blackColor];
}

+(NSString *)identifier
{
    return @"AttendenceCell";
}


-(void)setUpViews:(NSDictionary *)dic row:(NSInteger)row
{
    if (row==0) {
        self.nameLabel.text = @"姓名";
        self.timeLabel.text = @"时间";
        self.statuesLabel.text = @"状态";
    }else
    {
        self.nameLabel.text = [dic objectForKey:@"StudentName"];//[[AccountManager sharedInstance].LoginInfos getStudentName];
        self.timeLabel.text = [dic objectForKey:@"UpLoadTime"];
        NSNumber *late = [dic objectForKey:@"LateFlag"];
        self.statuesLabel.text = late.boolValue?@"未到":@"已到";
    }
}
@end
