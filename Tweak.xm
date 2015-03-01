BOOL isEnabled;

%hook SBVoiceControlController
-(bool) handleHomeButtonHeld{
  if(!isEnabled){
    return false;
    return %orig;
  } else {
    return %orig;
  }
}
%end

%hook SBSearchScrollView
-(bool) gestureRecognizerShouldBegin:(id)arg1{
  if(isEnabled){
    return false;
	return %orig;
  } else {
    return %orig;
  }	
}
%end

%hook SBLockOverlayStyleProperties
-(double) blurRadius{
  if(!isEnabled){
    return 0;
    return %orig;
  } else {
    return %orig;
  }	
}
%end

 %hook SBLockOverlayStyleProperties   
-(double) tintAlpha{
  if(isEnabled){
    return 0;
    return %orig;
  } else {
    return %orig;
  }
}    
%end

%hook SBFolderSettings
-(bool) allowNestedFolders{
  if(!isEnabled){
    return true;
    return %orig;
  } else {
    return %orig;
  }
}
%end

static void loadPrefs()
{
  NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/red.dingo.calypso.plist"];
  if(prefs)
    {
      isEnabled = [prefs objectForKey:@"isEnabled"] ? [[prefs objectForKey:@"isEnabled"] boolValue] : true;
    }
    [prefs release];
  }

  %ctor
  {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("red.dingo.calyspo/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
    }