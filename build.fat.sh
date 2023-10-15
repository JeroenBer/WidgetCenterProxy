# Builds a fat library for a given xcode project (framework)

echo "Define parameters"
SWIFT_PROJECT_NAME="WidgetCenterProxy"
SWIFT_PROJECT_PATH="$SWIFT_PROJECT_NAME/$SWIFT_PROJECT_NAME.xcodeproj"
SWIFT_BUILD_PATH="$SWIFT_PROJECT_NAME/build"
SWIFT_ARCHIVE_PATH="$SWIFT_PROJECT_NAME/archive"
SWIFT_OUTPUT_PATH="VendorFrameworks/swift-framework-proxy"

echo "Build iOS framework for simulator and device"
rm -Rf "$SWIFT_BUILD_PATH"
rm -Rf "$SWIFT_ARCHIVE_PATH"
xcodebuild archive -project "$SWIFT_PROJECT_PATH" -configuration Release -scheme "$SWIFT_PROJECT_NAME" -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES SKIP_INSTALL=NO -archivePath $SWIFT_ARCHIVE_PATH/iphonesimulator.xcarchive
xcodebuild archive -project "$SWIFT_PROJECT_PATH" -configuration Release -scheme "$SWIFT_PROJECT_NAME" -sdk iphoneos BUILD_LIBRARY_FOR_DISTRIBUTION=YES SKIP_INSTALL=NO -archivePath $SWIFT_ARCHIVE_PATH/iphoneos.xcarchive

echo "Build MacCatalyst framework"
xcodebuild archive -project "$SWIFT_PROJECT_PATH" -configuration Release -scheme "$SWIFT_PROJECT_NAME" -destination 'platform=macOS,variant=Mac Catalyst' SUPPORTS_MACCATALYST=YES ONLY_ACTIVE_ARCH=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES SKIP_INSTALL=NO -archivePath $SWIFT_ARCHIVE_PATH/maccatalyst.xcarchive

echo "Create xcframework"
rm -Rf "$SWIFT_OUTPUT_PATH"
xcodebuild -create-xcframework \
  -framework $SWIFT_ARCHIVE_PATH/iphonesimulator.xcarchive/Products/Library/Frameworks/${SWIFT_PROJECT_NAME}.framework \
  -framework $SWIFT_ARCHIVE_PATH/iphoneos.xcarchive/Products/Library/Frameworks/${SWIFT_PROJECT_NAME}.framework \
  -framework $SWIFT_ARCHIVE_PATH/maccatalyst.xcarchive/Products/Library/Frameworks/${SWIFT_PROJECT_NAME}.framework \
  -output ${SWIFT_OUTPUT_PATH}/${SWIFT_PROJECT_NAME}.xcframework

echo "Generating binding api definition and structs"
sharpie bind --sdk=iphoneos --output="$SWIFT_OUTPUT_PATH/XamarinApiDef" --namespace="Binding" --scope="$SWIFT_OUTPUT_PATH/$SWIFT_PROJECT_NAME.xcframework/ios-arm64/$SWIFT_PROJECT_NAME.framework/Headers/" "$SWIFT_OUTPUT_PATH/$SWIFT_PROJECT_NAME.xcframework/ios-arm64/$SWIFT_PROJECT_NAME.framework/Headers/$SWIFT_PROJECT_NAME-Swift.h"


echo "Done!"
