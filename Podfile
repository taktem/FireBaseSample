source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'
use_frameworks!

def install_pods
    # Rx
	pod 'RxSwift', '~> 2.5.0'
	pod 'RxCocoa', '~> 2.5.0'

	# Mapper
	pod 'ObjectMapper', '~> 1.3.0'

	# Firebase
	pod 'Firebase/Core', '~> 3.2.0'
	pod 'Firebase/Messaging', '~> 3.2.0'
	pod 'Firebase/Auth', '~> 3.2.0'

	# Facebook
	pod 'FBSDKCoreKit', '~> 4.12.0'
	pod 'FBSDKLoginKit', '~> 4.12.0'

	# Loading
	pod 'SVProgressHUD', '~> 2.0.3'
end

# target list
targetArray= Array['FirebaseSample']
for targetName in targetArray
    target targetName do
    	install_pods
    end
end



