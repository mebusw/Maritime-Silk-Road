//
//  GameState.h
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameBoard.h"
#import "GameLayer.h"
#import "PlayerInputProtocol.h"

@class GameBoard;

@interface GameState : NSObject {
    id<PlayerInputProtocol> _observer;
    GameBoard *_gameBoard;
}


-(id) initWithObserver:(id<PlayerInputProtocol>)anObserver gameBoard:(GameBoard*)aGameBoard;

-(void) handle;
-(void) enter;
-(void) exit;



@end
