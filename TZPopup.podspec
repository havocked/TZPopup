Pod::Spec.new do |s|
  s.name     = 'TZPopup'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.summary  = "Pop any viewcontrollers you want, easily, with some stylish animations (work in progress :p)"
  s.homepage = 'https://github.com/havocked/TZPopup'
  s.authors  = { 'Nataniel Martin' =>
                 'nmartin@appstud.me' }
  s.social_media_url = "https://twitter.com/NatanielMartin"
  s.source   = { :git => 'https://github.com/havocked/TZPopup.git', :tag => '0.0.1' }
  s.source_files = 'TZPopup.{h,m}'
  s.platform = :ios, '7.0'
  s.requires_arc = true
  s.dependency 'FXBlurView'

s.subspec 'UIKit' do |ss|
    ss.ios.deployment_target = '6.0'

    ss.ios.public_header_files = 'UIKit+TZPopup/*.h'
    ss.ios.source_files = 'UIKit+TZPopup'
    ss.osx.source_files = ''
  end

end