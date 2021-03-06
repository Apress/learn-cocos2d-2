//
//  EnemyCache.h
//  ShootEmUp
//
//  Created by Steffen Itterheim on 20.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface EnemyCache : CCNode 
{
	CCSpriteBatchNode* batch;
	NSMutableArray* enemies;
	
	int updateCount;
}

@end
