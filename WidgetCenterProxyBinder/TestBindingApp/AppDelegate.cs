using System.Diagnostics;

namespace TestBindingApp
{
    [Register("AppDelegate")]
    public class AppDelegate : UIApplicationDelegate
    {
        public override UIWindow? Window
        {
            get;
            set;
        }

        public override bool FinishedLaunching(UIApplication application, NSDictionary launchOptions)
        {
            // create a new window instance based on the screen size
            Window = new UIWindow(UIScreen.MainScreen.Bounds);

            // create a UIViewController with a single button to test
            var vc = new UIViewController();
            var btn = new UIButton(Window!.Frame);
            btn.BackgroundColor = UIColor.SystemBackground;
            btn.SetTitleColor(UIColor.Label, UIControlState.Normal);
            btn.SetTitle("Click here to test binding (see debug output)", UIControlState.Normal);
            btn.TouchUpInside += Btn_TouchUpInside;
            vc.View!.AddSubview(btn);

            Window.RootViewController = vc;

            // make the window visible
            Window.MakeKeyAndVisible();

            return true;
        }

        private void Btn_TouchUpInside(object? sender, EventArgs e)
        {
            try
            {
                Debug.WriteLine("Calling Reload");
                new WidgetKit.WidgetCenterProxy().ReloadAllTimeLines();
                Debug.WriteLine("Finished calling Reload");
            }
            catch(Exception ex)
            {
                Debug.WriteLine($"Error: {ex}");
            }
        }
    }
}
