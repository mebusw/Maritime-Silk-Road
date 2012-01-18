//
//  ShipsPanel.m
//  MaritimeSilkRoad
//
//  Created by MagicStudio on 11-12-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ShipsPanel.h"

#define TOKEN_WIDTH     20
@implementation ShipsPanel

-(id) initWithHuman:(User*) human {
    self = [super init];
    if (self) {
        self.isTouchEnabled = YES;
        user = human;
        [self refresh];
        state = kShipWaiting;
    }
    
    return self;
}

-(void) refresh {
    [self removeAllChildrenWithCleanup:YES];
    
    NSString *images[] = {IMG_TOKEN_CHINA, IMG_TOKEN_GLAZE, IMG_TOKEN_ORE, IMG_TOKEN_PERFUME, IMG_TOKEN_SILK, IMG_TOKEN_TEA};
    for (int i = 0; i < user.specials[kSpecialShip]; i++) {
        
        //TODO use sprite batch node or -[draw] to improve performance, definitely!!!
        CCSprite *aShip = [CCSprite spriteWithFile:images[user.ships[i]]];
        aShip.position = ccp(i * TOKEN_WIDTH, -self.contentSize.height / 2 + TOKEN_WIDTH);
        [self addChild:aShip];
    }
    
}


#pragma mark Touches

-(void) registerWithTouchDispatcher {
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:kCCMenuTouchPriority swallowsTouches:YES];
}

-(int) destShipForTouch: (UITouch *) touch {
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	
	//DLogPoint(@"touchLocation", touchLocation);
    CGRect full = CGRectMake(self.contentSize.width / 2 - TOKEN_WIDTH / 2, TOKEN_WIDTH / 2, TOKEN_WIDTH * user.specials[kSpecialShip], TOKEN_WIDTH);
    if (CGRectContainsPoint(full, touchLocation)) {
        //TODO
        return (touchLocation.x - (self.contentSize.width / 2 - TOKEN_WIDTH / 2)) / TOKEN_WIDTH;
    } else {
        return -1;
    }
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    int shipIndex = [self destShipForTouch:touch];
    if (kShipWaiting == state && shipIndex >= 0 ) {
        state = kShipTouchingToken;
        return YES;
    }
    return NO;
}



-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    int shipIndex = [self destShipForTouch:touch];
    DLog(@"shipIndex %d", shipIndex);

    GameLayer *gameLayer = (GameLayer*)(self.parent);
    [gameLayer didChooseAShip: [NSNumber numberWithInt:shipIndex]];
    
    state = kShipWaiting;
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
    state = kShipWaiting;

}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {

}


@end
