# WidgetCenterProxy

## Description
Call WidgetCenter methods from iOS .NET (MAUI).

## Usage
```
Add nuget package
```

```
new WidgetKit.WidgetCenterProxy().ReloadAllTimeLines();
```

## Known problems

On Windows you might get problems with very long directory names. This is a known issue with xcframeworks. The causes and possible solutions are described here:
https://github.com/AdamEssenmacher/GoogleApisForiOSComponents

## Package nuget location:
https://www.nuget.org/profiles/jeroenber

## Git repository
https://github.com/JeroenBer/WidgetCenterProxy


## To build:

Run script:
```
./clean.sh
```

Run script:
```
./build.sh
```

Goto .NET Project directory:
```
cd WidgetCenterProxyBinder/WidgetCenterProxyBinder
```

Create the package:
```
dotnet pack
```

## History

### Changes 2025
- Upgraded to .NET9. Build with XCode 16.2.
- Upgraded to xcframework (to be able to support M processor), "lipo" command no longer necessary
- Added support for Arm64 (M processor) simulator
- Shorten file paths (abbreviated to WCP (=WidgetCenterProxy)) due too long paths with xcframework
- Add license/readme to package
- Changed to a more logical package name "WidgetKit.WidgetCenterBinder" "com.hcsaba.WidgetCenterBinder.Net8" 

Some help from the following examples:
https://medium.com/@tema.denisoff/how-to-use-swiftui-components-in-maui-f43c54d2173c
https://github.com/temamarvel/SwiftUI_To_MAUI/blob/main/Scripts/build.sh
Fix xcframework: Set BUILD_LIBRARY_FOR_DISTRIBUTION to Yes in project settings:
https://stackoverflow.com/questions/58805812/xcframework-does-not-contain-internal-frameworks

## Original source
Call WidgetCenter.shared methods from Xamarin.

Created it based on the [binding-swift walkthrough](https://docs.microsoft.com/en-us/xamarin/ios/platform/binding-swift/walkthrough).

Forked from:
- https://github.com/Csaba8472/WidgetCenterProxy
- https://github.com/thewizrd/WidgetCenterProxy

If you run build.sh you'll get WidgetCenterProxy framework, which will be used by WidgetCenterProxyBinder project. You can use WidgetCenterProxyBinder in your app to handle iOS14 widgets.
