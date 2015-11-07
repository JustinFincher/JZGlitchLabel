# JZGlitchLabel
![JZGlitchLabel.jpg](https://github.com/JustinFincher/JZGlitchLabel/raw/master/DemoPic/JZGlitchLabel.jpg)  

[![CI Status](http://img.shields.io/travis/Fincher Justin/JZGlitchLabel.svg?style=flat)](https://travis-ci.org/Fincher Justin/JZGlitchLabel)
[![Version](https://img.shields.io/cocoapods/v/JZGlitchLabel.svg?style=flat)](http://cocoapods.org/pods/JZGlitchLabel)
[![License](https://img.shields.io/cocoapods/l/JZGlitchLabel.svg?style=flat)](http://cocoapods.org/pods/JZGlitchLabel)
[![Platform](https://img.shields.io/cocoapods/p/JZGlitchLabel.svg?style=flat)](http://cocoapods.org/pods/JZGlitchLabel)

#Introduction
JZGlitchLabel is a .... UIView with Glitch effect you can see in after effect project.
DemoGif:
![JZGlitchLabel.gif](https://github.com/JustinFincher/JZGlitchLabel/raw/master/DemoPic/JZGlitchLabel.gif)  

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```
    GLabel = [[JZGlitchLabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width,300)];
    GLabel.Label.text = @"T";
    GLabel.Label.font = [UIFont systemFontOfSize:150.0f weight:40];
    
    GLabel.MinFontSize = 60;
    GLabel.MaxFontSize = 160;
    GLabel.MinFontWeight = 20;
    GLabel.MaxFontWeight = 40;
    
    [self.view addSubview:GLabel];

//Use this to make a glitch animation
    [GLabel performGlitchTransformTo:@"You want"]
                           WithSteps:30
                        WithInterval:0.08
                        WithFontSize:130
                      WithFontWeight:50
                 WithGlitchParameter:20];
```
    
**MinFontSize**: MinFontSize when in Glitch  
**MaxFontSize**: MaxFontSize when in Glitch  
**MinFontWeight**: MinFontWeight when in Glitch  
**MaxFontWeight**: MaxFontWeight when in Glitch  
**WithGlitchParameter**: CGfloat, detemine the Glitch effect (bigger the cooler)


## Installation

JZGlitchLabel is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JZGlitchLabel"
```

Or just grab JZGlitchLabel.h and .m from github.


## Author

Fincher Justin, zhtsu47@me.com

## License

JZGlitchLabel is available under the MIT license. See the LICENSE file for more info.
