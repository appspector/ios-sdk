Pod::Spec.new do |s|
    s.name             = 'AppSpectorTVSDK'
    s.version          = '1.4.3'
    s.summary          = 'Debugging doesn\'t have to be painful!'
    s.homepage         = 'http://appspector.com'
    s.license          = { type: 'MIT', file: 'LICENSE' }
    s.author           = { 'Techery' => 'heroes@techery.io' }
    s.platform         = :tvos
    s.tvos.deployment_target = '10.0'
    s.tvos.vendored_frameworks = 'AppSpectorTVSDK.framework'
    s.source           = { :http => 'https://github.com/appspector/ios-sdk/blob/master/AppSpectorTVSDK.zip?raw=true' }
    s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=appletvsimulator*]' => 'arm64' }
    s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=appletvsimulator*]' => 'arm64' }
end
