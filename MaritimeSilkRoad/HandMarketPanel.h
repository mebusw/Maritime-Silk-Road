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
#import "Market.h"
#import "GameBoard.h"

typedef enum {
    kPanelTouchingCard,
    kPanelWaiting,
} PanelTouchStates;

@class GameBoard;

@interface HandMarketPanel : CCLayer
{
    CCSprite *cards[GOOD_TYPE_COUNT];
    CCSprite *markets[MARKET_SIZE];
    CCSprite *touchingCard;
    PanelTouchStates state;
    CCLabelTTF *labelHands[GOOD_TYPE_COUNT];
    Human *_human;
    Market *_market;
    BOOL needRefresh;
    GameBoard *_gameBoard;
}
@property (nonatomic) BOOL isBtnFinishVisible;

-(id) initWithGameBoard:(GameBoard*) gameBoard;
-(void) refresh;
-(void) setMarketAtIndex:(int)index good:(GoodTypeEnum)good;

@end
