# Builds a fat library for a given xcode project (framework)

echo "Define parameters"
SWIFT_PROJECT_NAME="WidgetCenterProxy"
SWIFT_PROJECT_PATH="$SWIFT_PROJECT_NAME/$SWIFT_PROJECT_NAME.xcodeproj"
SWIFT_BUILD_PATH="$SWIFT_PROJECT_NAME/build"
SWIFT_OUTPUT_PATH="VendorFrameworks/swift-framework-proxy"
SWIFT_OUTPUT_PATH_MAC="$SWIFT_OUTPUT_PATH-maccatalyst"

echo "Build iOS framework for simulator and device"
rm -Rf "$SWIFT_BUILD_PATH"
xcodebuild -project "$SWIFT_PROJECT_PATH" -configuration Release -sdk iphonesimulator -arch x86_64
xcodebuild -project "$SWIFT_PROJECT_PATH" -configuration Release -sdk iphoneos

echo "Build MacCatalyst framework"
xcodebuild -project "$SWIFT_PROJECT_PATH" -configuration Release -sdk macosx -destination 'platform=macOS,variant=Mac Catalyst' SUPPORTS_MACCATALYST=YES

echo "Create fat binaries for Release-iphoneos, Release-iphonesimulator and Release-maccatalyst configuration"
echo "Copy one build as a fat framework"
cp -R "$SWIFT_BUILD_PATH/Release-iphoneos" "$SWIFT_BUILD_PATH/Release-fat"
cp -R "$SWIFT_BUILD_PATH/Release" "$SWIFT_BUILD_PATH/Release-maccatalyst"

echo "Combine modules from another build with the fat framework modules"
cp -R "$SWIFT_BUILD_PATH/Release-iphonesimulator/$SWIFT_PROJECT_NAME.framework/Modules/$SWIFT_PROJECT_NAME.swiftmodule/" "$SWIFT_BUILD_PATH/Release-fat/$SWIFT_PROJECT_NAME.framework/Modules/$SWIFT_PROJECT_NAME.swiftmodule/"

echo "Combine iphoneos + iphonesimulator + maccatalyst configuration as fat libraries"
lipo -create -output "$SWIFT_BUILD_PATH/Release-fat/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME" "$SWIFT_BUILD_PATH/Release-iphoneos/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME" "$SWIFT_BUILD_PATH/Release-iphonesimulator/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME"
lipo -create -output "$SWIFT_BUILD_PATH/Release-maccatalyst/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME" "$SWIFT_BUILD_PATH/Release/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME"

echo "Verify results"
lipo -info "$SWIFT_BUILD_PATH/Release-fat/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME"
lipo -info "$SWIFT_BUILD_PATH/Release-maccatalyst/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME"

echo "Copy fat frameworks to the output folder"
rm -Rf "$SWIFT_OUTPUT_PATH"
rm -Rf "$SWIFT_OUTPUT_PATH_MAC"
mkdir -p "$SWIFT_OUTPUT_PATH"
mkdir -p "$SWIFT_OUTPUT_PATH_MAC"
cp -Rf "$SWIFT_BUILD_PATH/Release-fat/$SWIFT_PROJECT_NAME.framework" "$SWIFT_OUTPUT_PATH"
cp -Rf "$SWIFT_BUILD_PATH/Release-maccatalyst/$SWIFT_PROJECT_NAME.framework" "$SWIFT_OUTPUT_PATH_MAC"

echo "Generating binding api definition and structs"
sharpie bind --sdk=iphoneos --output="$SWIFT_OUTPUT_PATH/XamarinApiDef" --namespace="Binding" --scope="$SWIFT_OUTPUT_PATH/$SWIFT_PROJECT_NAME.framework/Headers/" "$SWIFT_OUTPUT_PATH/$SWIFT_PROJECT_NAME.framework/Headers/$SWIFT_PROJECT_NAME-Swift.h" -c -xobjective-c
sharpie bind --sdk=macosx --output="$SWIFT_OUTPUT_PATH_MAC/XamarinApiDef" --namespace="Binding" --scope="$SWIFT_OUTPUT_PATH_MAC/$SWIFT_PROJECT_NAME.framework/Headers/" "$SWIFT_OUTPUT_PATH_MAC/$SWIFT_PROJECT_NAME.framework/Headers/$SWIFT_PROJECT_NAME-Swift.h" -c -xobjective-c


echo "Done!"
