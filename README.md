<img src="https://raw.githubusercontent.com/nor0x/Untranslocator-XMac/main/art/logo.png" width="200px" />

# Untranslocator
[![Build Status](https://nor0x.visualstudio.com/Untranslocator/_apis/build/status/nor0x.Untranslocator-XMac?branchName=main)](https://nor0x.visualstudio.com/Untranslocator/_build/latest?definitionId=9&branchName=main)

Untranslocator allows to get the original bundle path from a translocated macOS app. 
## Usage
if a macOS app is translocated `NSBundle.MainBundle.BundlePath`returns a randomized read-only location - something like:
```
/private/var/folders/xx/xxxxxxxxxxx/x/AppTranslocation/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/x/MyApp.app
```
we can use this translocated path and use an object of `Untranslocator` to retrieve the original bundle path (i.e. `/Users/nor0x/Downloads`)
```cs
var untrans = new Untranslocator();
var path = untrans.ResolveTranslocatedPath(NSBundle.MainBundle.BundlePath);
```

more info on App Translocation:

https://www.synack.com/blog/untranslocating-apps
