#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>
#import "../Common.h"

static const CFStringRef KeyboardPeriodShortcut = CFSTR("KeyboardPeriodShortcut");

@interface DotShortcutSwitch : NSObject <FSSwitchDataSource>
@end

@implementation DotShortcutSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
	return getKeyboardPrefValue(KeyboardPeriodShortcut);
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
	if (newState == FSSwitchStateIndeterminate)
		return;
	setKeyboardPrefValue(KeyboardPeriodShortcut, newState);
}

@end