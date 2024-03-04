# WidgetCenterProxy

Call WidgetCenter.shared methods from Xamarin.

Created it based on the [binding-swift walkthrough](https://docs.microsoft.com/en-us/xamarin/ios/platform/binding-swift/walkthrough).

If you run build.fat.sh you'll get WidgetCenterProxy framework, which will be used by WidgetCenterProxyBinder project. You can use WidgetCenterProxyBinder in your app to handle iOS14 widgets.

# Upgrade to .NET 8

Upgraded to .NET8. Build with XCode 15.2.

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


