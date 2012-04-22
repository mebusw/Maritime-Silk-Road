//
//  GameState.h
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameBoard.h"



@interface GameState : NSObject


-(void) handle:(id)observer gameBoard:(GameBoard*)gameBoard;


@end


@protocol StateObserverProtocol <NSObject> 

-(void) changeState:(GameState*) newState;

@end
