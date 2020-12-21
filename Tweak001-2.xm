#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>
#include <CSColorPicker/CSColorPicker.h>
#import <Foundation/Foundation.h>


@interface roundedFillView : UIView
@end

@interface _UIScrollViewScrollIndicator : UIView
@property (nonatomic, assign) NSUInteger type;
@property (nonatomic, assign) NSUInteger style;
@property UIView *roundedFillView;
@end


HBPreferences *preferences;

static BOOL kEnabled = NO;
//Color scrollbar
static NSString *kVerticleScrollBarHex = nil;
static BOOL kColorScrollBar;
//Color shadow
static BOOL kColorShadow;
static NSString *kScrollBarShadowHex = nil;

//Border variables
static BOOL kWantsScrollBorder;
static NSString *kScrollBarBorderHex = nil;
static CGFloat kBorderWidth = 0.f;
static NSNumber *borderWidth;
//Shadow Opacity
static CGFloat kShadowOpacity = 1.f;
static NSNumber *shadowOpacity;
//Shadow Radius
static CGFloat kShadowRadius = 3.f;
static NSNumber *shadowRadius;
//Shadow offset X
static CGFloat kShadowOffsetX = -3.f;
static NSNumber *shadowOffsetX;
//Shadow offset Y
static CGFloat kShadowOffsetY = -3.f;
static NSNumber *shadowOffsetY;


%group tweak

%hook  _UIScrollViewScrollIndicator
-(id)initWithFrame:(CGRect)frame {
    if(!kEnabled) { return %orig; }
    
    self = %orig;
    if(kColorScrollBar) {
        self.roundedFillView.backgroundColor = [UIColor cscp_colorFromHexString: kVerticleScrollBarHex];
    }
    if(kColorShadow) {
    self.roundedFillView.layer.shadowColor = [UIColor cscp_colorFromHexString: kScrollBarShadowHex].CGColor;
    self.roundedFillView.layer.shadowOpacity = kShadowOpacity; //  was 1;
    self.roundedFillView.layer.shadowRadius = kShadowRadius;  // was 3.f;
    CGSize shadowOffsetSize = CGSizeMake(kShadowOffsetX, kShadowOffsetY); // was (-3.f, -3.f);
    self.roundedFillView.layer.shadowOffset = shadowOffsetSize;
    }
    if(kWantsScrollBorder) {
        self.roundedFillView.layer.borderColor = [UIColor cscp_colorFromHexString: kScrollBarBorderHex].CGColor;
        self.roundedFillView.layer.borderWidth = kBorderWidth;  // was 1.f;
    }
    
    return self;
}

-(void)layoutSubviews {
    if(!kEnabled) {
        return %orig;
    }
    %orig;
    if(kColorScrollBar) {
    self.roundedFillView.backgroundColor = [UIColor cscp_colorFromHexString: kVerticleScrollBarHex];
    }
    if(kColorShadow) {
    self.roundedFillView.layer.shadowColor = [UIColor cscp_colorFromHexString: kScrollBarShadowHex].CGColor;
        self.roundedFillView.layer.shadowOpacity = kShadowOpacity; // was 1;
        self.roundedFillView.layer.shadowRadius = kShadowRadius; // was 3.f;
        CGSize shadowOffsetSize = CGSizeMake(kShadowOffsetX, kShadowOffsetY); // was ( -3.f, -3.f);
    self.roundedFillView.layer.shadowOffset = shadowOffsetSize;
    }
    if(kWantsScrollBorder) {
        self.roundedFillView.layer.borderColor = [UIColor cscp_colorFromHexString: kScrollBarBorderHex].CGColor;
        self.roundedFillView.layer.borderWidth = kBorderWidth;  // was 1.4f;
        
    }
    return;
}


%end




extern NSString *const HBPreferencesDidChangeNotification;
//Cephei callback

%end //tweak group

%ctor {
    
    /*  This code was contributed by a reddit user to limit the scope of Cephei to where it belongs in system wide tweaks. I forget the author's name, but will try to find the post to give appropriate credit soon.  */
    
    BOOL shouldLoad = NO;
    NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];
    NSUInteger count = args.count;
    if (count != 0) {
        NSString *executablePath = args[0];
        if (executablePath) {
            NSString *processName = [executablePath lastPathComponent];
            BOOL isSpringBoard = [processName isEqualToString:@"SpringBoard"];
            BOOL isApplication = [executablePath rangeOfString:@"/Application/"].location != NSNotFound || [executablePath rangeOfString:@"/Applications/"].location != NSNotFound;
            BOOL isFileProvider = [[processName lowercaseString] rangeOfString:@"fileprovider"].location != NSNotFound;
            BOOL skip = [processName isEqualToString:@"AdSheet"]
            || [processName isEqualToString:@"CoreAuthUI"]
            || [processName isEqualToString:@"InCallService"]
            || [processName isEqualToString:@"MessagesNotificationViewService"]
            || [executablePath rangeOfString:@".appex/"].location != NSNotFound;
            if (!isFileProvider && (isSpringBoard || isApplication) && !skip) {
                shouldLoad = YES;
            }
        }
    }
    //End of filter code by Reddit user, besides if(shouldLoad) {
    
    
    if(shouldLoad) {
        
        // preference loading, initialization
        
        preferences = [[HBPreferences alloc] initWithIdentifier:@"com.i0stweak3r.scrollex"];
        
        [preferences registerBool:&kEnabled default:NO forKey:@"enabled"];
              //Color bar enabled
        [preferences registerBool:&kColorScrollBar default:YES forKey:@"colorVerticleBar"];
          //Scrollbar color (all types at the moment)
        [preferences registerObject:&kVerticleScrollBarHex default:@"FFFF00" forKey:@"scrollBarHex"];
        
        
        //Enable shadows
         [preferences registerBool:&kColorShadow default:YES  forKey:@"colorShadow"];
         //shadow Color
        [preferences registerObject:&kScrollBarShadowHex default:@"FF0000" forKey:@"scrollBarShadowHex"];
       
        
        //Shadow Opacity
        [preferences registerObject:&shadowOpacity default:@1.f forKey:@"shadowOpacity"];
        kShadowOpacity = [[preferences objectForKey:@"shadowOpacity"] floatValue];
        
        //Shadow radius
        [preferences registerObject:&shadowRadius default:@3.f forKey:@"shadowRadius"];
        kShadowRadius = [[preferences objectForKey:@"shadowRadius"] floatValue];
        
        //Shadow offsets
        [preferences registerObject:&shadowOffsetX default:@-3.f forKey:@"shadowOffsetX"];
        kShadowOffsetX = [[preferences objectForKey:@"shadowOffsetX"] floatValue];
        
        [preferences registerObject:&shadowOffsetY default:@-3.f forKey:@"shadowOffsetY"];
        kShadowOffsetY = [[preferences objectForKey:@"shadowOffsetY"] floatValue ];
        
        //Add a Border, Color + Width
        [preferences registerBool:&kWantsScrollBorder default:NO forKey:@"wantsScrollBorder"];
        [preferences registerObject:&borderWidth default:@0.f forKey:@"borderWidth"];
       
        kBorderWidth = [[preferences objectForKey:@"borderWidth"] floatValue];
        [preferences registerObject:&kScrollBarBorderHex default:@"000000" forKey:@"scrollBarBorderHex"];
        
       
        
        BOOL  kIsSketchy = NO;
        
       // [prefs registerBool:&kIsSketchy default:NO forKey:@"isSketchy"];
        
        if((![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/com.yourepo.i0s-tweak3r-betas.scrollex.list"]) && (![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/com.i0stweak3r.scrollex.list"])) {
            // kShouldShowPiratedAlert = NO;
            
            kIsSketchy = YES;
           // [prefs setValue:@YES forKey:@"isSketchy"];
        }
        
         if(!kIsSketchy && kEnabled) {
        %init(tweak);
    }
        %init;
}    //End of if should load

}  // End of %ctor


// COPYRIGHT 2020 written by i0s_tweak3r aka Brian Nooning
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end
*/
