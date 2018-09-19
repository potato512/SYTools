Pod::Spec.new do |s|
  s.name         = "SYTools"
  s.version      = "1.0.3"
  s.summary      = "SYTools contant tools such as refresh, cache manager, hud manager and so on."
  s.homepage     = "https://github.com/potato512/SYTools"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "herman" => "zhangsy757@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/potato512/SYTools.git", :tag => s.version.to_s }
  s.source_files = 'SYTools/**/*.{h,m}'
  s.requires_arc = true
  s.frameworks = 'UIKit', 'CoreFoundation', 'Security'
  s.dependency 'SYCategory'
  s.dependency 'SAMKeychain'
  s.dependency 'AFNetworking'
  s.dependency 'MBProgressHUD'
  s.dependency 'MJRefresh'
  s.dependency 'YYKit'
  s.dependency 'FMDB'
  s.dependency 'LKDBHelper'
end