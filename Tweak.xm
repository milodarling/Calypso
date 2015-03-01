BOOL masterEnabled;
BOOL 1Enabled;
BOOL 2Enabled;
BOOL 3Enabled;
BOOL 4Enabled;
BOOL 5Enabled;

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
-(double) blurRadius{
  if(!isEnabled)
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

static void loadPrefs()
{
  NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/red.dingo.calypso.plist"];
  if(prefs)
    {
      masterEnabled = [prefs objectForKey:@"masterEnabled"] ? [[prefs objectForKey:@"masterEnabled"] boolValue] : true;
      1Enabled = [prefs objectForKey:@"1Enabled"] ? [[prefs objectForKey:@"1Enabled"] boolValue] : true;
      2Enabled = [prefs objectForKey:@"2Enabled"] ? [[prefs objectForKey:@"2Enabled"] boolValue] : true;
      3Enabled = [prefs objectForKey:@"3Enabled"] ? [[prefs objectForKey:@"3Enabled"] boolValue] : true;
      4Enabled = [prefs objectForKey:@"4Enabled"] ? [[prefs objectForKey:@"4Enabled"] boolValue] : true;
      5Enabled = [prefs objectForKey:@"5Enabled"] ? [[prefs objectForKey:@"5Enabled"] boolValue] : true;
    }
    [prefs release];
  }

  %ctor
  {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("red.dingo.calyspo/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
    }
