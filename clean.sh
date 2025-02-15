find . -name 'bin' -exec rm -rf {} \;
find . -name 'obj' -exec rm -rf {} \;
find . -name '.idea' -exec rm -rf {} \;
find . -name '.vs' -exec rm -rf {} \;

rm -rf XCFrameworks/*
rm -rf WidgetCenterProxyBinder/WidgetCenterProxyBinder/nugetoutput
