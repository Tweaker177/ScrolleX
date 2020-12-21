#include "SCXRootListController.h"

#include <CSColorPicker/CSColorPicker.h>
#import <notify.h>
#import <Social/Social.h>
#import <Cephei/HBRespringController.h>
#include <objc/runtime.h>

@implementation SCXRootListController

/*
 - (instancetype)init {
 self = [super init];
 if (self) {
 HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
 appearanceSettings.tintColor =  [UIColor colorWithRed: 1.0 green: 0.5 blue: 0.01 alpha: 1.0];
 
 appearanceSettings.statusBarTintColor = [UIColor redColor];
 
 appearanceSettings.navigationBarTintColor = [UIColor colorWithRed: 1.0 green: 0.5 blue: 0.01 alpha: 1.0];
 
 appearanceSettings.tableViewCellSeparatorColor = [UIColor colorWithWhite:0 alpha:0.8];
 
 appearanceSettings.tableViewCellBackgroundColor = [UIColor colorWithRed: .12 green: .12 blue: .3 alpha:1];
 
 appearanceSettings.tableViewCellTextColor = [UIColor colorWithRed: .80 green: .80 blue: 1.0 alpha: 1];
 
 
 appearanceSettings.tableViewCellSelectionColor = [UIColor redColor];
 
 appearanceSettings.tableViewBackgroundColor =
 [UIColor colorWithRed: 0.f green: 0.f blue: 0.2f alpha:0.2];
 
 appearanceSettings.navigationBarBackgroundColor = [UIColor colorWithRed: .12 green: .12 blue: .3 alpha:0.85];
 
 self.hb_appearanceSettings = appearanceSettings;
 }
 return self;
 }
 */


/*
 -(void)love
 {
 SLComposeViewController *twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
 [twitter setInitialText:@"I’m using #Xcondito by i0s_tweak3r. It actually hides hidden photos, and/or makes your trash can look empty in the photos app. Works on all devices iOS 10-13.5  Hosted by @YouRepo "];
 if (twitter != nil) {
 [[self navigationController] presentViewController:twitter animated:YES completion:nil];
 }
 }
 
 
 -(void)loadView
 {
 [super loadView];
 
 
 UIImage *heart = [[UIImage alloc] initWithContentsOfFile:[[self bundle] pathForResource:@"Heart" ofType:@"png"]];
 UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
 [button setBackgroundImage:heart forState:UIControlStateNormal];
 [button addTarget:self action:@selector(love) forControlEvents:UIControlEventTouchUpInside];
 button.adjustsImageWhenHighlighted = YES;
 
 UIBarButtonItem *rightButton =[[UIBarButtonItem alloc] initWithCustomView:button];
 
 
 self.navigationItem.rightBarButtonItem = rightButton;
 
 }
 */

-(void)viewWillAppear:(BOOL)animated {
    [self reload];
    [super viewWillAppear:animated];
    
    //   [self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
    //    self.navigationController.navigationController.navigationBar.translucent = YES;
}

-(void)respring {
    [HBRespringController respring];
}

+ (NSString *)hb_specifierPlist {
    return @"Root";
}

+ (NSString *)hb_shareText {
    NSString *shareScrolleX = @"I'm using a #ScrolleX by i0s_tweak3r @BrianVS. Works on all devices from iOS 13.0-13.5.x. The gold standard of system wide scroll bars available now in YouRepo.";
    return shareScrolleX;
}

+ (NSURL *)hb_shareURL {
    return [NSURL URLWithString:@"http://i0s-tweak3r-betas.yourepo.com/pack/scrollex"];
}

+ (UIColor *)hb_tintColor {
    return [UIColor redColor];
}

-(void)myOtherTweaks
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://apt.thebigboss.org/developer-packages.php?dev=i0stweak3r"]];
}

-(void)addMyRepo {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://i0s-tweak3r-betas.yourepo.com"]];
}

- (void)donate
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/i0stweak3r"]];
}
/*
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}
*/



@end
