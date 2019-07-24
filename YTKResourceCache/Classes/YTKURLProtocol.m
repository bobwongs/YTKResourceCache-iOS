//
//  YTKURLProtocol.m
//  YTKResourceCache
//
//  Created by lihaichun on 2019/1/3.
//

#import "YTKURLProtocol.h"
#import "YTKResourceCache.h"
#import "YTKMimeTypeUtils.h"

@interface YTKCacheLoaderSingleton : NSObject

+ (instancetype)sharedSingleton;

@property (nonatomic, strong) id<YTKResourceCacheProtocol> loader;

@end

static NSString * const kFilterLoopRequestKey = @"kFilterLoopRequestKey";
NSString * const YTKCacheProtocolNotImplemented = @"YTKCacheProtocolNotImplemented";

@implementation YTKURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if ([NSURLProtocol propertyForKey:kFilterLoopRequestKey inRequest:request]) {
        return NO;
    }

    BOOL hasCache = [YTKResourceCache hasResourceCacheWithRequest:request];
    if (hasCache) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (id)initWithRequest:(NSURLRequest *)request cachedResponse:(NSCachedURLResponse *)cachedResponse client:(id<NSURLProtocolClient>)client {
    return [super initWithRequest:request cachedResponse:cachedResponse client:client];
}

- (void)startLoading {
    NSMutableURLRequest *mutableRequest = [self.request mutableCopy];
    [NSURLProtocol setProperty:@YES forKey:kFilterLoopRequestKey inRequest:mutableRequest];

    id<YTKResourceCacheProtocol> loader = [YTKResourceCache getResourceCacheWithRequest:mutableRequest];
    if ([loader respondsToSelector:@selector(loadDataWithRequest:completion:)]) {
        [loader loadDataWithRequest:mutableRequest completion:^(NSData * _Nonnull data, NSError * _Nonnull error) {
            if (error) {
                [self.client URLProtocol:self didFailWithError:error];
                return;
            }
            NSString *mimeType = [YTKMimeTypeUtils mimeTypeOfPathExtension:self.request.URL.pathExtension];
            NSMutableDictionary *headers = @{@"Content-Length" : @(data.length).stringValue}.mutableCopy;
            if (mimeType) {
                [headers setObject:mimeType forKey:@"Content-Type"];
            }
            if ([YTKResourceCache respondsToSelector:@selector(extraResponseHeader)]) {
                NSDictionary *extraHeader = [YTKResourceCache extraResponseHeader];
                if ([extraHeader isKindOfClass:[NSDictionary class]]) {
                    [headers addEntriesFromDictionary:extraHeader];
                }
            }

            NSHTTPURLResponse* response = [[NSHTTPURLResponse alloc] initWithURL:self.request.URL statusCode:200 HTTPVersion:@"HTTP/1.1" headerFields:headers];
            [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowedInMemoryOnly];
            [self.client URLProtocol:self didLoadData:data];
            [self.client URLProtocolDidFinishLoading:self];
        }];
    } else {
        [self.client URLProtocol:self didFailWithError:[NSError errorWithDomain:YTKCacheProtocolNotImplemented code:0 userInfo:@{}]];
    }
}

- (void)stopLoading {
}

@end
