rm -Rf XCFrameworks

cd WidgetCenterProxy

xcodebuild archive \
   -scheme WidgetCenterProxy \
   -archivePath ../XCFrameworks/WidgetCenterProxy-ios.xcarchive \
   -sdk iphoneos \
   SKIP_INSTALL=NO

xcodebuild archive \
   -scheme WidgetCenterProxy \
   -archivePath ../XCFrameworks/WidgetCenterProxy-sim.xcarchive \
   -sdk iphonesimulator \
   SKIP_INSTALL=NO

xcodebuild -create-xcframework \
   -framework ../XCFrameworks/WidgetCenterProxy-sim.xcarchive/Products/Library/Frameworks/WidgetCenterProxy.framework \
   -framework ../XCFrameworks/WidgetCenterProxy-ios.xcarchive/Products/Library/Frameworks/WidgetCenterProxy.framework \
   -output ../XCFrameworks/WidgetCenterProxy.xcframework  

cd ..

sharpie bind \
   -sdk iphoneos \
   -output XCFrameworks/ \
   -namespace WidgetCenterProxy \
   -framework XCFrameworks/WidgetCenterProxy.xcframework/ios-arm64/WidgetCenterProxy.framework   