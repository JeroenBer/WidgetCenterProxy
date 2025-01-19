# WidgetCenterProxy

Call WidgetCenter.shared methods from Xamarin.

Created it based on the [binding-swift walkthrough](https://docs.microsoft.com/en-us/xamarin/ios/platform/binding-swift/walkthrough).

If you run build.fat.sh you'll get WidgetCenterProxy framework, which will be used by WidgetCenterProxyBinder project. You can use WidgetCenterProxyBinder in your app to handle iOS14 widgets.

# Upgrade to .NET 9

- Upgraded to .NET9. Build with XCode 16.2.
- Added support for Arm64 (M processor) simulator

## To build:

Run script:
```
./build.fat.sh
```

Goto .NET Project directory
```
cd WidgetCenterProxyBinder/WidgetCenterProxyBinder
```

Create the package
```
dotnet pack
```


