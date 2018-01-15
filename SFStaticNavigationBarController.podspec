#
# Be sure to run `pod lib lint SFStaticNavigationBarController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SFStaticNavigationBarController'
  s.version          = '0.1.5'
  s.summary          = 'A a custom UINavigationController with a static navigation bar.'

  s.description      = <<-DESC
SFStaticNavigationBarController is a custom UINavigationController with a static navigation bar
• A custom navigation bar with 3 possible states and an indicator for these states
• Transitions from left and from right based on where you are and where you are navigating to
                        DESC

  s.homepage         = 'https://github.com/crystalSETH/SFStaticNavigationBarController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'crystalSETH' => 'sethfolley@gmail.com' }
  s.source           = { :git => 'https://github.com/crystalSETH/SFStaticNavigationBarController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SFStaticNavigationBarController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SFStaticNavigationBarController' => ['SFStaticNavigationBarController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
