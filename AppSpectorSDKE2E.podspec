Pod::Spec.new do |s|
   s.name             = 'AppSpectorSDKE2E'
   s.version          = '1.3.6'
   s.summary          = 'Debugging doesn\'t have to be painful!'
   s.homepage         = 'http://appspector.com'
   s.license          = { type: 'MIT', file: 'LICENSE' }
   s.author           = { 'Techery' => 'heroes@techery.io' }
   s.platform         = :ios
   s.ios.deployment_target = '9.3'
   s.source           = { :http => 'https://github.com/appspector/ios-sdk/blob/master/AppSpectorSDKE2E.zip?raw=true' }
   s.ios.vendored_frameworks = 'AppSpectorSDKE2E.framework'
   s.dependency 'themis/themis-openssl'
   s.pod_target_xcconfig = {
     'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
   }
   s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
