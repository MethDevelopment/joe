/*


Features:

Hide Dock Background
Hide Folder Icon Background
Hide Folder Background
Hide Page Dots
Hide Icon Labels
Hide Testflight Dot
Hide Notification Badges
Hide App Library Blur
Set Number of Dock Icons


*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define TWEAK_PREFS_PATH @"/var/mobile/Library/Preferences/com.propr.joeprefs.plist"

static NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:TWEAK_PREFS_PATH];

BOOL getBoolSetting(NSString* setting) {
    return [[prefs objectForKey:setting] ?: @NO boolValue];
}

int getIntSetting(NSString* setting) {
    return [[prefs objectForKey:setting] intValue];
}

// hide dock background
%hook SBDockView

- (void)setBackgroundView:(UIView *)arg1 {
	if (getBoolSetting(@"hideDockBG")) {
		%orig(nil);
	} else {
		%orig;
	}
}
	
%end

// hide dock background 2 electric boogaloo
%hook SBFloatingDockView

- (void)setBackgroundView:(UIView *)arg1 {
	if (getBoolSetting(@"hideDockBG")) {
		%orig(nil);
	} else {
		%orig;
	}
}

%end

// hide folder icon background
%hook SBFolderIconImageView

- (void)setBackgroundView:(id)bgView {
	if (getBoolSetting(@"hideFolderIconBG")) {
		bgView = nil;
	} else {
		%orig;
	}
}
	
%end

// hide page dots
%hook SBIconListPageControl

- (BOOL)isHidden {
	if (getBoolSetting(@"hidePageDots")) {
		return YES;
	} else {
		return NO;
	}
}
	
%end

// hide app label
%hook SBIconView

- (void)setLabelHidden:(BOOL)hidden {
	if (getBoolSetting(@"hideLabel")) {
		%orig(YES);
	} else {
		%orig;
	}
}

%end

// hide testflight dot
%hook SBIconBetaLabelAccessoryView

- (void)setAlpha:(double)alpha {
	if (getBoolSetting(@"hideTestflight")) {
		%orig(0.0);
	} else {
		return %orig;
	}
}

%end

// hide folder background
%hook SBFolderBackgroundView
	
- (void)setAlpha:(double)alpha {
	if (getBoolSetting(@"hideFolderBG")) {
		%orig(0.0);
	} else {
		return %orig;
	}
}

%end

// hide notification badges
%hook SBIconBadgeView

- (BOOL)isHidden {
	if (getBoolSetting(@"hideNotificationBadges")) {
		return YES;
	} else {
		return NO;
	}
}
	
- (void)setAlpha:(double)alpha {
	if (getBoolSetting(@"hideNotificationBadges")) {
		%orig(0.0);
	} else {
		return %orig;
	}
}

%end

// pick how many icons on da dock
%hook SBIconListGridLayoutConfiguration

- (NSUInteger)numberOfPortraitColumns {
    NSUInteger rows = MSHookIvar<NSUInteger>(self, "_numberOfPortraitRows");
    if (rows == 1) {
		if (getIntSetting(@"numDockIcon") == 0) {
        	return %orig;
		} else {
			return getIntSetting(@"numDockIcon");
		}
	}
	
	return %orig;
}

%end

// hide app library folder blur
%hook SBHLibraryCategoryPodBackgroundView

- (void)setAlpha:(double)alpha {
	if (getBoolSetting(@"hideAppLibraryBlur")) {
		%orig(0.0);
	} else {
		return %orig;
	}
}

%end

%ctor {
    NSString *bundleID = NSBundle.mainBundle.bundleIdentifier;
    if ([bundleID isEqualToString:@"com.apple.springboard"]) {
        %init;
    }
}
