//
//  YTKMimeTypeUtils.m
//  YTKResourceCache
//
//  Created by lihaichun on 2019/1/3.
//

#import "YTKMimeTypeUtils.h"

@implementation YTKMimeTypeUtils

+ (NSDictionary *)supportMimeTypes {
    static dispatch_once_t onceToken;
    static NSDictionary *mimeTypes;
    dispatch_once(&onceToken, ^{
        mimeTypes = @{
                      @"png": @"image/png",
                      @"jpg": @"image/jpg",
                      @"jpeg": @"image/jpeg",
                      @"gif": @"image/gif",
                      @"svg": @"image/svg+xml",
                      @"tif": @"image/tiff",
                      @"tiff": @"image/tiff",
                      @"webp": @"image/webp",
                      @"ico": @"image/x-icon",
                      @"m4a": @"audio/mp4a-latm",
                      @"m4v": @"video/x-m4v",
                      @"wav": @"audio/wav",
                      @"aac": @"audio/aac",
                      @"mpeg": @"video/mpeg",
                      @"mp3": @"audio/mp3",
                      @"webm": @"video/webm",
                      @"weba": @"video/webm",
                      @"oga": @"audio/ogg",
                      @"ogv": @"video/ogg",
                      @"avi": @"video/x-msvideo",
                      @"mp4": @"video/mp4",
                      @"m3u8": @"application/x-mpegURL",
                      @"h264": @"video/h264",
                      @"flv": @"video/x-flv",
                      @"ts": @"video/MP2T",
                      @"mov": @"video/quicktime",
                      @"wmv": @"video/x-ms-wmv",
                      @"3gp": @"video/3gpp",
                      @"xml": @"application/xml",
                      @"js": @"application/javascript; charset=utf-8",
                      @"json": @"application/json;charset=utf-8",
                      @"html": @"text/html; charset=utf-8",
                      @"jar": @"application/java-archive",
                      @"woff": @"font/woff",
                      @"ttf": @"application/x-font-ttf",
                      @"otf": @"application/x-font-otf",
                      @"abw": @"application/x-abiword",
                      @"arc": @"application/octet-stream",
                      @"bz": @"application/x-bzip",
                      @"bz2": @"application/x-bzip2",
                      @"csh": @"application/x-csh",
                      @"css": @"text/css",
                      @"csv": @"text/css",
                      @"doc": @"application/msword",
                      @"ics": @"text/calendar",
                      @"aspx": @"text/html; charset=utf-8",
                      };
    });
    return mimeTypes;
}

+ (NSString *)mimeTypeOfPathExtension:(NSString*)pathExtension {
    return [self supportMimeTypes][pathExtension];
}

@end
