//
//  GameBoardTest.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameBoardTest.h"
#import "GameBoard.h"



@implementation GameBoardTest

- (void)setUp
{
    [super setUp];
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

-(void) testNextPlayer {
    GameBoard *gb = [[GameBoard alloc] init];
    [gb buildGameBoardWithPlayerNumber:3];
    gb.players = [NSArray arrayWithObjects:@"a", @"b", @"c", nil];
    int currentPlayer = gb.activePlayerIndex;

    
    
    STAssertEquals((currentPlayer + 1) % gb.playerCount, [gb nextPlayer], nil);
    STAssertEquals((currentPlayer + 1) % gb.playerCount, gb.activePlayerIndex, nil);
    STAssertEquals((currentPlayer + 2) % gb.playerCount, [gb nextPlayer], nil);
    STAssertEquals((currentPlayer + 2) % gb.playerCount, gb.activePlayerIndex, nil);

}



@end
