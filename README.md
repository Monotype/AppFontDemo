App Font Demo
============= 

This is a collection of sample code to illustrate the usage of custom fonts on the iOS platform. Since Version 3.2, iOS supports custom fonts for apps. Applications that want to use custom fonts simply include those fonts in their application bundle. Additionally, every font has to be registered with the system via the app's Info.plist file.

The following examples all use the free FontFont FF Basic Gothic Black Italic (Truetype).

Basics
------

Basically, add the fonts you want to use to your application bundle by dragging them into the project. Then add the key 'UIAPPFonts' to your Application.plist file (the human readable term shown by default in XCode is 'Fonts provided by application'):

![plist additions](https://github.com/fontshop/AppFontDemo/raw/master/img/plist.png)

The font format can be either Truetype (\*.ttf) or OpenType (\*.otf).

With that administrative stuff out of the way, its possible to get a UIFont reference like this:

    UIFont* font = [UIFont fontWithName:@"SuperFont Medium" size:24];

Armed with that font reference, you can set the font property exposed by UIControls, like UILabel:

    UILabel* label = ...
    label.font = font;
    
Here is a code snippet to list all fonts available to the app:

    // Get all the fonts on the system
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
    	printf( "Family: %s \n", [familyName UTF8String] );
    	NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
    	for( NSString *fontName in fontNames ){
    		printf( "\tFont: %s \n", [fontName UTF8String] );
    	}
    }


About the code
==============

Here's a short [video](https://github.com/fontshop/AppFontDemo/raw/master/img/AppFontsMovie.m4v) featuring the app in action.
  
Navigation controller and navigation bar
----------------------------------------

You may have noticed that the font used on the navigation bar at the top (title and back button) are set in a custom font. The iOS API does not make it particularly easy to change some aspects of the standard controls, consequently there is some not-so-obvious technique at work here. I have implemented the gist of it in the UIViewController category.

![Navigation bar](https://github.com/fontshop/AppFontDemo/raw/master/img/navigationbar.png)

For the navigation bar title, there is a custom view (a UILabel) created where we can set the font easily. That view is set as the title view of the navigation item, replacing the default one. Also some hadows are set to mimic the original a bit.

    UILabel* label = [[UILabel alloc] initWithFrame:self.navigationController.navigationBar.frame];
    label.font = ...
    self.navigationItem.titleView = label;
    [label release];

The back button is a little trickier, since there is no way to access the font properties of the default back button. The solution is to create a custom button with the commonly know background where we can actually set the font parameters. Not very elegant because of the background image we have to supply (in normal and highlighted incarnations, normal and retina resolutions), but hey. The button background images are actually stretchable images (read up on stretchable images [here](http://developer.apple.com/library/ios/#documentation/uikit/reference/UIImage_Class/Reference/Reference.html#//apple_ref/occ/instm/UIImage/stretchableImageWithLeftCapWidth:topCapHeight:)).

The actual size of the back button is dynamic, depending on the button text. We measuree the text dimensions with

    CGSize size = [title sizeWithFont:font];

and set the button frame accordingly, adding a few pixels to cater for left and right spacing. To prevent the title text from sitting dead left over the button image, we add 10 pixels to the left edge inset:

    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

Onbe last problem with the back button is the actual button action,. we call a simple method backTo: (which is also located in the view controller category)

    [button addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside]; 

All of this is actually encapsulated in the aforementioned UIViewController category, so its sufficient to import the category and call setupNavigationItemFont in some strategic place (viewDidLoad seems like a good fit). This does all the necessary steps to set up the title label and the back button with a custom font. Managing additional buttons in the navigation bar is left as a exercise.

    - (void)viewDidLoad {
      [super viewDidLoad];
      [self setupNavigationItemFont];
    }

Buttons
-------

UIButton with its rounded and custom incarnations is pretty straightforward, the font property is properly exposed.

    self.defaultButton.titleLabel.font = [UIFont fontWithName:@"BasicGothicMobiPro-BlackItalic" size:18];
    
![UIButtons](https://github.com/fontshop/AppFontDemo/raw/master/img/buttons.png)

For a UISegmentedControl, things are a bit more involved. No font property is exposed from the class. The (admittedly crude) way to force usage of custom fonts is to render the text into an offscreen image and set the image property of the segment.

![UIButtons](https://github.com/fontshop/AppFontDemo/raw/master/img/segmented_control.png)

    UIFont*		font	= [UIFont fontWithName:@"BasicGothicMobiPro-BlackItalic" size:14];
    for (NSInteger i=0; i<self.segmentedControl.numberOfSegments; i++) {
      NSString*	text = [self.segmentedControl titleForSegmentAtIndex:i];
      // get the size of the title string
      CGSize		size	= [text sizeWithFont:font];
      // Rendering context, call with options and set scale to 0.0 to work with retina displays
      UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
      CGContextRef context = UIGraphicsGetCurrentContext();    
      // Set colors
      CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
      // Set shadow
      CGContextSetShadow(context, CGSizeMake(0, -1.0), 1);
      // Render
      [text drawInRect:CGRectMake(0, 0, size.width, size.height) withFont:font];
      // Create image and release context
      UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
      [self.segmentedControl setImage:image forSegmentAtIndex:i];
    }


Text views
----------

Text views are, like buttons, very straight forward. The font property is directly exposed in the API.

    self.label.font = [UIFont fontWithName:@"BasicGothicMobiPro-BlackItalic" size:18];
    self.textField.font = [UIFont fontWithName:@"BasicGothicMobiPro-BlackItalic" size:14];
    self.textView.font = [UIFont fontWithName:@"BasicGothicMobiPro-BlackItalic" size:14];

![UIButtons](https://github.com/fontshop/AppFontDemo/raw/master/img/text_views.png)

Layers
------

Drawing text into layers is preferrably done with the CATextLayer class. Layers uses the CoreGraphics API to draw, so we have to deal with a CGFontRef instead of UIFont. To get a CGFontRef for your Custom font, use this function:

    textLayer.font = CGFontCreateWithFontName((CFStringRef)@"BasicGothicMobiPro-BlackItalic");

Note that unoike UIFont, CGFont does not carry the font size (consequently, UIFont and CGFontRef are not toll free bridged). Set the font size like this:

    textLayer.fontSize = 24.0;

To make sure that the text is drawn in high resolution on retina displays, set the layer's content scale as well:

    textLayer.contentsScale = [[UIScreen mainScreen] scale];
   
Make sure the layer's size is large enough to fit the text and set the truncationMode and wrapped properties to you liking.

On a side note, CATextLayer can take regular NSStrings on its string property but also NSAttributedStrings which does open some interesting ways of controlling the text rendering. It is the only way to control line spacing or render multi colored strings. Unfortunately, there is (as of iOS 4.3) no way to easily create  NSAttributedStrings (on the Mac the situation is considerably better). One way is to create a CFMutableAttributedStringRef, set it up to your liking and simply cast it to an NSAttributedString. This works because CFAttributedStringRef/NSAttributedString are of the toll-free bridged variety.

An interesting twist on that method is the venerable [NSAttributedString-Additions-for-HTML](https://github.com/Cocoanetics/NSAttributedString-Additions-for-HTML) project. It is an implementation of the OSX API calls to create NSAttributedStrings from HTML code.


Web view
--------

Not really part of the Cocoa Touch API, but its good to know that UIWebView supports the @font-face style definitions. To change the font for the h1 tag, put something like this into your style definitions:

    @font-face {
      font-family: "BasicGothicMobiPro-BlackItalic";
      src: url(BasicGothicMobiPro-BlackItalic.otf) format("opentype");
    }
    h1 {
      font-family: BasicGothicMobiPro-BlackItalic;
    }

List of available fonts
-----------------------

Iterating through the list of all available fonts is easy:

    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
      NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
      for( NSString *fontName in fontNames ){
        NSLog("family: %@ font: %@", familyName, fontName);
      }
    }

How to get fonts
----------------

Fonts can be found all over the web, but be aware that licensing terms for professional typefaces often forbid embedding them into them apps. Shameless plug: For the best selection of fonts _IN THE WORLD_, head over to [FontShop](http://www.fontshop.com/).

