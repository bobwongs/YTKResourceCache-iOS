//
//  YTKDownloadCacheLoader.h
//  YTKResourceCache
//
//  Created by lihaichun on 2019/1/3.
//

#import <Foundation/Foundation.h>
#import "YTKResourceCacheLoader.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTKDownloadCacheLoader : NSObject <YTKResourceCacheProtocol>

- (instancetype)initWithFileFinder:(id<YTKCacheFileFinder>)fileFinder;

@end

NS_ASSUME_NONNULL_END
