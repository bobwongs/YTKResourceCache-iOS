//
//  YTKCacheFileFinder.h
//  YTKResourceCache
//
//  Created by lihaichun on 2019/1/3.
//

#import <Foundation/Foundation.h>
#import "YTKResourceCacheLoader.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTKCacheFileFinder : NSObject <YTKCacheFileFinder>

@property (nonatomic, copy) NSString *cacheDirectory;

- (instancetype)initWithCacheDirectory:(NSString *)cacheDirecoty;

@end

NS_ASSUME_NONNULL_END
