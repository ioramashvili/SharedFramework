Pod::Spec.new do |spec|

  spec.name         = "SharedFramework"
  spec.version      = "0.0.1"
  spec.summary      = "Shared components library written in swift"

  spec.description  = <<-DESC
  This CocoaPods library helps me 🥳.
                   DESC

  spec.homepage     = "https://github.com/ioramashvili/SharedFramework"
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author       = { "Shota Ioramashvili" => "shotaioramashvili@gmail.com" }
  
  spec.ios.deployment_target = "11.0"
  spec.swift_version = "5.0"

  spec.source       = { :git => "https://github.com/ioramashvili/SharedFramework", :tag => "#{spec.version}" }
  spec.source_files  = "SharedFramework/**/*.{h,m,swift}"
end
