#import <Preferences/PSListController.h>

@interface CalypsoListController: PSListController {
}
@end

@implementation CalypsoListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Calypso" target:self] retain];
	}
	return _specifiers;
}
-(void)respring{
system("killall -9 backboardd");
}
- (void)save
{
    [self.view endEditing:YES];
}
@end

// vim:ft=objc
