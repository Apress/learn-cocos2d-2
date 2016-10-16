/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "AppDelegate.h"

@implementation AppDelegate

// Note: navController is now a property declared in superclass KKAppDelegate
//@synthesize navController;

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
	// Create a Navigation Controller with the Director
	CCDirectorIOS* directorIOS = (CCDirectorIOS*)[CCDirector sharedDirector];
	navController = [[UINavigationController alloc] initWithRootViewController:directorIOS];
	navController.navigationBarHidden = YES;
	
	// set the Navigation Controller as the root view controller
	[window addSubview:navController.view];
	return nil;
}

@end
