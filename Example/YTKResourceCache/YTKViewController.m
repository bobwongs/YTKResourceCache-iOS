//
//  YTKViewController.m
//  YTKResourceCache
//
//  Created by lihc on 01/02/2019.
//  Copyright (c) 2019 lihc. All rights reserved.
//

#import "YTKViewController.h"
#import "YTKResourceCache.h"
#import "YTKDownloadCacheLoader.h"

@interface YTKViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation YTKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[YTKResourceCache sharedCache] handleWebRequest];
    id<YTKCacheFileFinder> fileFinder = [YTKCacheFileFinder new];
    id<YTKResourceCacheProtocol> cacheLoader = [[YTKDownloadCacheLoader alloc] initWithFileFinder:fileFinder];
    [[YTKResourceCache sharedCache] setCacheLoader:cacheLoader];
    [[YTKResourceCache sharedCache] setFileFinder:fileFinder];
    [[YTKResourceCache sharedCache] setInterceptMethod:nil];
    [[YTKResourceCache sharedCache] setWebViewUserAgentPattern:nil];

    NSURL *URL = [NSURL URLWithString:@"https://www.quanjing.com/imgbuy/QJ6919057308.html"];
    [self.view addSubview:self.webView];
    self.webView.frame = self.view.frame;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (UIWebView *)webView {
    if (nil == _webView) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}

@end
