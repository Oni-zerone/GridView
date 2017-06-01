#
# Be sure to run `pod lib lint GridView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GridView'
  s.version          = '0.1.0'
  s.summary          = 'A GridView with multiple columns layout and doubled directions.'

  s.description      = <<-DESC
A StackView under steroids,
with this view you could declare staggered views with multiple columns or multiple rows.
                       DESC

  s.homepage         = 'https://github.com/Oni-zerone/GridView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'acct<blob>=<NULL>' => 'oni.zerone@gmail.com' }
  s.source           = { :git => 'https://github.com/acct<blob>=<NULL>/GridView.git', :tag => s.version.to_s }
   s.social_media_url = 'https://twitter.com/oni_zerone'

  s.ios.deployment_target = '8.0'

  s.source_files = 'GridView/Classes/**/*'
end
