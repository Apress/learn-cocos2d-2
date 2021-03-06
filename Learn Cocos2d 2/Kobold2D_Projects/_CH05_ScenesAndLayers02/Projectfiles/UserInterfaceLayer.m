//
//  UserInterfaceLayer.m
//  ScenesAndLayers
//
//  Created by Steffen Itterheim on 28.07.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "UserInterfaceLayer.h"
#import "MultiLayerScene.h"
#import "GameLayer.h"

@implementation UserInterfaceLayer

-(id) init
{
	if ((self = [super init]))
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];

		CCSprite* uiframe = [CCSprite spriteWithFile:@"ui-frame.png"];
		uiframe.position = CGPointMake(0, screenSize.height);
		uiframe.anchorPoint = CGPointMake(0, 1);
		[self addChild:uiframe z:0 tag:UILayerTagFrameSprite];
		
		// Fake User Interface which does nothing.
		CCLabelTTF* label = [CCLabelTTF labelWithString:@"Here be your Game Scores etc" fontName:@"Courier" fontSize:22];
		label.color = ccBLACK;
		label.position = CGPointMake(screenSize.width / 2, screenSize.height);
		label.anchorPoint = CGPointMake(0.5f, 1);
		[self addChild:label];
		
		self.isTouchEnabled = YES;
		
		// A progress timer is a sprite which is partially displayed to visualize some kind of progress.
		// Caution: modifying the anchorPoint of a CCProgressTimer will change the effect or make it disappear completely!
		CCSprite* fireSprite = [CCSprite spriteWithFile:@"firething.png"];
		CCProgressTimer* timer = [CCProgressTimer progressWithSprite:fireSprite];
		timer.type = kCCProgressTimerTypeRadial;
		timer.position = CGPointMake([CCDirector sharedDirector].winSize.width, 0);
		timer.anchorPoint = CGPointMake(1, 0); // right-align and bottom-align timer
		timer.percentage = 0;
		timer.color = ccGRAY;
		timer.scale = 1.7f;
		[self addChild:timer z:1 tag:UILayerTagProgressTimer];
		
		// The update is needed for the progress timer.
		[self scheduleUpdate];
	}
	return self;
}

-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
}


// Implements logic to check if the touch location was in an area that this layer wants to handle as input.
-(BOOL) isTouchForMe:(CGPoint)touchLocation
{
	CCNode* node = [self getChildByTag:UILayerTagFrameSprite];
	return CGRectContainsPoint([node boundingBox], touchLocation);
}

-(void) rotateAndZoomGameLayer
{
	// Simply highlight the UI layer's sprite to show that it received the touch.
	CCNode* node = [self getChildByTag:UILayerTagFrameSprite];
	NSAssert([node isKindOfClass:[CCSprite class]], @"node is not a CCSprite");
	
	((CCSprite*)node).color = ccRED;
	
	// Rotate & Zoom the game layer, just for fun.
	CCRotateBy* rotate = [CCRotateBy actionWithDuration:4 angle:360];
	CCScaleTo* scaleDown = [CCScaleTo actionWithDuration:2 scale:0];
	CCScaleTo* scaleUp = [CCScaleTo actionWithDuration:2 scale:1];
	CCSequence* sequence = [CCSequence actions:scaleDown, scaleUp, nil];
	sequence.tag = ActionTagGameLayerRotates;
	
	GameLayer* gameLayer = [MultiLayerScene sharedLayer].gameLayer;
	
	// Reset GameLayer properties modified by action so that the end result is always the same.
	[gameLayer stopActionByTag:ActionTagGameLayerRotates];
	[gameLayer setRotation:0];
	[gameLayer setScale:1];
	
	// Run the actions on the game layer.
	[gameLayer runAction:rotate];
	[gameLayer runAction:sequence];
}

#if KK_PLATFORM_IOS
-(void) registerWithTouchDispatcher
{
	[[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:-1 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event
{
	CGPoint location = [MultiLayerScene locationFromTouch:touch];
	BOOL isTouchHandled = [self isTouchForMe:location];
	if (isTouchHandled)
	{
		[self rotateAndZoomGameLayer];
	}

	return isTouchHandled;
}

-(void) ccTouchEnded:(UITouch*)touch withEvent:(UIEvent *)event
{
	CCNode* node = [self getChildByTag:UILayerTagFrameSprite];
	NSAssert([node isKindOfClass:[CCSprite class]], @"node is not a CCSprite");
	
	((CCSprite*)node).color = ccWHITE;
}
#endif

// Updates the progress timer
-(void) update:(ccTime)delta
{
	CCNode* node = [self getChildByTag:UILayerTagProgressTimer];
	NSAssert([node isKindOfClass:[CCProgressTimer class]], @"node is not a CCProgressTimer");
	
	CCProgressTimer* timer = (CCProgressTimer*)node;
	timer.percentage += delta * 10;
	if (timer.percentage >= 100)
	{
		timer.percentage = 0;
	}
	
#if KK_PLATFORM_MAC
	KKInput* input = [KKInput sharedInput];
	if ([input isMouseButtonDownThisFrame:KKMouseButtonLeft])
	{
		BOOL isTouchHandled = [self isTouchForMe:input.mouseLocation];
		if (isTouchHandled)
		{
			[self rotateAndZoomGameLayer];
		}
	}
	else if ([input isMouseButtonUpThisFrame:KKMouseButtonLeft])
	{
		CCNode* node = [self getChildByTag:UILayerTagFrameSprite];
		NSAssert([node isKindOfClass:[CCSprite class]], @"node is not a CCSprite");
		
		((CCSprite*)node).color = ccWHITE;
	}
#endif
}

@end
