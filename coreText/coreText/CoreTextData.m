//
//  CoreTextData.m
//  coreTextDemo
//
//  Created by LDY on 17/3/20.
//  Copyright © 2017年 LDY. All rights reserved.
//

#import "CoreTextData.h"

@implementation CoreTextData
-(void)setCtFrame:(CTFrameRef)ctFrame{
    if (_ctFrame != nil) {//释放旧值
        CFRelease(_ctFrame);
    }
  
    CFRetain(ctFrame);
    _ctFrame = ctFrame;
}
@end
