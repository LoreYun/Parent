//
//  LoginInfo.m
//  SchoolMessage
//
//  Created by wulin on 15/1/27.
//  Copyright (c) 2015年 whwy. All rights reserved.
//

#import "LoginInfo.h"

@interface LoginInfo()

@property (nonatomic,strong)NSMutableDictionary *startDatas;

@end

@implementation LoginInfo

-(instancetype)initByLogin:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
       self.startDatas = [NSMutableDictionary dictionaryWithDictionary:dic];
    }
    
    return self;
}

-(NSString *)getCodeNameByCodeId:(NSString *)CodeId
{
    NSArray *array = [self.startDatas objectForKey:@"AccountType"];
    for (NSDictionary * dic in array) {
        NSString *codeId = [dic objectForKey:@"CodeId"];
        if ([CodeId isEqualToString:codeId]) {
            return [dic objectForKey:@"CodeName"];
        }
    }
    
    return @"";
}

-(NSString *)getGradeId
{
    return [self.startDatas objectForKey:@"GradeId"];
}

-(NSString *)getNickName
{
    return [self.startDatas objectForKey:@"NickName"];
}

-(void)setNickName:(NSString *)nickName
{
    [self.startDatas setValue:nickName forKey:@"NickName"];
}

-(NSString *)getAccount
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME_REAL_SAVE];
}

-(NSString *)getHeadUrl
{
    NSString * touxiang = [self.startDatas objectForKey:@"Touxiang"];
    if (touxiang.length>0) {
        return [NSString stringWithFormat:@"%@%@",[self getTouxiangUrl],touxiang];
    }
    return @"";
}

-(void)setHeadNewUrl:(NSString *)newUrl
{
    [self.startDatas setValue:newUrl forKey:@"Touxiang"];
}

-(NSString *)getTeacherId
{
    return [self.startDatas objectForKey:@"TeacherId"];
}

-(NSString *)getUserId
{
    return [self.startDatas objectForKey:@"TeacherId"];
}

-(NSString *)getHeadUrlPath
{
    return [self.startDatas objectForKey:@"Touxiang"];;
}

-(NSString *)getFileUrl
{
    
    return [self getParamUrl:@"fileurl"];
}

-(NSString *)getImageUrl
{
    return [self getParamUrl:@"imageurl"];
}

-(NSString *)getTouxiangUrl
{
    return [self getParamUrl:@"touxiangurl"];
}

-(NSString *)getPersonUploadUrl
{
   return [self getParamUrl:@"PicUrl"];
}

-(NSString *)getGroupUploadUrl
{
    return [self getParamUrl:@"UploadTouxiang_URL"];
}

-(NSString *)getShipinUrl
{
    return [self getParamUrl:@"shipinurl"];
}

-(NSString *)getParamUrl:(NSString *)key
{
    NSArray *array = [self.startDatas objectForKey:@"ParaInfo"];
    for (NSDictionary * dic in array) {
        NSString *keyName = [dic objectForKey:@"keyname"];
        if ([key isEqualToString:keyName]) {
            return [dic objectForKey:@"keyvalue"];
        }
    }
    
    return @"";
}

-(NSArray *)getTeacherClassInfos
{
    return [self.startDatas objectForKey:@"TeacherClass"];
}

-(NSArray *)getTeacherClassTeachingInfos
{
    return [self.startDatas objectForKey:@"TeacherClassTeaching"];
}

-(NSString *)getTeacherName
{
    return [self.startDatas objectForKey:@"TeacherName"];
}

-(NSArray *)getTeacherSubject
{
    return [self.startDatas objectForKey:@"TeacherSubject"];
}

-(NSString *)getParentsId
{
    NSNumber *number = [self.startDatas objectForKey:@"ParentsId"];
    return number.stringValue;
}

-(NSString *)getRelation
{
    return [self.startDatas objectForKey:@"Relation"];
}

-(NSString *)getStudentId;
{
    return [self.startDatas objectForKey:@"StudentId"];
}

-(NSString *)getStudentName
{
    return [self.startDatas objectForKey:@"StudentName"];
}

-(NSMutableArray *)getTeacherClassesArray
{
    NSMutableArray * result = [NSMutableArray arrayWithArray:[self getTeacherClassTeachingInfos]];
    for (NSDictionary *dic in [self getTeacherClassInfos]) {
        NSNumber *classId = [dic objectForKey:@"ClassId"];
        BOOL flage = YES;
        for (NSDictionary *data in [self getTeacherClassTeachingInfos]) {
            NSNumber *tempclassId = [data objectForKey:@"ClassId"];
            if (classId.intValue ==  tempclassId.intValue) {
                flage = NO;
                break;
            }
        }
        if (flage) {
            [result addObject:dic];
        }
    }
    return result;
}

-(NSString *)getClassId
{
    NSNumber *number = [self.startDatas objectForKey:@"ClassId"];
    return number.stringValue;
}

-(NSString *)getClassName
{
    return [self.startDatas objectForKey:@"ClassName"];
}
-(NSArray *)getClassSubject
{
    return [self.startDatas objectForKey:@"ClassSubject"];
}

-(NSString *)getClientId
{
    return [self.startDatas objectForKey:@"ClientId"];
}

-(NSString *)getParentHelpUrl
{
    return [self getParamUrl:@"parenthelp"];
}

@end
