Pod::Spec.new do |s|
    s.name             = "AppSpectorSDK"
    s.version          = "0.2"
    s.summary          = "Debugging doesn't have to be painful!"
    s.homepage         = "http://appspector.com"
    s.license          = { type: 'MIT', file: 'LICENSE' }
    s.author           = { "Techery" => "heroes@techery.io" }
    s.platform         = :ios
    s.source           = { :http => 'https://github.com/appspector/ios-sdk/blob/master/AppSpectorSDK.zip?raw=true' }
    s.ios.deployment_target = '8.0'
    s.ios.vendored_frameworks = 'AppSpectorSDK.framework'
    s.dependency 'SocketRocket'
    s.dependency 'MPMessagePack'
    s.dependency 'fishhook', '~> 0.2'
end
