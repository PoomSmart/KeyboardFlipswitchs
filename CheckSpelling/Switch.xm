#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>
#import "../Common.h"

static const CFStringRef KeyboardCheckSpelling = CFSTR("KeyboardCheckSpelling");

@interface CheckSpellingSwitch : NSObject <FSSwitchDataSource>
@end

@implementation CheckSpellingSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
	return getKeyboardPrefValue(KeyboardCheckSpelling);
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
	if (newState == FSSwitchStateIndeterminate)
		return;
	setKeyboardPrefValue(KeyboardCheckSpelling, newState);
}

@end