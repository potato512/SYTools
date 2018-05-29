//
//  NSString+SYHtml.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2018/2/7.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "NSString+SYHtml.h"

@implementation NSString (SYHtml)

- (NSString *)htmlStringFilterFontSize
{
    NSString *content = self;
    NSRange range = [content rangeOfString:@"font-size:"];
    if (range.location == NSNotFound)
    {
        NSLog(@"can not change fontsize!");
    }
    else
    {
        NSArray *fontSizeArray = [content componentsSeparatedByString:@"font-size:"];
        NSMutableArray *bigArray = [NSMutableArray arrayWithArray:fontSizeArray];
        for (int i = 1; i < bigArray.count; i++)
        {
            NSString *bigText = bigArray[i];
            NSArray *minArray = [bigText componentsSeparatedByString:@"px"];
            if (minArray.count < 2)
            {
                minArray = [bigText componentsSeparatedByString:@"pt"];
            }
            if (minArray.count < 2)
            {
                minArray = [bigText componentsSeparatedByString:@"em"];
            }
            bigArray[i] = minArray[1];
        }
        content = @"";
        for (NSString *subStr in bigArray)
        {
            content = [content stringByAppendingString:subStr];
        }
    }
    return content;
    
    /*
     //设置字体大小为14，颜色为0x666666，边距为18，并且图片的宽度自动充满屏幕，高度自适应
     content = [NSString stringWithFormat:@"<html> \n"
     "<head> \n"
     "<style type=\"text/css\"> \n"
     "body {margin:18;font-size:30;color:0x666666}\n"
     "</style> \n"
     "</head> \n"
     "<body>"
     "<script type='text/javascript'>"
     "window.onload = function(){\n"
     "var $img = document.getElementsByTagName('img');\n"
     "for(var p in  $img){\n"
     " $img[p].style.width = '100%%';\n"
     "$img[p].style.height ='auto'\n"
     "}\n"
     "}"
     "</script>%@"
     "</body>"
     "</html>",content];
     content = [NSString stringWithFormat:@"<html> <head> <style type=\"text/css\"> body {margin:10;font-size: %d;} </style> </head> <body>%@</body> </html>", 20, content];
     */
    
    return nil;
}

/// html包含图片
- (BOOL)htmlContantImage
{
    NSArray *images = [self htmlStringFilterImages];
    BOOL result = (0 < images.count ? YES : NO);
    return result;
}

/// html中图片大小自适应屏幕大小
- (NSString *)htmlStringImageAutoSize
{
    NSString *content = self;
    if (content && 0 < content.length && content.htmlContantImage)
    {
        content = [content stringByReplacingOccurrencesOfString:@"<html>" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"</html>" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"<head>" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"</head>" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"</body>" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"</body>" withString:@""];
        content = [NSString stringWithFormat:@"<html> <head> </head> <body> <script type='text/javascript'> window.onload = function(){ var $img = document.getElementsByTagName('img'); for(var p in  $img){ $img[p].style.width = '100%%'; $img[p].style.height ='auto' } } </script>%@</body> </html>",content];
    }
    return content;
}

/// 修改html中图片大小的js代码
- (NSString *)htmlStringJSImageSizeWidth:(float)width
{
    return [NSString stringWithFormat:@"var script = document.createElement('script');script.type = 'text/javascript';script.text = \"function ResizeImages() { var imgs = document.getElementsByTagName('img');for (var i = 0; i < imgs.length; i ++) {var img = imgs[i];img.style.width = %@ ;img.style.height = null;}}\";document.getElementsByTagName('head')[0].appendChild(script);", @(width)];
}

/// 修改html的文字大小
- (NSString *)htmlStringFontSize:(int)fontsize
{
    NSString *content = self;
    if (content && 0 < content.length)
    {
        content = [content stringByReplacingOccurrencesOfString:@"<html>" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"</html>" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"<head>" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"</head>" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"</body>" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"</body>" withString:@""];
        content = [NSString stringWithFormat:@"<html> <head> <style type=\"text/css\"> body {margin:10;font-size: %@;} </style> </head> <body>%@</body> </html>", (self.htmlContantImage ? @(fontsize) : @(fontsize * 1.5)), content];
    }
    return content;
}

/// 过滤html中的图片数组
- (NSArray *)htmlStringFilterImages
{
    NSMutableArray *resultArray = [NSMutableArray array];
    if (self && 0 < self.length)
    {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
        NSArray *result = [regex matchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length)];
        
        for (NSTextCheckingResult *item in result)
        {
            NSRange range = [item rangeAtIndex:0];
            NSString *imgHtml = [self substringWithRange:range];
            NSArray *tmpArray = nil;
            if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound)
            {
                tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
            }
            else if ([imgHtml rangeOfString:@"src="].location != NSNotFound)
            {
                tmpArray = [imgHtml componentsSeparatedByString:@"src="];
            }
            
            for (NSString *image in tmpArray)
            {
                if ([image hasPrefix:@"https://"] || [image hasPrefix:@"http://"])
                {
                    NSRange range = [image rangeOfString:@".jpg"];
                    if (range.location == NSNotFound)
                    {
                        range = [image rangeOfString:@".png"];
                    }
                    if (range.location != NSNotFound)
                    {
                        NSString *url = [image substringToIndex:(range.location + range.length)];
                        [resultArray addObject:url];
                    }
                }
            }
        }
    }
    return resultArray;
}

@end
