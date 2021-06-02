#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>
#import "../Common.h"

static const CFStringRef KeyboardAutocorrection = CFSTR("KeyboardAutocorrection");

@interface AutoCorrectSwitch : NSObject <FSSwitchDataSource>
@end

@implementation AutoCorrectSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
	return getKeyboardPrefValue(KeyboardAutocorrection);
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
	if (newState == FSSwitchStateIndeterminate)
		return;
	setKeyboardPrefValue(KeyboardAutocorrection, newState);
}

- (void)applyAlternateActionForSwitchIdentifier:(NSString *)switchIdentifier
{
	NSURL *url = [NSURL URLWithString:@"prefs:root=General&path=Keyboard#KeyboardAutocorrection"];
	[[FSSwitchPanel sharedPanel] openURLAsAlternateAction:url];
}

@end