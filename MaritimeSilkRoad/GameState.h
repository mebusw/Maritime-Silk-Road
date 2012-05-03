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



@interface GameState : NSObject {
    GameLayer *_observer;
    GameBoard *_gameBoard;
}


-(void) handle;
-(void) enter;
-(void) exit;



@end
