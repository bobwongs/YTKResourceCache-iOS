//
//  YTKCacheFileFinder.m
//  YTKResourceCache
//
//  Created by lihaichun on 2019/1/3.
//

#import "YTKCacheFileFinder.h"

static NSString * const kYTKDefaultCacheDirectory = @"YTKResourceCache";

@interface YTKCacheFileFinder ()

@end

@implementation YTKCacheFileFinder

- (instancetype)init {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *folderPath = [documentPath stringByAppendingPathComponent:kYTKDefaultCacheDirectory];
    return [self initWithCacheDirectory:folderPath];
}

- (instancetype)initWithCacheDirectory:(NSString *)cacheDirecoty {
    self = [super init];
    if (self) {
        _cacheDirectory = cacheDirecoty;
    }
    return self;
}

#pragma mark - YTKCacheFileFinder

- (NSString *)getCacheFilePathFromRequest:(NSURLRequest *)request {
    NSString *url = request.URL.absoluteString;
    NSString *filePath = [self getFileNameFromRemoteUrl:url];
    filePath = [self.cacheDirectory stringByAppendingPathComponent:filePath];
    NSString *fileDirectory = [filePath stringByDeletingLastPathComponent];
    [self checkDirectoryIfNotExistCreate:fileDirectory];
    return filePath;
}

- (void)checkDirectoryIfNotExistCreate:(NSString *)directory {
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDirectory = YES;
    if (NO == [manager fileExistsAtPath:directory isDirectory:&isDirectory] || isDirectory == NO) {
        NSError *error;
        BOOL success = [manager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error];
        if (success == NO) {
            NSLog(@"%@", error.localizedDescription);
        }
    }
}

- (NSString *)getFileNameFromRemoteUrl:(NSString *)url {
    if (NO == [url isKindOfClass:[NSString class]] || url.length <= 0) {
        return @"";
    }
    NSArray *arr = [url componentsSeparatedByString:@"://"];
    if (arr.count < 2) {
        return @"";
    }
    NSString *fileName = arr.lastObject;
    return fileName;
}

@end
