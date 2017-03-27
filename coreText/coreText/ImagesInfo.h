//
//  ImagesInfo.h
//  coreTextDemo
//
//  Created by LDY on 17/3/23.
//  Copyright © 2017年 LDY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImagesInfo : NSObject

@property(nonatomic,copy)NSString *name;//图片名称

@property(nonatomic,assign)CGRect rect;//图片位置

@property(nonatomic,assign)NSInteger length;


@end
