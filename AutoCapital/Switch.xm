#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>
#import "../Common.h"

static const CFStringRef KeyboardAutocapitalization = CFSTR("KeyboardAutocapitalization");

@interface AutoCapitalSwitch : NSObject <FSSwitchDataSource>
@end

@implementation AutoCapitalSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier {
	return getKeyboardPrefValue(KeyboardAutocapitalization);
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {
	if (newState == FSSwitchStateIndeterminate)
		return;
	setKeyboardPrefValue(KeyboardAutocapitalization, newState);
}

- (void)applyAlternateActionForSwitchIdentifier:(NSString *)switchIdentifier {
	NSURL *url = [NSURL URLWithString:@"prefs:root=General&path=Keyboard#KeyboardAutocapitalization"];
	[[FSSwitchPanel sharedPanel] openURLAsAlternateAction:url];
}

@end