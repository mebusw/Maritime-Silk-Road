//
//  ShipsPanel.h
//  MaritimeSilkRoad
//
//  Created by MagicStudio on 11-12-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"
#import "GameLayer.h"

@class GameLayer;

typedef enum {
    kShipTouchingToken,
    kShipWaiting,
} ShipTouchStates;

@interface ShipsPanel : CCLayer {
    Human *user;
    ShipTouchStates state;

}

-(id) initWithHuman:(Human*) human;

-(void) refresh;

@end
