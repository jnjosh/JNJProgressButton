# JNJProgressButton

As part of the [Objective-C Hackathon](https://objectivechackathon.appspot.com) I thought I'd take a shot at building a button to display progress, much like the progress button in the new iOS 7 version of the App Store. This progress button is inspired as a blend of UIButton and UIProgressView with a few other things tossed in. Maybe it will be useful, maybe it will just be fun. You decide.

![Progress in Action](http://jsh.in/PzVg/JNJProgressButton.gif)

## TODO ##

- Do better testing with AutoLayout. 
- Add support for better end state buttons.
- Refactor out the stupid.
- Properly handle -tintColor for the future.
- CocoaPods

## Usage ##

```objective-c

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.progressButton.delegate = self;
    self.progressButton.tintColor = [UIColor blueColor];
    self.progressButton.startButtonImage = [UIImage imageNamed:@"download-image"];
    self.progressButton.endButtonImage = [UIImage imageNamed:@"action-image"];
}   

- (void)progressButtonStartButtonTapped:(JNJProgressButton *)button
{
    // Begin doing the download action or whatever asyncronous thing you need to do. Then start updating the progress progerty on the button.
}

- (void)progressButtonEndButtonTapped:(JNJProgressButton *)button
{
    // The button has reached the end of the progress and the user can now do whatever the action needed.
}

- (void)progressButtonDidCancelProgress:(JNJProgressButton *)button
{
    // The user has canceled the progress
}

```

## Credits

- Icons in sample are from the [Glyphish Icon Library](http://www.glyphish.com)

## Contact

- [Josh Johnson](http://jnjosh.com) [@jnjosh](http://twitter.com/jnjosh)

## License

`JNJProgressButton` is available under the MIT License, please see the [LICENSE file for more information](http://jnjosh.mit-license.org/).