//
//  DateChooseView.m
//  WhistleActivity
//
//  Created by LI on 15/4/17.
//  Copyright (c) 2015年 ruijie. All rights reserved.
//

#import "DateChooseView.h"


@implementation DateChooseView
{
   UIDatePicker * _datePicker;
    NSDate      * _defaultDate;
}

-(instancetype)initByDefaultDate:(NSDate *)date
{
    self = [super init];
    _defaultDate = date;
    return  self;
}

-(UIView *)setUpContentView
{
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-240, SCREEN_WIDTH, 240)];
    alertView.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(SCREEN_WIDTH-40-15, 5, 40, 30);
    [btn2 setTitle:@"完成" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:btn2];
    
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 200)];
    _datePicker.locale = locale;
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    if (_defaultDate) {
        _datePicker.date = _defaultDate;
    }
//    _datePicker.minimumDate = [NSDate date];
//    _datePicker.maximumDate = [NSDate date];
    [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [alertView addSubview:_datePicker];
    
    
    
    return alertView;
}

-(void)finish:(id)sender
{
    [self hide];
    if (self.delegate && [self.delegate respondsToSelector:@selector(DateChooseViewOnChoose:)]) {
        [self.delegate DateChooseViewOnChoose:_datePicker.date];
    }
}

-(void)hide
{
    [super hide];
    if (self.delegate && [self.delegate respondsToSelector:@selector(DateChooseViewOnDismiss)]) {
        [self.delegate DateChooseViewOnDismiss];
    }
}

-(void)dateChange:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(DateChooseViewOnChange:)]) {
        [self.delegate DateChooseViewOnChange:_datePicker.date];
    }
}

@end
