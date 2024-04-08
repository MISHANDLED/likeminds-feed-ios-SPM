Pod::Spec.new do |spec|
  spec.name         = 'LikeMindsFeedUI'
  spec.summary      = 'UI Components used in LikeMindsFeedCore'
  spec.homepage     = 'https://likeminds.community/'
  spec.version      = '1.0.2'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.authors      = { 'Devansh Mohata' => 'devansh.mohata@likeminds.community' }
  spec.source       = { :git => 'https://github.com/LikeMindsCommunity/likeminds-feed-ios.git', :tag => spec.version }
  spec.source_files = 'lm-feedUI-iOS/lm-feedUI-iOS/Source/Classes/**/*.swift'
  spec.resource_bundles = {
     'LikeMindsFeedUIAssets' => ['lm-feedUI-iOS/lm-feedUI-iOS/Source/Assets/*.{xcassets}']
  }
  spec.ios.deployment_target = '13.0'
  spec.swift_version = '5.0'
  spec.requires_arc = true
  spec.dependency 'Kingfisher', '~> 7.0'
end
