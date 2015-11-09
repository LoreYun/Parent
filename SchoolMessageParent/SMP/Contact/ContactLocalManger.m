//
//  ContactLocalManger.m
//  SchoolMessage
//
//  Created by wulin on 15/2/8.
//  Copyright (c) 2015年 whwy. All rights reserved.
//

#import "ContactLocalManger.h"
#import "JSONKit.h"

#define SAVE @"ContctS_List"
#define FIRST @"fffff"

@interface ContactLocalManger ()

@property (nonatomic,strong) NSMutableArray *data;

@end

@implementation ContactLocalManger

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.data = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)uploadContactInfos:(void (^)(BOOL))callback
{
    NSDictionary * dic = @{@"1":@"6",@"2":[[AccountManager sharedInstance].LoginInfos getParentsId],@"3":@"",@"4":@"",@"5":[[NSArray arrayWithArray:self.data] JSONString]};
    [[ObjectManager sharedInstance] requestDataOnPost:dic ByFlag:@"2602" callback:^(BOOL succeed, NSDictionary *result) {
        if (succeed) {
            succeed = ((NSNumber *)[result objectForKey:S_SUCCESS]).boolValue;
        }
        callback(succeed);
    }];
}

-(void)DownloadContactInfos:(void (^)(BOOL))callback
{
    NSDictionary * dic = @{@"1":@"6",@"2":[[AccountManager sharedInstance].LoginInfos getParentsId]};
    [[ObjectManager sharedInstance] requestDataOnPost:dic ByFlag:@"2603" callback:^(BOOL succeed, NSDictionary *result) {
        if (succeed) {
            succeed = ((NSNumber *)[result objectForKey:S_SUCCESS]).boolValue;
        }
        if (succeed) {
            NSString *temp = [[result objectForKey:S_OBJ] objectForKey:@"PhoneContent"];
            NSLog(@"temp %@",temp);
            NSArray *array = [temp objectFromJSONString];
            [self saveContactInfos:array];
        }
        callback(succeed);
    }];
}

-(NSMutableArray *)getLoaclContactInfos
{
    if (!self.data) {
        self.data= [NSMutableArray array];
    }
    if (self.data.count ==0) {
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:[self getKeyString]];
        for (NSDictionary *dic in array) {
            [self.data addObject:[NSMutableDictionary dictionaryWithDictionary:dic]];
        }
        
    }
    
    return self.data;
}

-(void)saveContactInfos:(NSArray *)array
{
    [self.data removeAllObjects];
    for (NSDictionary *dic in array) {
        [self.data addObject:[NSMutableDictionary dictionaryWithDictionary:dic]];
    }
    [self saveLoaclContactInfos];
}

-(void)saveLoaclContactInfos
{
    [[NSUserDefaults standardUserDefaults] setValue:[NSArray arrayWithArray:self.data] forKey:[self getKeyString]];
}

-(NSString *)getKeyString
{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME_SAVE];
    return [NSString stringWithFormat:@"%@%@",username,SAVE];
}

-(BOOL)IsFirst
{
     NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME_SAVE];
    
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",username,FIRST]];
    
    return number?number.boolValue:YES;
}

-(void)setFirst
{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME_SAVE];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%@%@",username,FIRST]];
}

-(void)addNewContactInfo:(NSString *)classId name:(NSString *)name phone:(NSString *)phone
{
    NSDictionary *dic = @{@"Mobile":phone,@"NickName":@"",@"Relation":name,@"StudentName":@""};
    [self.data addObject:[NSMutableDictionary dictionaryWithDictionary:dic]];
}

-(void)deleteContactInfo:(NSString *)classId name:(NSString *)name phone:(NSString *)phone
{
    NSDictionary *dic = [self getDataByMobile:phone];
    [self.data removeObject:dic];
}

-(void)editContactInfo:(NSString *)classId name:(NSString *)name phone:(NSString *)phone
{
    NSDictionary *dic = [self getDataByMobile:phone];
    [dic setValue:name forKey:@"Relation"];
    [dic setValue:phone forKey:@"Mobile"];
}

-(NSDictionary *)getDataByMobile:(NSString *)phone
{
    for (NSDictionary *dic in self.data) {
        if ([[dic objectForKey:@"Mobile"] isEqualToString:phone]) {
            return dic;
        }
    }
    
    return nil;
}

@end
