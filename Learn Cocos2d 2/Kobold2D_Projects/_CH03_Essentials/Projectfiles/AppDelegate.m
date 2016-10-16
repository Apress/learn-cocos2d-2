/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "AppDelegate.h"

@implementation AppDelegate

-(void) initializationComplete
{
#ifdef KK_ARC_ENABLED
	CCLOG(@"ARC is enabled");
#else
	CCLOG(@"ARC is either not available or not enabled");
#endif
}

-(id) alternateRootViewController
{
	return nil;
}

-(id) alternateView
{
	return nil;
}

#if KK_PLATFORM_IOS
/* Uncomment this method if you need to change allowed orientations at runtime
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
	//return UIInterfaceOrientationIsPortrait(interfaceOrientation);
	//return interfaceOrientation == UIInterfaceOrientationPortrait;
	//return interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown;
	//return interfaceOrientation == UIInterfaceOrientationLandscapeLeft; // Home button on the left side
	//return interfaceOrientation == UIInterfaceOrientationLandscapeRight; // Home button on the right side
	//return YES; // support all four orientations
}
*/
#endif

@end
