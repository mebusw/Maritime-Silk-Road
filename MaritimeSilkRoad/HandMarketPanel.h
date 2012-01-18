//
//  HandMarketPanel.h
//  MaritimeSilkRoad
//
//  Created by MagicStudio on 11-12-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"

typedef enum {
    kPanelTouchingCard,
    kPanelWaiting,
} PanelTouchStates;

@interface HandMarketPanel : CCLayer
{
    CCSprite *cards[GOOD_TYPE_COUNT];
    CCSprite *markets[MARKET_SIZE];
    CCSprite *touchingCard;
    PanelTouchStates state;
    CCLabelTTF *labelHands[GOOD_TYPE_COUNT];
    User *_human;
    int *_market;
    BOOL needRefresh;
}
@property (nonatomic) BOOL isBtnFinishVisible;

-(id) initWithHuman:(User*) human market:(int*)market;
-(void) refresh;
-(void) setMarketAtIndex:(int)index good:(GoodTypeEnum)good;

@end
