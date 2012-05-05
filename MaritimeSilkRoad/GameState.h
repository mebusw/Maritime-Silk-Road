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

@class GameLayer;

@interface GameState : NSObject {
    GameLayer *_observer;
    GameBoard *_gameBoard;
}


-(id) initWithObserver:(GameLayer*)aGameLayer gameBoard:(GameBoard*)aGameBoard;

-(void) handle;
-(void) enter;
-(void) exit;



@end
