//
//  AttendenceCell.h
//  SchoolMessage
//
//  Created by LI on 15/2/10.
//  Copyright (c) 2015年 whwy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendenceCell : UITableViewCell

+(NSString *)identifier;

-(void)setUpViews:(NSDictionary *)dic row:(NSInteger)row;

@end
