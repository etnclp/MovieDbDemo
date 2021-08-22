#
# Be sure to run `pod lib lint ERDNetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ERDNetwork'
  s.version          = '0.1.1'
  s.summary          = 'The network manager of iOS Apps'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/etnclp/ERDNetwork'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'etnclp' => 'tuncalperdi@gmail.com' }
  s.source           = { :git => 'https://github.com/etnclp/ERDNetwork.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.14'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '5.0'

  s.source_files = 'Sources/**/*'
  s.ios.frameworks = 'UIKit'

  # s.resource_bundles = {
  #   'ERDNetwork' => ['ERDNetwork/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'

end
