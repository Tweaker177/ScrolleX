#import "SCXAboutListController.h"
//#import "PSHeaderFooterView.h"
//#import "UIColor+randomPrefs.h"



@implementation SCXAboutListController

#pragma mark - Constants

+ (UIColor *)hb_tintColor {
    return [UIColor redColor];
}

+ (NSString *)hb_shareText {
	NSString *shareScrolleX = @"I'm using a #ScrolleX by i0s_tweak3r, for all versions and devices of iOS 13+14.. The gold standard of system wide scroll bars now available in @YouRepo ";
	return shareScrolleX;
}

+ (NSURL *)hb_shareURL {
	return [NSURL URLWithString:@"http://i0s-tweak3r-betas.yourepo.com/pack/scrollex"];
}


+ ( NSString *)hb_supportEmailAddress {
NSString *addy = @"djvs23@gmail.com"; return addy;
}


+ (NSString *)hb_specifierPlist {
	return @"About";
}

@end
