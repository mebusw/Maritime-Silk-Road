//
//  StateStack.h
//  MaritimeSilkRoad
//
//  Created by  on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameState.h"
#import "GameBoard.h"

@class GameState;
@class GameBoard;

@interface StateStack : NSObject {
    
}

-(GameState*) top;
-(void) push:(GameState*) state;
-(GameState*) pop;
-(void) change:(GameState*) state;

@end
