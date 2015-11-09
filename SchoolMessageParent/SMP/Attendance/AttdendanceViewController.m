//
//  AttdendanceViewController.m
//  SchoolMessage
//
//  Created by LI on 15/2/10.
//  Copyright (c) 2015年 whwy. All rights reserved.
//

#import "AttdendanceViewController.h"
#import "AttendanceInfo.h"
#import "AddLeaveController.h"
#import "AttendenceCell.h"

static NSString *identifier = @"AttdendanceViewController.h";

@interface AttdendanceViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UICollectionView *imageCollectionView;
@property (nonatomic,strong) NSMutableArray *array;

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation AttdendanceViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"考勤";
    [self initRightImageBar:@"qingjiatiao" action:@selector(checkAttdendance)];
    self.array = [NSMutableArray array];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, SCREEN_HEIGHT-64-20)];
    iv.image = [UIImage imageNamed:@"kaoqinbg"];
    [self.view addSubview:iv];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(45, 34, SCREEN_WIDTH-80, SCREEN_HEIGHT-64-68)];
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getAttdenceInfo];
}

-(void)getAttdenceInfo
{
    [self showHudInView:self.view hint:@""];
    NSDictionary *dic = @{@"1":[[AccountManager sharedInstance].LoginInfos getStudentId],@"2":@"1000",@"3":@"1"};
    [[ObjectManager sharedInstance] requestDataOnPost:dic ByFlag:@"21701" callback:^(BOOL succeed, NSDictionary * data) {
        [self hideHud];
        if (succeed) {
            NSNumber *su = [data objectForKey:S_SUCCESS];
            if (su.boolValue) {
                for (NSDictionary *dic in [data objectForKey:S_OBJ]) {
                    [self.array addObject:dic];
                }
                [self.tableView reloadData];
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

-(void)checkAttdendance
{
    AddLeaveController *vc = [[AddLeaveController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark tableview

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count+1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AttendenceCell *cell = [tableView dequeueReusableCellWithIdentifier:[AttendenceCell identifier]];
    if (!cell) {
        cell = [[AttendenceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[AttendenceCell identifier]];
    }
    NSDictionary *dic = self.array.count==0?nil:[self.array objectAtIndex:indexPath.row-1>0?indexPath.row-1:0];
    [cell setUpViews:dic row:indexPath.row];
    
    return cell;
}

@end
