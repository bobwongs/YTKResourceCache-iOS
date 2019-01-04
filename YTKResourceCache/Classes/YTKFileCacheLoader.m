//
//  YTKFileCacheLoader.m
//  YTKResourceCache
//
//  Created by lihaichun on 2019/1/3.
//

#import "YTKFileCacheLoader.h"

@interface YTKFileCacheLoader ()

@end

@implementation YTKFileCacheLoader

@synthesize fileFinder;

- (instancetype)initWithFileFinder:(id<YTKCacheFileFinder>)fileFinder {
    self = [super init];
    if (self) {
        self.fileFinder = fileFinder;
    }
    return self;
}

#pragma mark - YTKResourceCacheProtocol

- (BOOL)hasCacheWithRequest:(NSURLRequest *)request {
    NSData *data = [self cacheDataWithRequest:request];
    return data ? YES : NO;
}

- (void)loadDataWithRequest:(NSURLRequest *)request completion:(void (^)(NSData *data, NSError *error))completion {
    NSData *data = [self cacheDataWithRequest:request];
    if (data) {
        if (completion) {
            completion(data, nil);
        }
    } else {
        if (completion) {
            completion(data, [NSError errorWithDomain:@"YTKFileCacheNil" code:0 userInfo:nil]);
        }
    }
}

- (void)stopLoadingRequest:(NSURLRequest *)request {
}

#pragma mark - Utils

- (NSData *)cacheDataWithRequest:(NSURLRequest *)request {
    NSString *filePath = nil;
    if ([self.fileFinder respondsToSelector:@selector(getCacheFilePathFromRequest:)]) {
        filePath = [self.fileFinder getCacheFilePathFromRequest:request];
    }
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
}

@end
