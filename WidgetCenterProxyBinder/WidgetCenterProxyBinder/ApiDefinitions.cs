using System;
using System.Runtime.Versioning;
using Foundation;
using Intents;
using ObjCRuntime;

namespace Binding
{
    // @interface WidgetCenterProxy
    [SupportedOSPlatform("ios14.0")]
    interface WidgetCenterProxy
    {
        // -(void)reloadTimeLinesOfKind:(NSString * _Nonnull)ofKind;
        [Export("reloadTimeLinesOfKind:")]
        void ReloadTimeLinesOfKind(string ofKind);

        // -(void)reloadAllTimeLines;
        [Export("reloadAllTimeLines")]
        void ReloadAllTimeLines();

        // -(void)invalidateConfigurationRecommendations __attribute__((availability(ios, introduced=16.0)));
        [SupportedOSPlatform("ios16.0")]
        [Export("invalidateConfigurationRecommendations")]
        void InvalidateConfigurationRecommendations();

        // -(void)getCurrentConfigurationsWithCompletion:(void (^ _Nonnull)(int))completion;
        [Export("getCurrentConfigurationsWithCompletion:")]
        void GetCurrentConfigurationsWithCompletion(Action<int> completion);
    }

    // @interface WidgetInfoProxy
    [SupportedOSPlatform("ios14.0")]
    interface WidgetInfoProxy
    {
        // @property (copy, nonatomic) NSString * _Nonnull kind;
        [Export("kind")]
        string Kind { get; set; }

        // @property (nonatomic) int family;
        [Export("family")]
        int Family { get; set; }

        // @property (nonatomic, strong) INIntent * _Nullable configuration;
        [NullAllowed, Export("configuration", ArgumentSemantic.Strong)]
        INIntent Configuration { get; set; }
    }
}
