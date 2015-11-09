//
//  ZoneTagIntroduction.h
//  WhistleIm
//
//  Created by LI on 14-12-12.
//  Copyright (c) 2014年 Ruijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QueryAlertViewViewDalegate;
/**
 *   标签引导View
 */
@interface QueryAlertView : UIView

@property (nonatomic,weak) id<QueryAlertViewViewDalegate> delegate;

-(instancetype)initWithDic:(NSDictionary*)data;

-(void)show;

@end


@protocol QueryAlertViewDalegate <NSObject>

-(void)QueryAlertViewOnDisMiss:(NSDictionary *)data;

@end