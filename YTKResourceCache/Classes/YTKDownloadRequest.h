//
//  YTKDownloadRequest.h
//  YTKResourceCache
//
//  Created by lihaichun on 2019/1/2.
//

#import <YTKNetwork/YTKNetwork.h>
#import "YTKDownloadRequestProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTKDownloadRequest : YTKRequest

@property (nonatomic, weak, nullable) id<YTKDownloadRequestProtocol> progressDelegate;

@property (nonatomic, copy, nonnull) NSString *resourceUrl;

- (nullable instancetype)initWithResourceUrl:(NSString *)url
                                    localUrl:(NSString *)localUrl;

@end

NS_ASSUME_NONNULL_END
