find . -name 'bin' -exec rm -rf {} \;
find . -name 'obj' -exec rm -rf {} \;
find . -name '.idea' -exec rm -rf {} \;
find . -name '.vs' -exec rm -rf {} \;

rm -rf WidgetCenterProxy/build
rm -rf WidgetCenterProxyBinder/WidgetCenterProxyBinder/nugetoutput
rm -rf XCFrameworks/*
