//
//  DisplayView.m
//  coreTextDemo
//
//  Created by LDY on 17/3/20.
//  Copyright © 2017年 LDY. All rights reserved.
//

#import "DisplayView.h"
#import <CoreText/CoreText.h>
#import "CTFrameParser.h"
#import "CTFrameParserConfig.h"
@interface DisplayView()

@property(nonatomic,strong)NSMutableArray *imageInfos;

@property(nonatomic,strong)NSMutableArray *linksInfos;

@property(nonatomic,assign)CTFrameRef frame;

@end
@implementation DisplayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        [self setupAction];
    }
    return self;
}
-(instancetype)init{
    if (self=[super init]) {
        [self setupAction];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setupAction];
    }
    return self;
}
-(void)setupAction{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesureAC:)];
    self.userInteractionEnabled = YES;
    
    [self addGestureRecognizer:tap];
}
-(void)gesureAC:(UIGestureRecognizer *)recognizer{
    for (NSString *rect in self.imageInfos) {
        CGPoint touchPoint = [recognizer locationInView:self];
        CGRect imageRect = CGRectFromString(rect);
        CGFloat x = imageRect.origin.x;
        CGFloat y = self.bounds.size.height - imageRect.origin.y-imageRect.size.height;
        CGRect resultRect = CGRectMake(x, y, imageRect.size.width, imageRect.size.height);
        if (CGRectContainsPoint(resultRect, touchPoint)) {
            NSLog(@"dsdsdsdssds--->");
        }
    }
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    //上下文环境
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //坐标转换
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0,self.bounds.size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
 
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"details" ofType:@"json"];
    
    CTFrameRef frame = [CTFrameParser createFrameWithJsonFilePath:filePath];
    int imageCount = 0;
    CTFrameDraw(frame, context);//文本
    CFRelease(frame);
    /*
    NSArray *ctLines = (NSArray *)CTFrameGetLines(frame);
    int linesCount = (int)[ctLines count];
    CGPoint linePoints[linesCount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), linePoints);//每一行的orign
    
    for (int i=0; i<linesCount; i++) {
        
        CTLineRef line = (__bridge CTLineRef)ctLines[i];
        CGRect flipRect = [self getLineBounds:line point:linePoints[i]];//每一行的rect
        NSArray *ctRuns = (NSArray *)CTLineGetGlyphRuns(line);//每一行中ctruns
        
        for (id ctRun in ctRuns) {
            
            CTRunRef run = (__bridge CTRunRef)ctRun;
            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegete = (__bridge CTRunDelegateRef)[runAttributes valueForKey:(id)kCTRunDelegateAttributeName];//获取图片的delegate
            
            if (delegete == nil) {
                continue;
            }
            
            NSDictionary *metaDic = (NSDictionary *)CTRunDelegateGetRefCon(delegete);
            
            if (![metaDic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            
            CGRect runbounds;
            CGFloat ascent,descent;
            runbounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            
            runbounds.size.height = ascent+descent;
            
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            runbounds.origin.x = linePoints[i].x + xOffset;
            runbounds.origin.y = linePoints[i].y;
            runbounds.origin.y -= descent;
            
            CGPathRef pathRef = CTFrameGetPath(frame);
            CGRect coloRect = CGPathGetBoundingBox(pathRef);
            CGRect delegateBounds = CGRectOffset(runbounds, coloRect.origin.x, coloRect.origin.y);
            
            ImagesInfo *imageInfo = self.imageInfos[imageCount++];
            imageInfo.rect = delegateBounds;
            CGContextDrawImage(context, delegateBounds, [UIImage imageNamed:imageInfo.name].CGImage);
        }
    }

    CTFrameDraw(frame, context);
    CFRelease(frame);
     */
/*
    __weak typeof(self)weakSelf = self;
    [CTFrameParser createFrameWithJsonFilePath:filePath callBack:^(NSArray<ImagesInfo *> *imageInfos, NSArray<LinksInfo *> *linkInfos, CTFrameRef frame) {
        [weakSelf.imageInfos addObjectsFromArray:imageInfos];
        [weakSelf.linksInfos addObjectsFromArray:linkInfos];
        
        int imageCount = 0;
        CTFrameDraw(frame, context);//文本
        
        NSArray *ctLines = (NSArray *)CTFrameGetLines(frame);
        int linesCount = (int)[ctLines count];
        CGPoint linePoints[linesCount];
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), linePoints);//每一行的orign
        
        for (int i=0; i<linesCount; i++) {
            
            CTLineRef line = (__bridge CTLineRef)ctLines[i];
            CGRect flipRect = [self getLineBounds:line point:linePoints[i]];//每一行的rect
            NSArray *ctRuns = (NSArray *)CTLineGetGlyphRuns(line);//每一行中ctruns
            
            for (id ctRun in ctRuns) {
                
                CTRunRef run = (__bridge CTRunRef)ctRun;
                NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
                CTRunDelegateRef delegete = (__bridge CTRunDelegateRef)[runAttributes valueForKey:(id)kCTRunDelegateAttributeName];//获取图片的delegate
                
                if (delegete == nil) {
                    continue;
                }
    
                NSDictionary *metaDic = (NSDictionary *)CTRunDelegateGetRefCon(delegete);
                
                if (![metaDic isKindOfClass:[NSDictionary class]]) {
                    continue;
                }
                
                CGRect runbounds;
                CGFloat ascent,descent;
                runbounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
                
                runbounds.size.height = ascent+descent;
                
                CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
                runbounds.origin.x = linePoints[i].x + xOffset;
                runbounds.origin.y = linePoints[i].y;
                runbounds.origin.y -= descent;
                
                CGPathRef pathRef = CTFrameGetPath(frame);
                CGRect coloRect = CGPathGetBoundingBox(pathRef);
                CGRect delegateBounds = CGRectOffset(runbounds, coloRect.origin.x, coloRect.origin.y);
                
                ImagesInfo *imageInfo = weakSelf.imageInfos[imageCount++];
                imageInfo.rect = delegateBounds;
                CGContextDrawImage(context, delegateBounds, [UIImage imageNamed:imageInfo.name].CGImage);
            }
        }
        
        
        CFRelease(frame);

    }];
 
 */
  
    
    
   
//    CTFrameDraw(frame, context);

    
//    jsonFilePath	__NSCFString *	@"/var/containers/Bundle/Application/BE339479-FE9D-43C2-97D5-E1F1520976FB/coreTextDemo.app/details.json"	0x00000001700e6600
//    CFRelease(mutablePath);
    /*
    NSString * content = @"hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word";
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc]init];
    self.coreTextData = [CTFrameParser parseContent:content config:config];

     */
    
    /*
     
    //绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, self.bounds);
//    CGPathAddEllipseInRect(path, NULL, self.bounds);
    CGPathAddArc(path, NULL, self.bounds.size.width/2, self.bounds.size.height/2, self.bounds.size.width/2, 0, M_PI*2, YES);
    //文本
    NSAttributedString *attributeString = [[NSAttributedString alloc]initWithString:@"hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word hello word"];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, [attributeString length]), path, NULL);
    
    //
    CTFrameDraw(frame, context);
    //
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
     
     */
    
    /*
    if (self.coreTextData) {
        CTFrameDraw(self.coreTextData.ctFrame, context);
    }
     */
    
    
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
