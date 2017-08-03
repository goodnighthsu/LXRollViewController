#
# Be sure to run `pod lib lint LXRollViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LXRollViewController'
  s.version          = '0.2.1'
  s.summary          = '简单的无限轮播ViewController'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

 s.homepage         = 'https://github.com/goodnighthsu/LXRollViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'leon.xu' => 'goodnighthsu@msn.com' }
  s.source           = { :git => 'https://github.com/goodnighthsu/LXRollViewController.git', :tag => '0.2.1' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'LXRollViewController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LXRollViewController' => ['LXRollViewController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Masonry'
  s.dependency 'SDWebImage'

end
