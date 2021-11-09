Pod::Spec.new do |spec|

  spec.name         = "SharedFramework"
  spec.version      = "0.0.9"
  spec.summary      = "Shared components library written in swift"

  spec.homepage     = "https://github.com/ioramashvili/SharedFramework"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Shota Ioramashvili" => "shotaioramashvili@gmail.com" }
  spec.source       = { :git => "https://github.com/ioramashvili/SharedFramework.git", :tag => "#{spec.version}" }
  
  spec.ios.deployment_target = "13.0"
  spec.swift_version = "5.0"

  spec.source_files  = 'Sources/SharedFramework/**/*'
end
