//
//  CoreText.m
//  TextKitPro
//
//  Created by li yajun on 15/11/6.
//   
//

#import "CoreTextData.h"

@implementation CoreTextData


-(void)setCtFrame:(CTFrameRef)ctFrame
{
    if(_ctFrame != ctFrame)
    {
         if(_ctFrame != nil)
         {
             CFRelease( _ctFrame );
             
         }
        CFRetain( ctFrame );
        _ctFrame = ctFrame;
    }
}
-(void)dealloc
{
    if(_ctFrame != nil)
    {
        CFRelease( _ctFrame );
        _ctFrame = nil;
    }
}
- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    [self fillImagePosition];
}
// 给每
- (void)fillImagePosition
{
    if (self.imageArray.count == 0)
    {
        return;
    }
    NSArray *lines = (NSArray *)CTFrameGetLines(self.ctFrame);
    NSUInteger lineCount = [lines count];
    CGPoint lineOrigins[lineCount];
    //获取每行的 开始的位置坐标，存放在 数组中
    CTFrameGetLineOrigins(self.ctFrame, CFRangeMake(0, 0), lineOrigins);
    //test
    
    int imgIndex = 0;
    CoreTextImageData * imageData = self.imageArray[0];
    
    for (int i = 0; i < lineCount; ++i)
    {
        if (imageData == nil)
        {
            break;
        }
        NSLog(@"line[%d].x= %f\nline[%d].y= %f", i, lineOrigins[i].x,i, lineOrigins[i].y);
        
        CTLineRef line = (__bridge CTLineRef)lines[i];
        NSArray * runObjArray = (NSArray *) CTLineGetGlyphRuns(line);
        for (id runObj in runObjArray)
        {
            CTRunRef run = (__bridge CTRunRef)runObj;
            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[runAttributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (delegate == nil)
            {
                continue;
            }
            
            NSDictionary * metaDic = CTRunDelegateGetRefCon(delegate);
            if (![metaDic isKindOfClass:[NSDictionary class]])
            {
                continue;
            }
            
            CGRect runBounds;
            CGFloat ascent;
            CGFloat descent;
            
            //获取一个run的宽，高
            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            runBounds.size.height = ascent + descent;
            
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            runBounds.origin.x = lineOrigins[i].x + xOffset;
            runBounds.origin.y = lineOrigins[i].y;
            runBounds.origin.y -= descent;
            
            CGPathRef pathRef = CTFrameGetPath(self.ctFrame);
            CGRect colRect = CGPathGetBoundingBox(pathRef);
            
            CGRect delegateBounds = CGRectOffset(runBounds, colRect.origin.x, colRect.origin.y);
            
            imageData.imagePosition = delegateBounds;
            imgIndex++;
            if (imgIndex == self.imageArray.count)
            {
                imageData = nil;
                break;
            } else
            {
                imageData = self.imageArray[imgIndex];
            }
        }
    }
}
@end
