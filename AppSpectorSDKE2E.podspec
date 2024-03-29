Pod::Spec.new do |s|
        s.name             = 'AppSpectorSDKE2E'
        s.version          = '1.4.10'
        s.summary          = 'Debugging doesn\'t have to be painful!'
        s.homepage         = 'http://appspector.com'
        s.license          = { type: 'MIT', file: 'LICENSE' }
        s.author           = { 'Techery' => 'heroes@techery.io' }
        s.platform         = :ios
        s.ios.deployment_target = '11.0'
        s.source           = { :http => 'https://github.com/appspector/ios-sdk/releases/download/1.4.10/AppSpectorSDKE2E.xcframework.zip' }
        s.ios.vendored_frameworks = 'AppSpectorSDKE2E.xcframework'
        s.dependency 'themis', '0.14.0'
    end
