Pod::Spec.new do |s|
        s.name             = 'AppSpectorTVSDK'
        s.version          = '1.4.12'
        s.summary          = 'Debugging doesn\'t have to be painful!'
        s.homepage         = 'http://appspector.com'
        s.license          = { type: 'MIT', file: 'LICENSE' }
        s.author           = { 'Techery' => 'heroes@techery.io' }
        s.platform         = :tvos
        s.tvos.deployment_target = '11.0'
        s.source           = { :http => 'https://github.com/appspector/ios-sdk/releases/download/1.4.12/AppSpectorTVSDK.xcframework.zip' }
        s.tvos.vendored_frameworks = 'AppSpectorTVSDK.xcframework'
    end
