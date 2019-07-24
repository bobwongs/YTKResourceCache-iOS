#
# Be sure to run `pod lib lint YTKResourceCache.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YTKResourceCache'
  s.version          = '0.1.1'
  s.summary          = 'YTKResourceCache is used to intercept HTTP request and request download cache.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
YTKResourceCache use NSURLProtocol to implement intercept http request ability, and load disk file as the response data, also could download the request file to save in disk file.
                       DESC

  s.homepage         = 'https://github.com/yuantiku/YTKResourceCache-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lihc' => 'lihc@fenbi.com' }
  s.source           = { :git => 'https://github.com/yuantiku/YTKResourceCache-iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.source_files = 'YTKResourceCache/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YTKResourceCache' => ['YTKResourceCache/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'YTKNetwork', '~> 2.0'
end
