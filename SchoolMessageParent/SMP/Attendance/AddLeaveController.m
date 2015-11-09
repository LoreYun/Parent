//
//  AddLeaveController.m
//  SchoolMessage
//
//  Created by LI on 15/3/10.
//  Copyright (c) 2015年 whwy. All rights reserved.
//

#import "AddLeaveController.h"
#import "DateChooseView.h"

@interface AddLeaveController ()<DateChooseViewDelegate,UITextViewDelegate>

@property (nonatomic,strong) UITextView *textView;

@property (nonatomic,strong) UIButton *startBtn;

@property (nonatomic,strong) UIButton *endBtn;

@end

@implementation AddLeaveController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initRightImageBar:@"fasong" action:@selector(sendLeave)];
    self.title = @"请假条";
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, SCREEN_HEIGHT-64-20)];
    iv.image = [UtilManager imageNamed:@"qingjiatiaobeijing"];
    [self.view addSubview:iv];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 38, 160, 19)];
    titleLabel.text = @"尊敬的老师：";
    titleLabel.textColor = [UtilManager getColorWithHexString:@"333333"];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:titleLabel];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(27, 63, SCREEN_WIDTH-60, 170)];
    self.textView.layer.borderColor = [UtilManager getColorWithHexString:@"c4c4c4"].CGColor;
    self.textView.layer.borderWidth = 2;
    self.textView.layer.shadowColor = [UtilManager getColorWithHexString:@"ffffff"].CGColor;
    self.textView.layer.shadowOffset = CGSizeMake(15, 13);
    self.textView.layer.opacity = 0.5;
    self.textView.layer.masksToBounds = YES;
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    
    UILabel *startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 243, 150,16)];
    startTimeLabel.text = @"起始时间：";
    startTimeLabel.textColor = [UtilManager getColorWithHexString:@"333333"];
    startTimeLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:startTimeLabel];
    
    self.startBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 243, 150, 16)];
    [self.startBtn setTitleColor:[UtilManager getColorWithHexString:@"333333"] forState:0];
    self.startBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    form.dateFormat = @"yyyy-MM-dd HH:mm";
    [self.startBtn setTitle:[form stringFromDate:[NSDate date]] forState:0];
    [self.startBtn addTarget:self action:@selector(chooseStratTime:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startBtn];
    
    UILabel *endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,265,150,16)];
    endTimeLabel.text = @"截止时间：";
    endTimeLabel.textColor = [UtilManager getColorWithHexString:@"333333"];
    endTimeLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:endTimeLabel];
    
    self.endBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 265, 150, 16)];
    [self.endBtn setTitleColor:[UtilManager getColorWithHexString:@"333333"] forState:0];
    self.endBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: date];
    [components setYear:-6];
    [components setHour: 18];
    [components setMinute:0];
    [components setSecond: 0];
    NSDate *newDate = [gregorian dateFromComponents: components];
    
    [self.endBtn setTitle:[form stringFromDate:[newDate dateByAddingTimeInterval:24*60*60]] forState:0];
    [self.endBtn addTarget:self action:@selector(chooseEndTime:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.endBtn];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
}

-(void)hideKeyboard
{
    [self.textView resignFirstResponder];
}

-(void)chooseStratTime:(id)sender
{
    self.startBtn.selected = YES;
    DateChooseView *alert = [[DateChooseView alloc] initByDefaultDate:[NSDate date]];
    alert.delegate =self;
    [alert show];
}

-(void)chooseEndTime:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    self.endBtn.selected = YES;
    DateChooseView *alert = [[DateChooseView alloc] initByDefaultDate:[NSDate date]];
    alert.delegate =self;
    [alert show];
}

-(void)DateChooseViewOnChoose:(NSDate *)date
{
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    form.dateFormat = @"yyyy-MM-dd HH:mm";
    if (self.startBtn.selected) {
        self.startBtn.selected = NO;
        [self.startBtn setTitle:[form stringFromDate:date] forState:0];
    }
    
    if (self.endBtn.selected) {
        self.endBtn.selected = NO;
        [self.endBtn setTitle:[form stringFromDate:date] forState:0];
    }
}

-(void)DateChooseViewOnDismiss
{
    if (!self.startBtn.enabled) {
        self.startBtn.enabled = YES;
    }
    
    if (!self.endBtn.enabled) {
        self.endBtn.enabled = YES;
    }
}

-(void)sendLeave
{
    [self.textView endEditing:YES];
    NSString * contnt = self.textView.text;
    if (!contnt.length>0) {
        [self showHint:@"请输入请假原因"];
        return;
    }
    
    if ([self.startBtn.titleLabel.text isEqualToString:@"点击此处选择时间"]) {
        [self showHint:@"请输入开始时间"];
        return;
    }
    
    if ([self.endBtn.titleLabel.text isEqualToString:@"点击此处选择时间"]) {
        [self showHint:@"请输入截止时间"];
        return;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSDate *startDate = [formatter dateFromString:self.startBtn.titleLabel.text];
    
    NSDate *endDate   = [formatter dateFromString:self.endBtn.titleLabel.text];
    
    if ([startDate timeIntervalSince1970]>=[endDate timeIntervalSince1970]) {
        [self showHint:@"请假截止时间必须晚于开始时间"];
        return;
    }
    
    [self showHudInView:self.view hint:@""];
    NSString *pid  = [[AccountManager sharedInstance].LoginInfos getParentsId];
    NSString *pname  = [[AccountManager sharedInstance].LoginInfos getRelation];
    NSString *sid  = [[AccountManager sharedInstance].LoginInfos getStudentId];
    NSString *sname  = [[AccountManager sharedInstance].LoginInfos getStudentName];
    NSString *cid  = [[AccountManager sharedInstance].LoginInfos getClassId];
    NSString *cname  = [[AccountManager sharedInstance].LoginInfos getClassName];
    NSString *startTime = self.startBtn.titleLabel.text;
    NSString *endTime = self.endBtn.titleLabel.text;
    
    NSDictionary *dic = @{@"1":contnt,@"2":pid,@"3":pname,@"4":sid,@"5":sname,@"6":cid,@"7":cname,@"8":startTime,@"9":endTime};
    [[ObjectManager sharedInstance] requestDataOnPost:dic ByFlag:@"21601" callback:^(BOOL succeed, NSDictionary * data) {
        [self hideHud];
        if (succeed) {
            NSNumber *su = [data objectForKey:S_SUCCESS];
            if (su.boolValue) {
                [self showHint:@"发送成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                [self showHint:@"操作失败，请检查网络！"];
            }
        }else
        {
            [self showHint:@"操作失败，请检查网络！"];
        }
    }];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end
