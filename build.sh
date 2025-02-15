rm -Rf XCFrameworks

cd WidgetCenterProxy

xcodebuild archive \
   -scheme WidgetCenterProxy \
   -archivePath ../XCFrameworks/WCP-ios.xcarchive \
   -sdk iphoneos \
   SKIP_INSTALL=NO

xcodebuild archive \
   -scheme WidgetCenterProxy \
   -archivePath ../XCFrameworks/WCP-sim.xcarchive \
   -sdk iphonesimulator \
   SKIP_INSTALL=NO

xcodebuild -create-xcframework \
   -framework ../XCFrameworks/WCP-sim.xcarchive/Products/Library/Frameworks/WCP.framework \
   -framework ../XCFrameworks/WCP-ios.xcarchive/Products/Library/Frameworks/WCP.framework \
   -output ../XCFrameworks/WCP.xcframework  

cd ..

sharpie bind \
   -sdk iphoneos \
   -output XCFrameworks/ \
   -namespace WidgetCenterProxy \
   -framework XCFrameworks/WCP.xcframework/ios-arm64/WCP.framework   