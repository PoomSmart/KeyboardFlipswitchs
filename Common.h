#import <UIKit/UIKit.h>
#import "../PS.h"
#import <Flipswitch/FSSwitchDataSource.h>

static NSString *const PREF_PATH = @"/var/mobile/Library/Preferences/com.apple.Preferences.plist";

@interface UIKeyboardImpl : NSObject
+ (UIKeyboardImpl *)sharedInstance;
@end

static FSSwitchState getKeyboardPrefValue(CFStringRef key)
{
	if (isiOS8Up) {
		Boolean valid = NO;
		Boolean value = CFPreferencesGetAppBooleanValue(key, CFSTR("com.apple.Preferences"), &valid);
		return valid ? value ? FSSwitchStateOn : FSSwitchStateOff : FSSwitchStateOn;
	}
	NSDictionary *defaults = [NSDictionary dictionaryWithContentsOfFile:PREF_PATH];
	id value2 = [defaults objectForKey:(NSString *)key];
	return value2 ? [value2 boolValue] ? FSSwitchStateOn : FSSwitchStateOff : FSSwitchStateOn;
}

static void setKeyboardPrefValue(CFStringRef key, FSSwitchState state)
{
	BOOL value = state == FSSwitchStateOn;
	if (isiOS8Up)
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