Pod::Spec.new do |spec|

  spec.name         = "SharedFramework"
  spec.version      = "0.0.5"
  spec.summary      = "Shared components library written in swift"

  spec.description  = <<-DESC
  This Shared components CocoaPods library will help me.
                   DESC

  spec.homepage     = "https://github.com/ioramashvili/SharedFramework"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Shota Ioramashvili" => "shotaioramashvili@gmail.com" }
  
  spec.ios.deployment_target = "9.0"
  spec.swift_version = "5.0"

  spec.source       = { :git => "https://github.com/ioramashvili/SharedFramework.git", :tag => "#{spec.version}" }
  spec.source_files  = "SharedFramework/**/*.{h,m,swift}"
end
