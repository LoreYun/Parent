//
//  ZoneTagIntroduction.m
//  WhistleIm
//
//  Created by LI on 14-12-12.
//  Copyright (c) 2014年 Ruijie. All rights reserved.
//

#import "QueryAlertView.h"
@interface QueryAlertView()

@property (nonatomic,strong)UIView *alertView;

@property (nonatomic,strong)NSDictionary *data;

@property (nonatomic, strong) UIWindow * zoneWindow;

@end

@implementation QueryAlertView


-(instancetype)initWithDic:(NSDictionary *)datas
{
    self= [super init];
    if (self) {
        self.data = datas;
        [self initSelf];
    }
    
    return self;
}

-(void)initSelf
{
    self.frame = [UIScreen mainScreen].bounds;
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:self.frame];
    iv.image =  [UIImage imageNamed:@"customAlertBG.png"];
    iv.userInteractionEnabled = YES;
    iv.clipsToBounds = YES;
    iv.userInteractionEnabled = YES;
    [iv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(11,16, 100, 20)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = [self.data objectForKey:@"SubjectName"];
    titleLabel.textColor = [UtilManager getColorWithHexString:@"#18b4ed"];
    
    UIView *div = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 285,1)];
    div.backgroundColor = [UtilManager getColorWithHexString:@"#18b4ed"];
    
    UILabel *teacher = [[UILabel alloc] initWithFrame:CGRectMake(31, 66, 240, 20)];
    teacher.textColor = [UtilManager getColorWithHexString:@"#333333"];
    teacher.font = [UIFont systemFontOfSize:20];
    teacher.text = [NSString stringWithFormat:@"平均分数：%@",[self.data objectForKey:@"avg"]];
    
    UILabel *room = [[UILabel alloc] initWithFrame:CGRectMake(31, 103, 240, 20)];
    room.textColor = [UtilManager getColorWithHexString:@"#333333"];
    room.font = [UIFont systemFontOfSize:20];
    room.text = [NSString stringWithFormat:@"最高分数：%@",[self.data objectForKey:@"max"]];
    
    UILabel *other = [[UILabel alloc] initWithFrame:CGRectMake(31, 140, 240, 20)];
    other.textColor = [UtilManager getColorWithHexString:@"#333333"];
    other.font = [UIFont systemFontOfSize:20];
    other.text = [NSString stringWithFormat:@"最低分数：%@",[self.data objectForKey:@"min"]];
    
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-285)/2,(SCREEN_HEIGHT-172)/2, 295,172)];
    self.alertView.backgroundColor = [UIColor whiteColor];
    
    [self.alertView addSubview:titleLabel];
    [self.alertView addSubview:div];
    [self.alertView addSubview:teacher];
    [self.alertView addSubview:room];
    [self.alertView addSubview:other];
    self.alertView.clipsToBounds = NO;//
    
    [self addSubview:iv];
    [self addSubview:self.alertView];

}


- (void)show
{
    self.zoneWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.zoneWindow.windowLevel = UIWindowLevelStatusBar + 1;
    self.zoneWindow.opaque = NO;
    [self.zoneWindow addSubview:self];
    [self.zoneWindow makeKeyAndVisible];
    
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.125 animations:^{
        self.alertView.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.0);
        self.alpha = 0.5f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.125 animations:^{
            self.alertView.layer.transform = CATransform3DIdentity;
            self.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
        }];
    }];
}



- (void) hide
{
    [self hidden];
}

- (void)hidden
{
    [UIView animateWithDuration:0.1 animations:^{
        self.alertView.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            self.alertView.layer.transform = CATransform3DIdentity;
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self cleanup];
        }];
    }];
}

- (void)cleanup {
    self.alertView.layer.transform = CATransform3DIdentity;
    self.alertView.transform = CGAffineTransformIdentity;
    [self removeFromSuperview];
    self.zoneWindow = nil;
    // rekey main AppDelegate window
    [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
    
}

@end
