//
//  HandMarketPanel.m
//  MaritimeSilkRoad
//
//  Created by MagicStudio on 11-12-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "HandMarketPanel.h"
#define CARD_WIDTH    60
#define CARD_HEIGHT   80
#define MARKET_ORIGIN_HEIGHT    CARD_WIDTH / 2 + 5
#define TOUCHING_CARD   100
#define CHILD_MARKET    51
#define CHILD_HAND      52

#define TOKEN_WIDTH     20

@implementation HandMarketPanel
@synthesize isBtnFinishVisible;

-(id) initWithHuman:(Human*) human market:(int*)market{
	if( (self=[super init]) ) {
		self.isTouchEnabled = YES;
		state = kPanelWaiting;
        _human = human;
        _market = market;
        NSString *images[] = {IMG_GOOD_CHINA, IMG_GOOD_GLAZE, IMG_GOOD_ORE, IMG_GOOD_PERFUME, IMG_GOOD_SILK, IMG_GOOD_TEA};
        
        for (int i = 0; i < GOOD_TYPE_COUNT; i++) {
            cards[i] = [CCSprite spriteWithFile:images[i]];
            cards[i].position = ccp((i - 2.5) * CARD_WIDTH, -self.contentSize.height / 2 + CARD_HEIGHT * 1.5);
            [self addChild:cards[i] z:0 tag:i];
            
            labelHands[i] = [CCLabelTTF labelWithString:STR(@"%d", _human.cardHand[i]) fontName:FONT_NAME fontSize:16];
            labelHands[i].position = ccp((i - 2.5) * CARD_WIDTH, -self.contentSize.height / 2 + CARD_HEIGHT);
            [self addChild:labelHands[i]];
        }

        needRefresh = YES;
        
        [self refresh];
   }
	return self;
}

- (void) refresh {
    if (needRefresh) {
        for (int i = 0; i < GOOD_TYPE_COUNT; i++) {
            [labelHands[i] setString:STR(@"%d", _human.cardHand[i])];
        }
        
        //  market
        //   [3][4][5]
        //   [0][1][2]
        NSString *images[] = {IMG_GOOD_CHINA, IMG_GOOD_GLAZE, IMG_GOOD_ORE, IMG_GOOD_PERFUME, IMG_GOOD_SILK, IMG_GOOD_TEA};
        [self removeChildByTag:CHILD_MARKET cleanup:YES];
        int marketIndex = 0;
        for (int row = 0; row < 2; row++) {
            for (int col = 0; col < 3; col++) {
                DLog(@"market[%d]=%d", marketIndex, _market[marketIndex]);
                markets[marketIndex] = [CCSprite spriteWithFile:images[_market[marketIndex]]];
                markets[marketIndex].position = ccp((col - 1) * CARD_WIDTH, (row + 0.5) * CARD_HEIGHT);
                [self addChild:markets[marketIndex] z:0 tag:CHILD_MARKET];
                marketIndex++;
            }
        }
    }    
    needRefresh = NO;
      
}

-(void) setMarketAtIndex:(int)index good:(GoodTypeEnum)good {
    DLog(@"index %d good %d", index, good);
    _market[index] = good;
    
    needRefresh = YES;
}


- (void) onExit
{
	[super onExit];
}

#pragma mark Touches

-(void) registerWithTouchDispatcher {
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:kCCMenuTouchPriority swallowsTouches:YES];
}

-(GoodTypeEnum) srcCardForTouch: (UITouch *) touch {
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	//DLogPoint(@"touchLocation", touchLocation);
    
	for (int i = 0; i < GOOD_TYPE_COUNT; i++) {
        CCSprite *card = cards[i];
        CGPoint local = [card convertToNodeSpace:touchLocation];
        //DLogPoint(@"local", local);
        CGRect r = CGRectMake(0, 0, CARD_WIDTH, CARD_HEIGHT);
        
        if (CGRectContainsPoint(r, local))
            return i;
		
	}

	return kGoodNone;
}

-(int) destMarketForTouch: (UITouch *) touch {
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	
	//DLogPoint(@"touchLocation", touchLocation);
    
	for (int i = 0; i < MARKET_SIZE; i++) {
        CCSprite *market = markets[i];
        CGPoint local = [market convertToNodeSpace:touchLocation];
        //DLogPoint(@"local", local);
        CGRect r = CGRectMake(0, 0, CARD_WIDTH, CARD_HEIGHT);
        
        if (CGRectContainsPoint(r, local))
            return i;
	}

	return -1;
}


-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    
    if (kPanelWaiting == state) {
        CGPoint touchLocation = [touch locationInView: [touch view]];
        touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
        GoodTypeEnum touchedCard = [self srcCardForTouch:touch];
        if (kGoodNone != touchedCard) {
            touchingCard = [CCSprite spriteWithFile:IMG_GOOD_GLAZE];
            [self addChild:touchingCard z:1 tag:TOUCHING_CARD];
            touchingCard.position = [self convertToNodeSpace:touchLocation];
            state = kPanelTouchingCard;
            return YES;
        }
    }
    return NO;
}

-(void) removeTouchingCard {
    [self removeChild:touchingCard cleanup:YES];
    state = kPanelWaiting;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (kPanelTouchingCard == state) {
        int marketIndex = [self destMarketForTouch:touch];
        DLog(@"marketIndex %d", marketIndex);
        if (-1 == marketIndex) {
            [self removeTouchingCard];
        } else {
            
            //id moveto = [CCMoveTo actionWithDuration:1.0 position:ccp(20, 20)];
            id spawn = [CCSpawn actions:[CCScaleTo actionWithDuration:0.5 scale:0.6], nil];
            id funcn = [CCCallFuncN actionWithTarget:self selector:@selector(removeTouchingCard)];
            id pulse = [CCSequence actions:spawn, funcn, nil];
            [touchingCard runAction:pulse];
        }
    }
    
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
    [self removeTouchingCard];
    state = kPanelWaiting;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {

    if (kPanelTouchingCard == state && touchingCard) {
        CGPoint touchLocation = [touch locationInView: [touch view]];
        touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
        touchingCard.position = [self convertToNodeSpace:touchLocation];
    }
}


@end
