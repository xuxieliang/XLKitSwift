Pod::Spec.new do |s|
  s.name         = 'XLKitSwift'
  s.version      = '0.1.0'
  s.summary      = 'Your library description here'
  s.homepage     = 'https://github.com/xuxieliang/XLKitSwift.git'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'xuxieliang' => '289417621@qq.com' }
  s.source       = { :git => 'https://github.com/xuxieliang/XLKitSwift.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.dependency 'HandyJSON', '~> 5.0.2'
  s.source_files = 'YXKitSwift/**/*.{h,swift}'  # 匹配.h和.swift文件
  s.public_header_files = 'YXKitSwift/**/*.h'    # 公开头文件
  s.ios.deployment_target = "11.0"

end
