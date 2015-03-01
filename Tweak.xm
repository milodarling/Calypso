static BOOL masterEnabled = YES;
static BOOL 1Enabled = YES;
static BOOL 2Enabled = YES;
static BOOL 3Enabled = YES;
static BOOL 4Enabled = YES;
static BOOL 5Enabled = YES;


%hook SBVoiceControlController
-(bool) handleHomeButtonHeld
{
    if(masterEnabled == YES)
        {
            if(1Enabled == YES)
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
            if(2Enabled == YES)
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
            if(3Enabled == YES)
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
            if(4Enabled == YES)
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
            if(5Enabled == YES)
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
1Enabled = [(id)CFPreferencesCopyAppValue(CFSTR("1Enabled"), CFSTR("red.dingo.calypso")) boolValue];
2Enabled = [(id)CFPreferencesCopyAppValue(CFSTR("2Enabled"), CFSTR("red.dingo.calypso")) boolValue];
3Enabled = [(id)CFPreferencesCopyAppValue(CFSTR("3Enabled"), CFSTR("red.dingo.calypso")) boolValue];
4Enabled = [(id)CFPreferencesCopyAppValue(CFSTR("4Enabled"), CFSTR("red.dingo.calypso")) boolValue];
5Enabled = [(id)CFPreferencesCopyAppValue(CFSTR("5Enabled"), CFSTR("red.dingo.calypso")) boolValue];
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
