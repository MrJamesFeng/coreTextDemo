//
//  CTFrameParserConfig.h
//  coreTextDemo
//
//  Created by LDY on 17/3/20.
//  Copyright © 2017年 LDY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CTFrameParserConfig : NSObject

@property(nonatomic,assign)CGFloat width;

@property(nonatomic,assign)CGFloat fontSize;

@property(nonatomic,assign)CGFloat lineSpace;

@property(nonatomic,strong)UIColor *textColor;

@property(nonatomic,copy)NSString *fontName;


@end
