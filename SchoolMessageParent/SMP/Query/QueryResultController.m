//
//  QueryResultController.m
//  SchoolMessage
//
//  Created by wulin on 15/2/26.
//  Copyright (c) 2015年 whwy. All rights reserved.
//

#import "QueryResultController.h"
#import "ClassChooseAlertView.h"
#import "QueryResultCell.h"
#import "QueryAlertView.h"

@interface QueryResultController ()<UITableViewDataSource,UITableViewDelegate,ClassChooseAlertViewDalegate>

@property (nonatomic,strong) UIButton * startBtn;
@property (nonatomic,strong) UIButton * endBtn;
@property (nonatomic,strong) UIButton * queryBtn;

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) UIDatePicker * datePicker1;
@property (nonatomic,strong) UIView * dateView;
@property (nonatomic,assign) NSInteger  chooseTag;

@property (nonatomic,strong) NSMutableArray * datasource;

@property (nonatomic,strong) NSDictionary * selectedDic;

@property (nonatomic,assign) BOOL Year6Ago;

@end

@implementation QueryResultController
@synthesize datePicker1,dateView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查询成绩";
    self.Year6Ago = YES;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    
    CGFloat length = SCREEN_WIDTH-109-182.5;
    
    UIView *div = [[UIView alloc] initWithFrame:CGRectMake(111, 29, length-4, 2)];
    div.backgroundColor = [UtilManager getColorWithHexString:@"#18b4ed"];
    [self.view addSubview:div];
    
    NSDictionary * dic = @{@"SubjectId":@"0",@"SubjectName":@"全部",@"Id":@"0"};
    if (!self.selectedDic) {
        self.selectedDic = dic;
    }
    
    self.startBtn = [self createTimeButton:time startX:10 action:@selector(startTime:)];
    self.startBtn.tag=1;
    self.endBtn = [self createTimeButton:time startX:SCREEN_WIDTH-182.5 action:@selector(endTime:)];
    self.endBtn.tag=2;
    self.queryBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-73.5, 10, 68.5, 40)];
    [self.queryBtn setTitle:@"查询" forState:0];
    [self.queryBtn setTitleColor:[UIColor whiteColor] forState:0];
    self.queryBtn.backgroundColor = [UtilManager getColorWithHexString:@"#18b4ed"];
    [self.queryBtn addTarget:self action:@selector(queryResult:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.queryBtn];
    
    [self initTitle];
    
    [self initTableView];
    
    [self createDatePicker];
    
    [self queryResult:nil];
}

-(NSString *)getStatTime
{
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: date];
    [components setYear:[components year]-6];
    [components setMonth:components.month];
    [components setDay:components.day];
    
    return [NSString stringWithFormat:@"%ld-%@-%@",components.year,[self getDtime:components.month],[self getDtime:components.day]];
}

-(NSString *)getDtime:(NSInteger)month
{
    if (month>9) {
        return [NSString stringWithFormat:@"%ld",(long)month];
    }else
    {
        return [NSString stringWithFormat:@"0%ld",(long)month];
    }
}

-(UIButton *)createTimeButton:(NSString *)title startX:(CGFloat)x action:(SEL)action
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, 10, 100, 40)];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderColor = [UtilManager getColorWithHexString:@"#18b4ed"].CGColor;
    button.layer.borderWidth =1;
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:title forState:0];
    [button setTitleColor:[UtilManager getColorWithHexString:@"#333333"] forState:0];
    [self.view addSubview:button];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    return button;
}

-(void)initTitle
{
    UIButton *subject = [[UIButton alloc] initWithFrame:CGRectMake(5, 70, 72, 52)];
    subject.backgroundColor = [UIColor whiteColor];
    [subject setTitle:@"科目" forState:0];
    [subject setTitleColor:[UtilManager getColorWithHexString:@"#18b4ed"] forState:0];
    [subject setImage:[UtilManager imageNamed:@"query_down"] forState:0];
    subject.titleLabel.font=[UIFont systemFontOfSize:17];
    [subject setTitleEdgeInsets:UIEdgeInsetsMake(0, -subject.imageView.frame.size.width, 0, subject.imageView.frame.size.width)];
    [subject setImageEdgeInsets:UIEdgeInsetsMake(0, subject.titleLabel.bounds.size.width, 0, -subject.titleLabel.bounds.size.width)];
    subject.layer.borderColor = [UtilManager getColorWithHexString:@"#333333"].CGColor;
    subject.layer.borderWidth = 1;
    [subject addTarget:self action:@selector(selectSubject:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subject];
    
    UIButton *result = [[UIButton alloc] initWithFrame:CGRectMake(77, 70, 72, 52)];
    result.backgroundColor = [UIColor whiteColor];
    [result setTitle:@"成绩" forState:0];
    [result setTitleColor:[UtilManager getColorWithHexString:@"#18b4ed"] forState:0];
    result.layer.borderColor = [UtilManager getColorWithHexString:@"#333333"].CGColor;
    result.layer.borderWidth = 1;
//    [result addTarget:self action:@selector(selectSubject:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:result];
    
    UIButton *time = [[UIButton alloc] initWithFrame:CGRectMake(149, 70, 72, 52)];
    time.backgroundColor = [UIColor whiteColor];
    [time setTitle:@"时间" forState:0];
    [time setTitleColor:[UtilManager getColorWithHexString:@"#18b4ed"] forState:0];
    time.layer.borderColor = [UtilManager getColorWithHexString:@"#333333"].CGColor;
    time.layer.borderWidth = 1;
    //    [result addTarget:self action:@selector(selectSubject:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:time];
    
    UIButton *title = [[UIButton alloc] initWithFrame:CGRectMake(221, 70, SCREEN_WIDTH-221-5, 52)];
     title.backgroundColor = [UIColor whiteColor];
    [title  setTitle:@"标题" forState:0];
    [title setTitleColor:[UtilManager getColorWithHexString:@"#18b4ed"] forState:0];
    title.layer.borderColor = [UtilManager getColorWithHexString:@"#333333"].CGColor;
    title.layer.borderWidth = 1;
    //    [result addTarget:self action:@selector(selectSubject:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:title];
    
}

-(void)initTableView
{
    self.datasource = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 122, SCREEN_WIDTH-10, SCREEN_HEIGHT-64-122-10) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)createDatePicker
{
    dateView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, 320, 240)];
    [dateView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:dateView];
    
    //NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePicker1 = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, 320, 200)];
    datePicker1.locale = locale;
    datePicker1.datePickerMode = UIDatePickerModeDate;
    [datePicker1 addTarget:self action:@selector(TimeChange) forControlEvents:UIControlEventValueChanged];
    [dateView addSubview:datePicker1];
    
    UIToolbar *dataPicker1Bar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    dataPicker1Bar.backgroundColor = [UIColor whiteColor];
    [dateView addSubview:dataPicker1Bar];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(265, 5, 40, 30);
    [btn2 setTitle:@"完成" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(downTimePicker) forControlEvents:UIControlEventTouchUpInside];
    [dataPicker1Bar addSubview:btn2];
    
}

-(void)startTime:(id)sender
{
    [self chooseTime:sender];
}

-(void)endTime:(id)sender
{
    [self chooseTime:sender];
}

-(void)queryResult:(id)sender
{
    [self showHudInView:self.view hint:@""];
    NSString *classId = [[AccountManager sharedInstance].LoginInfos getClassId];
    NSString *studentId = [[AccountManager sharedInstance].LoginInfos getStudentId];
    
    NSString *start = self.Year6Ago?[self getStatTime]:self.startBtn.titleLabel.text;
    NSDictionary *dic = @{@"1":classId,@"2":studentId,@"3":[self.selectedDic objectForKey:@"SubjectId"],@"4":start,@"5":self.endBtn.titleLabel.text,@"6":@"10000",@"7":@"1"};
    [[ObjectManager sharedInstance] requestDataOnPost:dic ByFlag:@"21201" callback:^(BOOL succeed, NSDictionary *data) {
        [self hideHud];
        [self getResult:succeed Data:data];
    }];
}

-(void)selectSubject:(id)sender
{
    NSDictionary * dic = @{@"SubjectId":@"0",@"SubjectName":@"全部",@"Id":@"0"};
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[AccountManager sharedInstance].LoginInfos getClassSubject]];
    [array insertObject:dic atIndex:0];
    ClassChooseAlertView *alert = [[ClassChooseAlertView alloc] initWithDic:array classID:[self.selectedDic objectForKey:@"SubjectId"] type:SujectChoose];
    alert.delegate = self;
    [alert show];
}

-(void)ClassChooseOnDisMiss:(NSDictionary *)data
{
    [self showHudInView:self.view hint:@""];
    self.selectedDic = data;
    NSString *classId = [[AccountManager sharedInstance].LoginInfos getClassId];
    NSString *studentId = [[AccountManager sharedInstance].LoginInfos getStudentId];
    NSString *start = self.Year6Ago?[self getStatTime]:self.startBtn.titleLabel.text;
    NSDictionary *dic = @{@"1":classId,@"2":studentId,@"3":[data objectForKey:@"SubjectId"],@"4":start,@"5":self.endBtn.titleLabel.text,@"6":@"1000",@"7":@"1"};
    [[ObjectManager sharedInstance] requestDataOnPost:dic ByFlag:@"21201" callback:^(BOOL succeed, NSDictionary *data) {
        [self hideHud];
        [self getResult:succeed Data:data];
    }];
}


-(void)getResult:(BOOL)succeed Data:(NSDictionary *)data
{
    if (succeed) {
        NSNumber *su = [data objectForKey:S_SUCCESS];
        if (su.boolValue) {
            [self.datasource removeAllObjects];
            [self.datasource addObjectsFromArray:[data objectForKey:S_OBJ]];
            [self.tableView reloadData];
        }else
        {
            [self showHint:@"操作失败，请检查网络！"];
        }
    }else
    {
        [self showHint:@"操作失败，请检查网络"];
    }
}


-(void)chooseTime:(UIButton *)btn
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    datePicker1.date = [formatter dateFromString:btn.titleLabel.text];
    self.chooseTag = btn.tag;
    [UIView animateWithDuration:0.5 animations:^{
        
        [dateView setFrame:CGRectMake(0, SCREEN_HEIGHT-64 - 240, 320, 240)];
    }];
    
}

-(void)TimeChange
{
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat= @"yyyy-MM-dd";
    UIButton *btn = (UIButton *)[self.view viewWithTag:self.chooseTag];
    [btn setTitle:[formatter1 stringFromDate:datePicker1.date] forState:0];
    self.Year6Ago = NO;
}

- (void)downTimePicker
{
    [UIView animateWithDuration:0.5 animations:^{
        [dateView setFrame:CGRectMake(0, SCREEN_HEIGHT, 320, 240)];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QueryResultCell *cell = [tableView dequeueReusableCellWithIdentifier:[QueryResultCell identifier]];
    if (!cell) {
        cell = [[QueryResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[QueryResultCell identifier]];
    }
    [cell setUpCell:[self.datasource objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self  showHudInView:self.view hint:@""];
    NSDictionary *data = [self.datasource objectAtIndex:indexPath.row];
    NSString *examId = [data objectForKey:@"ExamId"];
    NSString *SubjectId = [data objectForKey:@"SubjectId"];
     NSString *classId = [[AccountManager sharedInstance].LoginInfos getClassId];
    NSString *SubjectName = [data objectForKey:@"SubjectName"];
    NSDictionary *dic = @{@"1":examId,@"2":SubjectId,@"3":classId};
    [[ObjectManager sharedInstance] requestDataOnPost:dic ByFlag:@"21202" callback:^(BOOL succeed, NSDictionary *data) {
        [self hideHud];
        if (succeed) {
            NSNumber *su = [data objectForKey:S_SUCCESS];
            if (su.boolValue) {
                NSDictionary *temp = [data objectForKey:S_OBJ];
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:temp];
                [dic setObject:SubjectName forKey:@"SubjectName"];
                [self alertDetailView:dic];
            }else
            {
                [self showHint:@"操作失败，请检查网络！"];
            }
        }else
        {
            [self showHint:@"操作失败，请检查网络"];
        }
    }];
    
}

-(void) alertDetailView:(NSDictionary*)dic
{
    [[[QueryAlertView alloc] initWithDic:dic] show];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
