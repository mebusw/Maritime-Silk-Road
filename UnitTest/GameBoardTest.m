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
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

-(void) testNextPlayer {
    GameBoard *gb = [[[GameBoard alloc] init] autorelease];
    gb.players = [NSArray arrayWithObjects:@"a", @"b", @"c", nil];
    gb.activePlayerIndex = 1;
    
    
    STAssertEquals(2, [gb nextPlayer], nil);
    STAssertEquals(2, gb.activePlayerIndex, nil);
    STAssertEquals(0, [gb nextPlayer], nil);
    STAssertEquals(0, gb.activePlayerIndex, nil);

}

@end
