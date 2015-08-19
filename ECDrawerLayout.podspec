#
# Be sure to run `pod lib lint ECDrawerLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ECDrawerLayout"
  s.version          = "0.1.2"
  s.summary          = "A DrawerLayout on iOS"

  s.description      = <<-DESC
                        DrawerLayout acts as a top-level container for window content that allows for interactive "drawer" views to be pulled out from the edge of the window.
                       DESC

  s.homepage         = "https://github.com/skyhacker2/ECDrawerLayout"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Eleven Chen" => "skyhacker@126.com" }
  s.source           = { :git => "https://github.com/skyhacker2/ECDrawerLayout.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ECDrawerLayout' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
