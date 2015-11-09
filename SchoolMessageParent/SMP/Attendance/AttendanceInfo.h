
//
//  AttendanceInfo.h
//  SchoolMessage
//
//  Created by LI on 15/2/10.
//  Copyright (c) 2015年 whwy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LATE @"1"

#define NOTLATE @"0"

//{       "StudentId": 1,       "StudentName": "1",       "Mobile": "13755555555"     },

//@`[{"Id":"1","LateFlag":"1","Name":"张三"},{"Id":"2","LateFlag":"0","Name":"李四"},{"Id":"3","LateFlag":"0","Name":"张五"}]@`-1

@interface AttendanceInfo : NSObject

@property (nonatomic,strong) NSNumber *StudentId;

@property (nonatomic,strong) NSString *StudentName;

@property (nonatomic,strong) NSString *Mobile;

@property (nonatomic,strong) NSString *LateFlag;

-(instancetype)initWithData:(NSDictionary *)dic;

-(NSString *)getUploadJson;

@end
