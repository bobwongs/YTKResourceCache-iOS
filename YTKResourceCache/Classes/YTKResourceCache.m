//
//  YTKResourceCache.m
//  YTKResourceCache
//
//  Created by lihaichun on 2019/1/3.
//

#import "YTKResourceCache.h"
#import "YTKURLProtocol.h"
#import "YTKFileCacheLoader.h"
#import "YTKCacheFileFinder.h"

static NSString * const kDefaultWebViewUserAgentPattern = @"^Mozilla.*Mac OS X.*";

@interface YTKResourceCache ()

@end

@implementation YTKResourceCache

+ (instancetype)sharedCache {
    static id sharedCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCache = [[self alloc] init];
    });
    return sharedCache;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [NSURLProtocol registerClass:[YTKURLProtocol class]];
        _interceptMethod = @"GET";
        _cacheLoader = [[YTKFileCacheLoader alloc] initWithFileFinder:[YTKCacheFileFinder new]];
    }
    return self;
}

- (void)handleWebRequest {
    self.webViewUserAgentPattern = kDefaultWebViewUserAgentPattern;
}

#pragma mark - YTKResourceCacheLoader

+ (BOOL)hasResourceCacheWithRequest:(NSURLRequest *)request {
    NSString *userAgent = request.allHTTPHeaderFields[@"User-Agent"];
    NSString *method = request.HTTPMethod;
    NSString *pattern = [YTKResourceCache sharedCache].webViewUserAgentPattern;
    /** 过滤User-Agent */
    if (pattern && userAgent) {
        NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
        NSTextCheckingResult *match = [regex firstMatchInString:userAgent options:0 range:NSMakeRange(0, userAgent.length)];
        if (match == nil) {
            return NO;
        }
    }
    /** 过滤请求类型 */
    if ([YTKResourceCache sharedCache].interceptMethod && NO == [method isEqualToString:[YTKResourceCache sharedCache].interceptMethod]) {
        return NO;
    }
    /** 判断是否拦截请求 */
    YTKFileCacheLoader *loader = [YTKResourceCache sharedCache].cacheLoader;
    return [loader hasCacheWithRequest:request];
}

+ (nullable id<YTKResourceCacheProtocol>)getResourceCacheWithRequest:(NSURLRequest *)request {
    return [YTKResourceCache sharedCache].cacheLoader;
}

#pragma mark - Properties

- (void)setFileFinder:(id<YTKCacheFileFinder>)fileFinder {
    _fileFinder = fileFinder;
    self.cacheLoader.fileFinder = fileFinder;
}

@end
