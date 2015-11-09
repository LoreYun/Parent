//
//  NotificationCell.m
//  SchoolMessage
//
//  Created by LI on 15/2/5.
//  Copyright (c) 2015年 whwy. All rights reserved.
//

#import "NotificationCell.h"

@interface NotificationCell ()

@property (nonatomic , strong)UILabel *title ;
@property (nonatomic , strong)UILabel *content ;
@property (nonatomic , strong)UILabel *creator;
@property (nonatomic , strong)UILabel *time;
@property (nonatomic , strong)UIImageView *bgView;
@property (nonatomic , strong)UIView *readView;

@end

@implementation NotificationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.readView = [[UIView alloc] initWithFrame:CGRectMake(5, 50,10,10)];
        self.readView.backgroundColor = [UtilManager getColorWithHexString:@"#18b4ed"];
        self.readView.layer.cornerRadius = 5;
        self.readView.layer.masksToBounds = YES;
        [self addSubview:self.readView];
        
        self.bgView = [[UIImageView alloc] initWithImage:[[UtilManager imageNamed:@"bullentin_bg"] stretchableImageWithLeftCapWidth:30 topCapHeight:50]];
        [self addSubview:self.bgView];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(35, 20, 110, 16)];
        self.title.numberOfLines = 1;
        self.title.clipsToBounds = YES;
        self.title.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.title];
        
        self.content = [[UILabel alloc] initWithFrame:CGRectMake(25, 42, self.frame.size.width-50, 32)];
        self.content.numberOfLines = 2;
        self.content.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.content];
        
        self.creator= [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-100-25, 23, 100, 16)];
        self.creator.numberOfLines = 1;
        self.creator.font = [UIFont systemFontOfSize:13];
        self.creator.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.creator];
        
        self.time= [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-100-25, 23, 100, 16)];
        self.time.numberOfLines = 1;
        self.time.font = [UIFont systemFontOfSize:15];
        self.time.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.time];
    }
    return self;
}
-(void)setupNotificationViews:(NSDictionary *)dic
{
    self.title.text = [dic objectForKey:@"Title"];
    self.content.text = [dic objectForKey:@"Content"];
    self.creator.text = [NSString stringWithFormat:@"发件人：%@",[dic objectForKey:@"TeacherName"]];
    NSString *t = [dic objectForKey:@"CreateTime"];
    self.time.text = t.length>0?[t substringToIndex:t.length-3]:@"";
    
    CGSize size = [self.content.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(SCREEN_WIDTH-50, 35)];
    self.content.frame = CGRectMake(35, 42, size.width, size.height);
    self.creator.frame = CGRectMake(SCREEN_WIDTH-150-25-12,20, 150, 16);
    self.time.frame = CGRectMake(SCREEN_WIDTH-150-25, CGRectGetMaxY(self.content.frame)+25, 150, 16);
    self.bgView.frame = CGRectMake(20,10,SCREEN_WIDTH-20,size.height+55+32);
    self.readView.frame = CGRectMake(5,(size.height+55+32-10)/2,10,10);
    NSNumber *num = [dic objectForKey:@"ReadFlag"];
    self.readView.hidden = num.boolValue;
}

+(NSString *)identifier
{
    return @"BulletinCell";
}

@end
