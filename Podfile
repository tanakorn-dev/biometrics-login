source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!

def default_pods
    pod 'SwiftIcons'
    pod 'AppCenter'
    pod 'Defaults'
end

target 'biometrics-login' do
    default_pods
end

post_install do |installer|
     installer.pods_project.targets.each do |target|
         target.build_configurations.each do |config|
             config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
             config.build_settings.delete('CODE_SIGNING_ALLOWED')
             config.build_settings.delete('CODE_SIGNING_REQUIRED')
             config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'NO'
         end
     end
 end
