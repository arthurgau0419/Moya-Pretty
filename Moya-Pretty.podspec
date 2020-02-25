Pod::Spec.new do |s|
  s.name             = 'Moya-Pretty'
  s.version          = '3.0.0'
  s.summary          = 'Codable, ObjectMapper, RxSwift, PromiseKit, RESTful extensions for Moya.'
  s.description      = <<-DESC
    *Moya-Pretty* provides many convenient extensions like *generic class-based target*, *plugins*, even *RESTful traits*. This allows you to declare [Moya](https://github.com/Moya/Moya) Target more pretty and without writing those extensions again by yourself.
                       DESC

  s.homepage         = 'https://github.com/arthurgau0419/Moya-Pretty'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ObiCat' => 'arthurgau0419@gmail.com' }
  s.source           = { :git => 'https://github.com/arthurgau0419/Moya-Pretty.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Arthurgau'

  s.ios.deployment_target = '10.0'

  s.subspec 'Core' do |ss|
    ss.dependency 'Moya', '~> 14'
    ss.source_files = 'Moya-Pretty/Classes/**/*'
  end
  
  s.subspec 'Japx' do |ss|
    ss.source_files = 'Moya-Pretty/SubSpec/Japx/Sources/*'
    ss.dependency 'Moya-Pretty/Core'
    ss.dependency 'Japx/Codable'
  end

  s.subspec 'ObjectMapper' do |ss|
    ss.source_files = 'Moya-Pretty/SubSpec/ObjectMapper/Sources/*'
    ss.dependency 'Moya-Pretty/Core'
    ss.dependency 'ObjectMapper'
  end
  
  s.subspec 'XMLDictionary' do |ss|
    ss.source_files = 'Moya-Pretty/SubSpec/XMLDictionary/Sources/*'
    ss.dependency 'Moya-Pretty/ObjectMapper'
    ss.dependency 'XMLDictionary'
  end

  s.subspec 'PromiseKit' do |ss|
    ss.source_files = 'Moya-Pretty/SubSpec/Promise/Sources/*'
    ss.dependency 'Moya-Pretty/Core'
    ss.dependency 'PromiseKit'
  end

  s.subspec 'RxSwift' do |ss|
    ss.source_files = 'Moya-Pretty/SubSpec/RxSwift/Sources/*'
    ss.dependency 'Moya-Pretty/Core'
    ss.dependency 'Moya/RxSwift'
  end
  
  s.subspec 'ReactiveSwift' do |ss|
    ss.source_files = 'Moya-Pretty/SubSpec/ReactiveSwift/Sources/*'
    ss.dependency 'Moya-Pretty/Core'
    ss.dependency 'Moya/ReactiveSwift'
  end

  s.subspec 'RESTful' do |ss|
    ss.dependency 'Moya-Pretty/Core'
    ss.source_files = 'Moya-Pretty/SubSpec/RESTful/Sources/*'
  end

  s.subspec 'Plugins' do |ss|
    ss.dependency 'Moya-Pretty/Core'
    ss.source_files = 'Moya-Pretty/SubSpec/Plugins/Sources/*'
  end

  s.default_subspecs = ['Core']
  s.swift_versions = ['5.0', '5.1']
end
