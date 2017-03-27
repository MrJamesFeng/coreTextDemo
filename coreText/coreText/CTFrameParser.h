//
//  CTFrameParser.h
//  coreTextDemo
//
//  Created by LDY on 17/3/20.
//  Copyright © 2017年 LDY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"
#import "ImagesInfo.h"
#import "LinksInfo.h"
@interface CTFrameParser : NSObject

@property(nonatomic,strong)NSMutableAttributedString *mutableAttributedString;

+(NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;

/**
 获取CTFrameRef实例

 @param content NSString
 @param mutablePath CGMutablePathRef
 @param config CTFrameParserConfig
 @return CTFrameRef实例
 */
+(CTFrameRef)createFrameString:(NSString *)content mutablePath:(CGMutablePathRef)mutablePath config:(CTFrameParserConfig *)config;

/**
 根据json配置文件获取CTFrameRef实例

 @param jsonFilePath json文件路径
 @return CTFrameRef实例
 */
+(CTFrameRef)createFrameWithJsonFilePath:(NSString *)jsonFilePath;

+(void)createFrameWithJsonFilePath:(NSString *)jsonFilePath callBackImages:(void(^)(NSArray *,CTFrameRef))callBackImages;

+(void)createFrameWithJsonFilePath:(NSString *)jsonFilePath callBack:(void(^)(NSArray<ImagesInfo *> *imageInfos,NSArray<LinksInfo *> *linkInfos,CTFrameRef frame))callBack;

@end
