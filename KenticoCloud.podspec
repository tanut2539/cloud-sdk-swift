#
# Be sure to run `pod lib lint KenticoCloud.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KenticoCloud'
  s.version          = '0.2.1'
  s.summary          = 'Swift SDK for Kentico Cloud'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Swift SDK for Kentico Cloud.
                       DESC

  s.homepage         = 'https://github.com/kentico/cloud-sdk-swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Martin Makarsky' => 'martinm@kentico.com' }
  s.source           = { :git => 'https://github.com/kentico/cloud-sdk-swift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/kenticocloud'

  s.ios.deployment_target = '8.3'
  s.osx.deployment_target = '10.11'
  s.watchos.deployment_target = '3.2'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'KenticoCloud/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KenticoCloud' => ['KenticoCloud/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AlamofireObjectMapper', '~> 4.0'
   s.dependency 'Kanna', '~> 2.2.0'
   s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
end
