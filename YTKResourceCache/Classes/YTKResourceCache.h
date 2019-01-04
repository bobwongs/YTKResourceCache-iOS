//
//  YTKResourceCache.h
//  YTKResourceCache
//
//  Created by lihaichun on 2019/1/3.
//

#import <Foundation/Foundation.h>
#import "YTKResourceCacheLoader.h"
#import "YTKCacheFileFinder.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTKResourceCache : NSObject <YTKResourceCacheLoader>

/**
 request对应的本地文件查找对象，默认为YTKCacheFileFinder
 用户可以设置自己定制的fileFinder
 */
@property (nonatomic, strong) id<YTKCacheFileFinder> fileFinder;

/**
 获取request应答数据对象，默认为YTKFileCacheLoader
 用户可以设置自己定制的cacheLoader或者设置为YTKResourceCache提供的YTKDownloadCacheLoader
 */
@property (nonatomic, strong) id<YTKResourceCacheProtocol> cacheLoader;

/**
 用于根据请求的User-Agent进行过滤，用户可以设置自己的userAgent pattern
 如果设置为nil，则不根据User-Agent进行过滤
 */
@property (nonatomic, strong, nullable) NSString *webViewUserAgentPattern;

/**
 根据请求HTTPMethod来过滤请求，用户可以进行配置，值为GET、POST、PUT等，默认为GET
 如果设置为nil，则不根据HTTPMethod进行过滤
 */
@property (nonatomic, strong, nullable) NSString *interceptMethod;

+ (instancetype)sharedCache;

/**
 根据默认webView请求的User-Agent进行过滤
 如果有特殊的User-Agent设置，可以通过webViewUserAgentPattern来定制
 */
- (void)handleWebRequest;

@end

NS_ASSUME_NONNULL_END
