//
//  YTKDownloadRequest.m
//  YTKResourceCache
//
//  Created by lihaichun on 2019/1/2.
//

#import "YTKDownloadRequest.h"
#import "YTKBaseRequest.h"

@interface YTKDownloadRequest ()

/** download resource url */
@property (nonatomic, copy, nonnull) NSString *localUrl;

@end

@implementation YTKDownloadRequest

- (instancetype)initWithResourceUrl:(NSString *)url
                           localUrl:(NSString *)localUrl {
    self = [super init];
    if (self) {
        _resourceUrl = url;
        _localUrl = localUrl;
    }
    return self;
}

/** 重写Getter方法，BZRequestUitl使用该属性判断是否更新本地时间差 */
- (NSString *)baseUrl {
    return nil;
}

- (NSString *)requestUrl {
    return self.resourceUrl;
}

- (NSString *)resumableDownloadPath {
    return _localUrl;
}

- (YTKResponseSerializerType)responseSerializerType {
    return YTKResponseSerializerTypeHTTP;
}

- (NSTimeInterval)requestTimeoutInterval {
    return 60;
}

- (AFURLSessionTaskProgressBlock)resumableDownloadProgressBlock {
    return ^(NSProgress *progress) {
        [self callProgressDelegateWithProgress:progress];
    };
}

#pragma mark - Override

- (void)requestCompleteFilter {
    [super requestCompleteFilter];

    if (self.responseStatusCode == 404) {
        [[NSFileManager defaultManager] removeItemAtPath:self.localUrl error:nil];
    }
}

#pragma mark - Utils

- (void)callProgressDelegateWithProgress:(NSProgress *)progress {
    if (![self.progressDelegate respondsToSelector:@selector(downloadRequest:didDownloadWithPercent:completedUnit:totalUnit:)]) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressDelegate downloadRequest:self
                        didDownloadWithPercent:progress.fractionCompleted
                                 completedUnit:progress.completedUnitCount
                                     totalUnit:progress.totalUnitCount];
    });
}

@end
