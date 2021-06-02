#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIKeyboardImpl.h>
#import <Flipswitch/FSSwitchDataSource.h>
#import <version.h>

static NSString *const PREF_PATH = @"/var/mobile/Library/Preferences/com.apple.Preferences.plist";

static FSSwitchState getKeyboardPrefValue(CFStringRef key) {
	if (IS_IOS_OR_NEWER(iOS_8_0)) {
		Boolean valid = NO;
		Boolean value = CFPreferencesGetAppBooleanValue(key, CFSTR("com.apple.Preferences"), &valid);
		return !valid || value ? FSSwitchStateOn : FSSwitchStateOff;
	}
	NSDictionary *defaults = [NSDictionary dictionaryWithContentsOfFile:PREF_PATH];
	id value2 = [defaults objectForKey:(NSString *)key];
	return !value2 || [value2 boolValue] ? FSSwitchStateOn : FSSwitchStateOff;
}

static void setKeyboardPrefValue(CFStringRef key, FSSwitchState state) {
	BOOL value = state == FSSwitchStateOn;
	if (IS_IOS_OR_NEWER(iOS_8_0))
		CFPreferencesSetAppValue(key, (CFPropertyListRef)(value ? kCFBooleanTrue : kCFBooleanFalse), CFSTR("com.apple.Preferences"));
	else {
		NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
		[defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:PREF_PATH]];
		[defaults setObject:@(value) forKey:(NSString *)key];
		[defaults writeToFile:PREF_PATH atomically:YES];
	}
	[UIKeyboardImpl sharedInstance];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("AppleKeyboardsSettingsChangedNotification"), NULL, NULL, YES);
}