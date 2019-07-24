//
//  YTKMimeTypeUtils.h
//  YTKResourceCache
//
//  Created by lihaichun on 2019/1/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTKMimeTypeUtils : NSObject

+ (NSDictionary *)supportMimeTypes;

+ (nullable NSString *)mimeTypeOfPathExtension:(NSString*)pathExtension;

@end

NS_ASSUME_NONNULL_END
