//
//  GameState.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameState.h"


@implementation GameState



-(id) initWithObserver:(id<PlayerInputProtocol>)anObserver gameBoard:(GameBoard*)aGameBoard {
    if (self = [super init]) {
        _gameBoard = aGameBoard;
        _observer = anObserver;
    }
    return self;
}

-(void) enter {

}

-(void) handle {
    @throw [NSException exceptionWithName:@"Can't execute abstract ethod" reason:@"This method must be overrived by subclass" userInfo:nil];
}

-(void) exit {
  
}


@end
