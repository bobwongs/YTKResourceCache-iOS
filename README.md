# YTKResourceCache

[![CI Status](https://img.shields.io/travis/lihc/YTKResourceCache.svg?style=flat)](https://travis-ci.org/yuantiku/YTKResourceCache-iOS)
[![Version](https://img.shields.io/cocoapods/v/YTKResourceCache.svg?style=flat)](https://cocoapods.org/pods/YTKResourceCache)
[![License](https://img.shields.io/cocoapods/l/YTKResourceCache.svg?style=flat)](https://cocoapods.org/pods/YTKResourceCache)
[![Platform](https://img.shields.io/cocoapods/p/YTKResourceCache.svg?style=flat)](https://cocoapods.org/pods/YTKResourceCache)

## YTKResourceCache 是什么

YTKResourceCache 是针对请求拦截、请求发送、请求应答数据缓存读写的一整套封装的工具类，主要依赖NSURLProtocol来实现。


## YTKResourceCache 提供了哪些功能

 * 支持拦截所有的网络请求，可以配置只拦截webView 请求。
 * 支持针对Get请求的拦截进行资源下载以及缓存写入，针对拦截的非Get请求，需要使用者自己定制请求行为。
 
 
 ## 哪些项目适合使用 YTKResourceCache
 
YTKResourceCache 适合ObjectC实现的项目，并且项目中对于请求有拦截需求、对于Get资源请求有缓存需求的项目，YTKResourceCache会提供一整套解决方案，可以节省开发成本


## YTKResourceCache 的基本思想

YTKResourceCache一共提供两种能力，请求拦截与资源下载缓存写入读取。

请求拦截主要基于NSURLProtocol来实现，可以指定知否拦截请求，如果拦截请求就要负责给出拦截请求的应答数据，缓存数据可以从本地缓存读取，也可以从实际网络请求返回读取。

资源下载缓存读取与写入，主要依赖YTKNetwork来实现，如果Get请求被拦截并且没有命中本地缓存，那么就会根据当前Get请求下载资源并根据一定的规则写入磁盘，并将文件内容返回给拦截的网络请求，这样下次拦截该请求就会命中缓存直接返回缓存数据；如果是非Get请求，需要用户判断是否拦截请求，如果拦截请求，需要给出获取应答数据的方法。


## 安装

你可以在Podfile中加入下面一行代码来使用YTKResourceCache

```ruby
pod 'YTKResourceCache'
```


## 安装要求

| YTKResourceCache 版本 |  最低 iOS Target | 注意 |
|:----------------:|:----------------:|:-----:|
| 0.1.0 | iOS 7 | 要求 Xcode 7 以上 |


## 例子

clone当前repo， 到Example目录下执行`pod install`命令，就可以运行例子工程


## 使用方法

这里以YTKResourceCache默认设置：查询沙盒缓存文件作为拦截WebView get请求的条件为例，如下所示：

```objective-c
// YTKResourceCache 拦截WebView 请求默认设置（拦截WebView发送的Get请求、使用默认的文件查询策略查询沙盒文件，查询命中拦截，否则不拦截）
[[YTKResourceCache sharedCache] handleWebRequest];

UIWebView *webView = [UIWebView alloc] init];
// webView 加载URL代码略过
```

更多用法，设置缓存loader，下面是以设置YTKDownloadCacheLoader作为带有下载请求能力的loader为例：

```objective-c
id<YTKResourceCacheProtocol> cacheLoader = [[YTKDownloadCacheLoader alloc] init];
// 设置请求拦截数据返回方式
[[YTKResourceCache sharedCache] setCacheLoader:cacheLoader]; 
```

设置文件查找规则，下面是以设置默认文件查找规则为例：

```objective-c
id<YTKCacheFileFinder> fileFinder = [YTKCacheFileFinder new];
// 设置查找文件规则
```

设置HTTPMethod过滤规则，下面是以不根据请求HTTPMethod进行过滤为例：

```objective-c
// 设置不根据HTTPMethod Header进行拦截
[[YTKResourceCache sharedCache] setInterceptMethod:nil];
```

设置User-Agent过滤规则，下面是以不根据User-Agent进行过滤为例：

```objective-c
// 设置不根据User-Agent Header进行拦截
[[YTKResourceCache sharedCache] setWebViewUserAgentPattern:nil];
```


## 作者

YTKResourceCache 的主要作者是：

lihc， https://github.com/xiaochun0618


## 协议

YTKResourceCache 被许可在 MIT 协议下使用。查阅 LICENSE 文件来获得更多信息。

