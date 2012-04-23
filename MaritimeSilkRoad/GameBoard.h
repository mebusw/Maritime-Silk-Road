//
//  GameBoard.h
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "Pool.h"
#import "Player.h"
#import "Market.h"

@interface GameBoard : NSObject {

}

@property (nonatomic, retain) Pool* pool;
@property (nonatomic, retain) NSMutableArray* players;
@property (nonatomic, retain) Market* market;

@property (nonatomic, readonly) int activePlayerIndex;
@property (nonatomic, readonly) int playerCount;
@property (nonatomic, readonly) int startPlayerIndex;
@property (nonatomic, readonly) int chosenMarket;
@property (nonatomic, readonly) int chosenAction;
@property (nonatomic, readonly) int chosenGoodType;
@property (nonatomic, readonly) int chosenSpecialType;

- (id) initWithPlayerNumber: (NSUInteger) playerNbr;
-(int) nextPlayer;


@end
