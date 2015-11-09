//
//  LoginInfo.h
//  SchoolMessage
//
//  Created by wulin on 15/1/27.
//  Copyright (c) 2015年 whwy. All rights reserved.
//

#import "Entity.h"

@interface LoginInfo : Entity

-(instancetype)initByLogin:(NSDictionary *)dic;

-(NSString*)getCodeNameByCodeId:(NSString *)CodeId;

-(NSString *)getGradeId;

-(NSString *)getAccount;

-(NSString *)getGradeId;

-(NSString *)getNickName;

-(void)setNickName:(NSString *)nickName;

-(NSString *)getHeadUrl;

-(void)setHeadNewUrl:(NSString *)newUrl;

-(NSString *)getHeadUrlPath;

-(NSString *)getFileUrl;

-(NSString *)getImageUrl;

-(NSString *)getTouxiangUrl;

-(NSString *)getShipinUrl;

-(NSString *)getPersonUploadUrl;

-(NSString *)getGroupUploadUrl;

-(NSArray *)getTeacherClassInfos;

-(NSArray *)getTeacherClassTeachingInfos;

-(NSString *)getTeacherId;

-(NSString *)getUserId;

-(NSString *)getTeacherName;

-(NSArray *)getTeacherSubject;

-(NSMutableArray *)getTeacherClassesArray;

//******** Parents
-(NSString *)getParentsId;

-(NSString *)getRelation;

-(NSString *)getStudentId;

-(NSString *)getStudentName;


-(NSString *)getClassId;
-(NSString *)getClassName;

-(NSArray *)getClassSubject;

-(NSString *)getClientId;

-(NSString *)getParentHelpUrl;

@end
