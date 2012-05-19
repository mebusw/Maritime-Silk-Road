//
//  Setup.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Preparing.h"
#import "LoadGoods.h"
#import "Player.h"

@implementation Preparing

-(void) enter {
    DLog(@"");
    _gameBoard.remainingTurns = 2 * _gameBoard.playerCount;
    [_observer.stateStack change:[[[LoadGoods alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]];

}



-(void) handle {
}

@end
