This is a library to abstract access to the keychain on iOS devices. It is a cateogry on UIApplication which must be compiled *without ARC*. If you're using ARC, that's awesome! But to avoid problems with bridging casts with Core Foundation classes, set `-fno-objc-arc` as a (file-specific compiler flag)[http://meandmark.com/blog/2011/10/xcode-4-setting-compiler-flags-for-a-single-file/]. Maybe I'll be less lazy in the future and convert it over. Maybe.

Based on [@kharrison](https://twitter.com/#!/kharrison)'s [blog post](http://useyourloaf.com/blog/2010/3/29/simple-iphone-keychain-access.html) on accessing an iOS device's keychain.