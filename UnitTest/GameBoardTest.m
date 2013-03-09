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

GameBoard *gb;

- (void)setUp
{
    [super setUp];
    gb = [[GameBoard alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

-(void) testNextPlayer {
    
    [gb buildGameBoardWithPlayerNumber:3];
    gb.players = [NSArray arrayWithObjects:@"a", @"b", @"c", nil];
    int currentPlayer = gb.activePlayerIndex;

    STAssertEquals((currentPlayer + 1) % gb.playerCount, [gb nextPlayer], nil);
    STAssertEquals((currentPlayer + 1) % gb.playerCount, gb.activePlayerIndex, nil);
    STAssertEquals((currentPlayer + 2) % gb.playerCount, [gb nextPlayer], nil);
    STAssertEquals((currentPlayer + 2) % gb.playerCount, gb.activePlayerIndex, nil);

}

-(void) testBuildGameBoardWithPlayerNumber {
    [gb buildGameBoardWithPlayerNumber:3];
    STAssertEquals(3, gb.playerCount, nil);
    STAssertTrue((gb.startPlayerIndex < 3 && gb.startPlayerIndex >= 0), nil);
    STAssertEquals(3u, [gb.players count], nil);
}

@end
