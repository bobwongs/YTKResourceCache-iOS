#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "YTKCacheFileFinder.h"
#import "YTKDownloadCacheLoader.h"
#import "YTKDownloadRequest.h"
#import "YTKDownloadRequestProtocol.h"
#import "YTKFileCacheLoader.h"
#import "YTKMimeTypeUtils.h"
#import "YTKResourceCache.h"
#import "YTKResourceCacheLoader.h"
#import "YTKURLProtocol.h"

FOUNDATION_EXPORT double YTKResourceCacheVersionNumber;
FOUNDATION_EXPORT const unsigned char YTKResourceCacheVersionString[];

