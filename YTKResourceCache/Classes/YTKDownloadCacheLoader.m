//
//  YTKDownloadCacheLoader.m
//  YTKResourceCache
//
//  Created by lihaichun on 2019/1/3.
//

#import "YTKDownloadCacheLoader.h"
#import "YTKDownloadRequest.h"
#import "YTKMimeTypeUtils.h"

@interface YTKDownloadCacheLoader ()

@property (nonatomic, strong) YTKDownloadRequest *downloadRequest;

@property (nonatomic, strong) NSArray *supportFileTypes;

@end

@implementation YTKDownloadCacheLoader

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
    if ([request.HTTPMethod isEqualToString:@"GET"] && [self.supportFileTypes containsObject:request.URL.pathExtension]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)loadDataWithRequest:(NSURLRequest *)request completion:(void (^)(NSData *data, NSError *error))completion {
    NSString *filePath = [self.fileFinder getCacheFilePathFromRequest:request];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data) {
        if (completion) {
            completion(data, nil);
        }
        return;
    }
    self.downloadRequest = [[YTKDownloadRequest alloc] initWithResourceUrl:request.URL.absoluteString localUrl:filePath];
    [self.downloadRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (completion) {
            completion(data, nil);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (completion) {
            completion(nil, request.error);
        }
    }];
}

- (void)stopLoadingRequest:(NSURLRequest *)request {
}

- (NSArray *)supportFileTypes {
    if (nil == _supportFileTypes) {
        _supportFileTypes = [[YTKMimeTypeUtils supportMimeTypes] allKeys];
    }
    return _supportFileTypes;
}

@end
