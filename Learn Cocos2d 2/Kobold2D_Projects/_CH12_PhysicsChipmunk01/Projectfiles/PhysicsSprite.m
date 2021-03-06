//
//  PhysicsSprite.m
//  cocos2d-2.x-Chipmunk-ARC-iOS
//
//  Created by Steffen Itterheim on 18.05.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import "PhysicsSprite.h"

// callback to remove Shapes from the Space
void removeShape(cpBody* body, cpShape* shape, void* data)
{
	cpShapeFree(shape);
}

#pragma mark - PhysicsSprite
@implementation PhysicsSprite

@synthesize physicsBody;

// this method will only get called if the sprite is batched.
// return YES if the physic's values (angles, position ) changed.
// If you return NO, then nodeToParentTransform won't be called.
-(BOOL) dirty
{
	return YES;
}

// returns the transform matrix according the Chipmunk Body values
-(CGAffineTransform) nodeToParentTransform
{	
	CGFloat x = physicsBody->p.x;
	CGFloat y = physicsBody->p.y;
	
	if (ignoreAnchorPointForPosition_)
	{
		x += anchorPointInPoints_.x;
		y += anchorPointInPoints_.y;
	}
	
	// Make matrix
	CGFloat c = physicsBody->rot.x;
	CGFloat s = physicsBody->rot.y;
	
	if (!CGPointEqualToPoint(anchorPointInPoints_, CGPointZero))
	{
		x += c*-anchorPointInPoints_.x + -s*-anchorPointInPoints_.y;
		y += s*-anchorPointInPoints_.x + c*-anchorPointInPoints_.y;
	}
	
	// Translate, Rot, anchor Matrix
	transform_ = CGAffineTransformMake(c, s, -s, c, x, y);
	return transform_;
}

-(void) dealloc
{
	CCLOG(@"dealloc %@", self);
	cpBodyEachShape(physicsBody, removeShape, NULL);
	cpBodyFree(physicsBody);
}

@end
