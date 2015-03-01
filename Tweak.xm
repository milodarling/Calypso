static BOOL masterEnabled = YES;
static BOOL oneEnabled = YES;
static BOOL twoEnabled = YES;
static BOOL threeEnabled = YES;
static BOOL fourEnabled = YES;
static BOOL fiveEnabled = YES;


%hook SBVoiceControlController
-(bool) handleHomeButtonHeld
{
    if(masterEnabled == YES)
        {
            if(oneEnabled == YES)
                {
                return false;
                }
                else
                {
                return %orig;
                }
        }
    else
        {
        return %orig;
        }
}
%end

%hook SBSearchScrollView
-(bool) gestureRecognizerShouldBegin:(id)arg1
{
    if(masterEnabled == YES)
        {
            if(twoEnabled == YES)
                {
                return false;
                }
                else
                {
                return %orig;
                }
        }
    else
        {
        return %orig;
        }
}
%end

%hook SBLockOverlayStyleProperties
-(double) blurRadius
{
    if(masterEnabled == YES)
        {
            if(threeEnabled == YES)
                {
                return 0;
                }
                else
                {
                return %orig;
                }
        }
    else
        {
        return %orig;
        }
}
%end

%hook SBLockOverlayStyleProperties   
-(double) tintAlpha
{
    if(masterEnabled == YES)
        {
            if(fourEnabled == YES)
                {
                return 0;
                }
                else
                {
                return %orig;
                }
        }
    else
        {
        return %orig;
        }
}
%end

%hook SBFolderSettings
-(bool) allowNestedFolders
{
    if(masterEnabled == YES)
        {
            if(fiveEnabled == YES)
                {
                return true;
                }
                else
                {
                return %orig;
                }
        }
    else
        {
        return %orig;
        }
}
%end

static void loadPreferences() {
CFPreferencesAppSynchronize(CFSTR("red.dingo.calypso"));

masterEnabled = [(id)CFPreferencesCopyAppValue(CFSTR("masterEnabled"), CFSTR("red.dingo.calypso")) boolValue];
oneEnabled = [(id)CFPreferencesCopyAppValue(CFSTR("oneEnabled"), CFSTR("red.dingo.calypso")) boolValue];
twoEnabled = [(id)CFPreferencesCopyAppValue(CFSTR("twoEnabled"), CFSTR("red.dingo.calypso")) boolValue];
threeEnabled = [(id)CFPreferencesCopyAppValue(CFSTR("threeEnabled"), CFSTR("red.dingo.calypso")) boolValue];
fourEnabled = [(id)CFPreferencesCopyAppValue(CFSTR("fourEnabled"), CFSTR("red.dingo.calypso")) boolValue];
fiveEnabled = [(id)CFPreferencesCopyAppValue(CFSTR("fiveEnabled"), CFSTR("red.dingo.calypso")) boolValue];
}

%ctor {
CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
NULL,
(CFNotificationCallback)loadPreferences,
CFSTR("red.dingo.calyspo/settingschanged"),
NULL,
CFNotificationSuspensionBehaviorDeliverImmediately);
loadPreferences();
}
