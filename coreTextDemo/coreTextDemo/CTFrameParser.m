//
//  CTFrameParser.m
//  coreTextDemo
//
//  Created by LDY on 17/3/20.
//  Copyright © 2017年 LDY. All rights reserved.
//

#import "CTFrameParser.h"
@interface CTFrameParser()

@end
@implementation CTFrameParser


/**
 设置文本属性
 
 @param config 参数
 @return 属性
 */
+(NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config{
    
    //font
    CTFontRef font = CTFontCreateWithName((CFStringRef)config.fontName, config.fontSize, NULL);
    
    //paragraph
    CGFloat lineSpace = config.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting setting[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpace},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpace},
        {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat),&lineSpace}
    };
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(setting, kNumberOfSettings);
    
    //color
    UIColor *textColor = config.textColor;
    
    //attributes
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    attributes[(id)kCTFontAttributeName] = (__bridge id)font;
    attributes[(id)kCTParagraphStyleAttributeName] = (__bridge id)paragraphStyle;
    
    CFRelease(paragraphStyle);
    CFRelease(font);
    
    return attributes;
}
+(NSDictionary *)attributesWithConfigs:(NSDictionary *)configs{
    
    //font
    CTFontRef font = CTFontCreateWithName((CFStringRef)configs[@"fontName"], [configs[@"size"] floatValue], NULL);
    
    //paragraph
    CGFloat lineSpace = [configs[@"lineSpace"] floatValue];
    CGFloat leading = 30.0;
    CTTextAlignment alignment = kCTTextAlignmentLeft;
    
    CGFloat paragraphSpacingBefore = 10.0f;
     CGFloat fristlineindent = 36.0f;
    CGFloat headindent = 10.0f;
    CGFloat paragraphspace = 5.0f;
    const CFIndex kNumberOfSettings = 9;
    CTParagraphStyleSetting setting[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpace},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpace},
        {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat),&lineSpace},
        {kCTParagraphStyleSpecifierParagraphSpacing, sizeof(CGFloat), &leading},
        {kCTParagraphStyleSpecifierAlignment, sizeof(CTTextAlignment), &alignment},
        {kCTParagraphStyleSpecifierParagraphSpacingBefore,sizeof(CGFloat),& paragraphSpacingBefore},
        {kCTParagraphStyleSpecifierFirstLineHeadIndent,sizeof(CGFloat),&fristlineindent},
        {kCTParagraphStyleSpecifierHeadIndent,sizeof(CGFloat),&headindent},
        {kCTParagraphStyleSpecifierLineSpacing,sizeof(CGFloat),&paragraphspace}
    };
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(setting, kNumberOfSettings);
    
    //color
    SEL textColorSel = NSSelectorFromString(configs[@"color"]);
    UIColor *textColor = nil;
    if ([UIColor respondsToSelector:textColorSel]) {
        textColor = [UIColor performSelector:textColorSel];
    }
   
    //attributes
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    attributes[(id)kCTFontAttributeName] = (__bridge id)font;
    attributes[(id)kCTParagraphStyleAttributeName] = (__bridge id)paragraphStyle;
    
    CFRelease(paragraphStyle);
    CFRelease(font);
    
    return attributes;
}

/**
 获取NSAttributedString
 
 @param attributes attributes
 @param content NSString
 @param config CTFrameParserConfig
 @return NSAttributedString
 */

+(NSAttributedString *)createAttributedAttributes:(NSDictionary *)attributes content:(NSString *)content config:(CTFrameParserConfig *)config{
    
    return [[NSAttributedString alloc]initWithString:content attributes:attributes];
}

/**
 获取CTFramesetterRef
 
 @param attributedString NSAttributedString
 @param config CTFrameParserConfig
 @return CTFramesetterRef
 */
+(CTFramesetterRef)createFrameSetterWithAttributedString:(NSAttributedString *)attributedString config:(CTFrameParserConfig *)config{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    return framesetter;
}

/**
 获取CTFrameRef
 
 @param content NSString
 @param mutablePath CGMutablePathRef
 @param config CTFrameParserConfig
 @return CTFrameRef
 */
+(CTFrameRef)createFrameString:(NSString *)content mutablePath:(CGMutablePathRef)mutablePath config:(CTFrameParserConfig *)config{
    //1、NSString 转化为 NSAttributedString
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSAttributedString *attributedString = [self createAttributedAttributes:attributes content:content config:config];
    //2、根据富文本生成CTFramesetterRef
    CTFramesetterRef framesetter = [self createFrameSetterWithAttributedString:attributedString config:config];
    //3、根据 CTFramesetterRef 生成CTFrameRef
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize suggestTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGPathAddRect(mutablePath, NULL, CGRectMake(0, 0, config.width, suggestTextSize.height));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), mutablePath, NULL);
    return frame;
}

/*
+(CTFrameRef)createFrameWithFrameSetter:(CTFramesetterRef)framesetter config:(CTFrameParserConfig *)config height:(CGFloat)height{
    CGMutablePathRef mutablePath = CGPathCreateMutable();
    CGPathAddRect(mutablePath, NULL, CGRectMake(0, 0, config.width, height));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), mutablePath, NULL);
    CFRelease(mutablePath);
    return frame;
    
}
 */

/*
+(CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config{
    //文本
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSAttributedString *attributeString = [[NSAttributedString alloc]initWithString:content attributes:attributes];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeString);
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat TextHeight = coreTextSize.height;
    CTFrameRef frame = [self createFrameWithFrameSetter:framesetter config:config height:TextHeight];
    
    CoreTextData *textData = [[CoreTextData alloc]init];
    textData.ctFrame = frame;
    textData.textHeight = TextHeight;
    
    CFRelease(frame);
    CFRelease(framesetter);
    
    return textData;
    
   
}
 */
-(void)setMutableAttributedString:(NSMutableAttributedString *)mutableAttributedString{
    _mutableAttributedString = mutableAttributedString;
    
}

+(CTFrameRef)createFrameWithJsonFilePath:(NSString *)jsonFilePath{
    //读取配置文件
    NSData *data = [NSData dataWithContentsOfFile:jsonFilePath];
    NSError *error;
    NSDictionary *detailDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    //富文本
    NSMutableAttributedString * mutableAttributedString = [[NSMutableAttributedString alloc]init];
    
    NSArray *details = detailDict[@"details"];
    
    for (NSDictionary *dict in details) {
        if ([dict[@"type"] isEqualToString:@"text"]) {//文本
            NSDictionary *attributes = [self attributesWithConfigs:dict];
            NSAttributedString *attributedString = [[NSAttributedString alloc]initWithString:dict[@"content"] attributes:attributes];
            [mutableAttributedString appendAttributedString:attributedString];
        }else if ([dict[@"type"] isEqualToString:@"img"]){//图片
            NSAttributedString *attributes = [self attributeWithDict:dict];
            
            [mutableAttributedString length];
            
            [mutableAttributedString appendAttributedString:attributes];
        }
    }
    
    CTFramesetterRef framesetter = [self createFrameSetterWithAttributedString:mutableAttributedString config:nil];
    
    CGSize restrictSize = CGSizeMake(kscreenWidth, CGFLOAT_MAX);
    CGSize suggestTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    
    CGMutablePathRef mutablePath = CGPathCreateMutable();
    CGPathAddRect(mutablePath, NULL, CGRectMake(0, 0, kscreenWidth, suggestTextSize.height));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), mutablePath, NULL);

    return frame;

}
+(void)createFrameWithJsonFilePath:(NSString *)jsonFilePath callBackImages:(void(^)(NSArray *,CTFrameRef))callBackImages{
    
    
    
}

static CGFloat ascentCallBack(void *ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"height"] floatValue];
}

static CGFloat desentCallBack(void *ref){
    return 0;
}

static CGFloat widthCallBack(void *ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"width"] floatValue];
}

+(NSAttributedString *)attributeWithDict:(NSDictionary *)dict{
    
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));//清空结构体
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallBack;
    callbacks.getDescent = desentCallBack;
    callbacks.getWidth = widthCallBack;
    CTRunDelegateRef delegete = CTRunDelegateCreate(&callbacks, (__bridge void *)(dict));
    
    unichar spaceHoldChar = 0xFFFC;
    NSString *spaceHoldString = [NSString stringWithCharacters:&spaceHoldChar length:1];
    
    NSDictionary *attributes = [self attributesWithConfigs:dict];
    
    NSMutableAttributedString *placeHoldAttributedString = [[NSMutableAttributedString alloc]initWithString:spaceHoldString attributes:attributes];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef) placeHoldAttributedString, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegete);
    
    CFRelease(delegete);
    
    return placeHoldAttributedString;
    
}

+(void)createFrameWithJsonFilePath:(NSString *)jsonFilePath callBack:(void(^)(NSArray<ImagesInfo *> *imageInfos,NSArray<LinksInfo *> *linkInfos,CTFrameRef frame))callBack{
    //读取配置文件
    NSData *data = [NSData dataWithContentsOfFile:jsonFilePath];
    NSError *error;
    NSDictionary *detailDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSArray *details = detailDict[@"details"];
    
    NSMutableArray *imageInfos = [NSMutableArray array];
    NSMutableArray *linkInfos = [NSMutableArray array];
    
    //富文本
    NSMutableAttributedString * mutableAttributedString = [[NSMutableAttributedString alloc]init];
    
    for (NSDictionary *dict in details) {
        if ([dict[@"type"] isEqualToString:@"text"]) {//文本
            
            NSDictionary *attributes = [self attributesWithConfigs:dict];
            NSAttributedString *attributedString = [[NSAttributedString alloc]initWithString:dict[@"content"] attributes:attributes];
            [mutableAttributedString appendAttributedString:attributedString];
        }else if ([dict[@"type"] isEqualToString:@"img"]){//图片
            NSAttributedString *attributes = [self attributeWithDict:dict];
            
            ImagesInfo *imageInfo = [ImagesInfo new];
            imageInfo.length = [mutableAttributedString length];
            imageInfo.name = dict[@"name"];
            [imageInfos addObject:imageInfo];
            
            [mutableAttributedString appendAttributedString:attributes];
        }else if ([dict[@"type"] isEqualToString:@"link"]){
            
        }
    }
    
    
    CTFramesetterRef framesetter = [self createFrameSetterWithAttributedString:mutableAttributedString config:nil];
    
    CGSize restrictSize = CGSizeMake(kscreenWidth, CGFLOAT_MAX);
    
    CGSize suggestTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    
    CGMutablePathRef mutablePath = CGPathCreateMutable();
    CGPathAddRect(mutablePath, NULL, CGRectMake(0, 0, kscreenWidth, suggestTextSize.height));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), mutablePath, NULL);
    
    callBack(imageInfos,linkInfos,frame);

}

@end
