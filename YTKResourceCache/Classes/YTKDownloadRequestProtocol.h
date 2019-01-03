//
//  YTKDownloadRequestProtocol.h
//  YTKResourceCache
//
//  Created by lihaichun on 2019/1/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YTKRequest;

@protocol YTKDownloadRequestProtocol <NSObject>

@optional
- (void)downloadRequest:(YTKRequest *)request
 didDownloadWithPercent:(double)percent
          completedUnit:(long long)completed
              totalUnit:(long long)total;

@end

NS_ASSUME_NONNULL_END
