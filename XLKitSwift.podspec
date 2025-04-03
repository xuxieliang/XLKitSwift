Pod::Spec.new do |s|
  s.name         = 'XLKitSwift'
  s.version      = '0.1.0'
  s.summary      = '一个实用的 Swift 工具库，提供常用的开发工具和扩展'
  s.description  = 'XLKitSwift 是一个功能丰富的 Swift 工具库，提供了大量实用的开发工具和扩展，帮助开发者提高开发效率。'
  s.homepage     = 'https://github.com/xuxieliang/XLKitSwift'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'xuxieliang' => '289417621@qq.com' }
  s.source       = { :git => 'https://github.com/xuxieliang/XLKitSwift.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.swift_versions = ['5.0']
  
  s.source_files = 'XLKitSwift/**/*.{swift,h,m}'
  # s.public_header_files = 'XLKitSwift/YXKitSwift.h'
  
  s.pod_target_xcconfig = {
    'SWIFT_OPTIMIZATION_LEVEL' => '-Onone'
  }
  
  s.user_target_xcconfig = {
    'IPHONEOS_DEPLOYMENT_TARGET' => '$(inherited)'
  }

  s.dependency 'HandyJSON', '~> 5.0.2'
end
