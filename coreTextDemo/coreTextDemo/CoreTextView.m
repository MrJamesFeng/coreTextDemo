//
//  CoreTextView.m
//  coreTextDemo
//
//  Created by LDY on 17/3/27.
//  Copyright © 2017年 LDY. All rights reserved.
//

#import "CoreTextView.h"
#import <CoreText/CoreText.h>
#import "CTFrameParser.h"
@interface CoreTextView()
@property(nonatomic,strong)NSMutableArray *imageInfos;

@property(nonatomic,strong)NSMutableArray *linksInfos;

@property(nonatomic,assign)CTFrameRef frame;
@end
@implementation CoreTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)drawRect:(CGRect)rect{
   
//    //上下文环境
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
//    //坐标转换
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//    CGContextTranslateCTM(context, 0,self.bounds.size.height);
//    CGContextScaleCTM(context, 1.0f, -1.0f);
//    
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"details" ofType:@"json"];
//    CTFrameRef frame = [CTFrameParser createFrameWithJsonFilePath:filePath];
//    
//    NSArray *ctLines = (NSArray *)CTFrameGetLines(frame);
//    int linesCount = (int)[ctLines count];
//    CGPoint linePoints[linesCount];
//    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), linePoints);//每一行的orign
//    int imageNum = 0;
//    
//    for (int i=0; i<linesCount; i++) {
//        
//        CTLineRef line = (__bridge CTLineRef)ctLines[i];
//        CGRect flipRect = [self getLineBounds:line point:linePoints[i]];//每一行的rect
//        NSArray *ctRuns = (NSArray *)CTLineGetGlyphRuns(line);//每一行中ctruns
//        
//        for (id ctRun in ctRuns) {
//            
//            CTRunRef run = (__bridge CTRunRef)ctRun;
//            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
//            CTRunDelegateRef delegete = (__bridge CTRunDelegateRef)[runAttributes valueForKey:(id)kCTRunDelegateAttributeName];//获取图片的delegate
//            
//            if (delegete == nil) {
//                continue;
//            }
//            
//            NSDictionary *metaDic = (NSDictionary *)CTRunDelegateGetRefCon(delegete);
//            
//            if (![metaDic isKindOfClass:[NSDictionary class]]) {
//                continue;
//            }
//            
//            CGRect runbounds;
//            CGFloat ascent,descent;
//            runbounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
//            
//            runbounds.size.height = ascent+descent;
//            
//            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
//            runbounds.origin.x = linePoints[i].x + xOffset;
//            runbounds.origin.y = linePoints[i].y;
//            runbounds.origin.y -= descent;
//            
//            CGPathRef pathRef = CTFrameGetPath(frame);
//            CGRect coloRect = CGPathGetBoundingBox(pathRef);
//            CGRect delegateBounds = CGRectOffset(runbounds, coloRect.origin.x, coloRect.origin.y);
//            
//            ImagesInfo *imageInfo = self.imageInfos[imageNum++];
//            imageInfo.rect = delegateBounds;
//            CGContextDrawImage(context, delegateBounds, [UIImage imageNamed:imageInfo.name].CGImage);
//        }
//    }
//    
//    CTFrameDraw(frame, context);
//    CFRelease(frame);
 [super drawRect:rect];
}
-(CGRect)getLineBounds:(CTLineRef)line point:(CGPoint)point{
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(point.x, point.y, width, height);
}
-(NSMutableArray *)imageInfos{
    if (!_imageInfos) {
        _imageInfos = [NSMutableArray array];
    }
    return _imageInfos;
}
-(NSMutableArray *)linksInfos{
    if (!_linksInfos) {
        _linksInfos = [NSMutableArray array];
    }
    return _linksInfos;
}
@end
