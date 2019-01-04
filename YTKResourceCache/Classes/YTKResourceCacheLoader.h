//
//  YTKResourceCacheLoader.h
//  YTKResourceCache
//
//  Created by lihaichun on 2019/1/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YTKCacheFileFinder <NSObject>

/** http远端地址与本地文件对应关系 */
- (NSString *)getCacheFilePathFromRequest:(NSURLRequest *)request;

@end


@protocol YTKResourceCacheProtocol <NSObject>

/** 根据request查找cache file，用户可以设置自己的fileFinder */
@property (nonatomic, weak, nullable) id<YTKCacheFileFinder> fileFinder;

/** 判断是否拦截处理request */
- (BOOL)hasCacheWithRequest:(NSURLRequest *)request;

/** 给出request对应的应答数据 */
- (void)loadDataWithRequest:(NSURLRequest *)request completion:(void (^)(NSData *data, NSError *error))completion;

@end

@protocol YTKResourceCacheLoader <NSObject>

+ (BOOL)hasResourceCacheWithRequest:(NSURLRequest *)request;

+ (nullable id<YTKResourceCacheProtocol>)getResourceCacheWithRequest:(NSURLRequest *)request;

@end

NS_ASSUME_NONNULL_END
