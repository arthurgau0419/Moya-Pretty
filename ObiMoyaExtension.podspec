#
# Be sure to run `pod lib lint ObiMoyaExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ObiMoyaExtension'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ObiMoyaExtension.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/arthurgau0419@gmail.com/ObiMoyaExtension'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'arthurgau0419@gmail.com' => 'arthurgau0419@gmail.com' }
  s.source           = { :git => 'https://github.com/arthurgau0419@gmail.com/ObiMoyaExtension.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  # s.resource_bundles = {
  #   'ObiMoyaExtension' => ['ObiMoyaExtension/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  # s.dependency 'Moya', '~> 11.0'
  # s.dependency 'Moya/RxSwift'

  s.subspec 'Core' do |ss|
    ss.dependency 'Moya', '~> 11.0'
    ss.source_files = 'ObiMoyaExtension/Classes/**/*'
  end
  
  s.subspec 'ObjectMapper' do |ss|
    ss.source_files = 'ObiMoyaExtension/SubSpec/ObjectMapper/Sources/*'
    ss.dependency 'ObiMoyaExtension/Core'
    ss.dependency 'ObjectMapper'
  end

  s.subspec 'Promise' do |ss|
    ss.source_files = 'ObiMoyaExtension/SubSpec/Promise/Sources/*'
    ss.dependency 'ObiMoyaExtension/Core'
    ss.dependency 'PromiseKit'
  end

  s.subspec 'RxSwift' do |ss|
    ss.source_files = 'ObiMoyaExtension/SubSpec/RxSwift/Sources/*'
    ss.dependency 'ObiMoyaExtension/Core'
    ss.dependency 'Moya/RxSwift'
  end

  s.subspec 'RESTful' do |ss|
    ss.source_files = 'ObiMoyaExtension/SubSpec/RESTful/Sources/*'    
  end
  
  s.subspec 'Plugins' do |ss|
    ss.source_files = 'ObiMoyaExtension/SubSpec/Plugins/Sources/*'
  end
  
  s.default_subspecs = ['Core']
  s.swift_version = '4.1'
end
