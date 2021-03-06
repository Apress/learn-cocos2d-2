//
//  SecondLayer.m
//  ScenesAndLayers01
//
//  Created by Steffen Itterheim on 27.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondLayer.h"
#import "FirstLayer.h"
#import "LoadingScene.h"

@implementation SecondLayer

+(id) scene
{
	CCLOG(@"===========================================");
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	CCScene* scene = [CCScene node];
	SecondLayer* layer = [SecondLayer node];
	[scene addChild:layer];
	return scene;
}

-(id) init
{
	if ((self = [super init]))
	{
		CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
		
		CCLabelTTF* label = [CCLabelTTF labelWithString:@"Other Scene" fontName:@"Marker Felt" fontSize:64];
		label.color = ccBLUE;
		CGSize size = [CCDirector sharedDirector].winSize;
		label.position = CGPointMake(size.width / 2, size.height / 2);
		[self addChild:label];
		
		self.isTouchEnabled = YES;
	}
	return self;
}

-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	BOOL useLoadingScene = YES;
	if (useLoadingScene)
	{
		[[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneFirst]];
	}
	else
	{
		[[CCDirector sharedDirector] replaceScene:[FirstLayer scene]];
	}
}

// these methods are called when changing scenes
-(void) onEnter
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// must call super here:
	[super onEnter];
}

-(void) onEnterTransitionDidFinish
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// must call super here:
	[super onEnterTransitionDidFinish];
}

-(void) onExit
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// must call super here:
	[super onExit];
}

-(void) onExitTransitionDidStart
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// must call super here:
	[super onExitTransitionDidStart];
}

@end
