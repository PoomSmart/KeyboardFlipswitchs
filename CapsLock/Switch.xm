#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>
#import "../Common.h"

static const CFStringRef KeyboardCapsLock = CFSTR("KeyboardCapsLock");

@interface CapsLockSwitch : NSObject <FSSwitchDataSource>
@end

@implementation CapsLockSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
	return getKeyboardPrefValue(KeyboardCapsLock);
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
	if (newState == FSSwitchStateIndeterminate)
		return;
	setKeyboardPrefValue(KeyboardCapsLock, newState);
}

@end