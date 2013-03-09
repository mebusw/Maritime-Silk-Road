//
//  LoadGoodsStateTest.m
//  MaritimeSilkRoad
//
//  Created by  on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoadGoodsStateTest.h"
#import "LoadGoods.h"
#import "GameBoard.h"

@implementation LoadGoodsStateTest

LoadGoods *state;
GameBoard *gb;
id mockView;

- (void)setUp
{
    [super setUp];
    gb = [[GameBoard alloc] init];
    [gb prepareForPlayerNumber:2];
    gb.remainingTurns = 2;

    mockView = [[OCMockObject alloc] init];
    state = [[LoadGoods alloc] initWithObserver:mockView gameBoard:gb];
    
}

- (void)tearDown
{
    [state release];
    [gb release];
    [mockView release];
    [super tearDown];
}

- (void)testEnter_NoRemainings {
    gb.remainingTurns = 0;
    
    [state enter];
    
    STAssertEquals(2, gb.remainingTurns, nil);
}


- (void)testHandle_currentPlayerShouldGetAGoodFromBoard {
    gb.chosenOption = kGoodOre;
    gb.pool.token[kGoodOre] = 5;
    id mockPlayer1 = [OCMockObject mockForClass:[Player class]];
    [[mockPlayer1 expect] loadGoodToShip:kGoodOre atIndex:0];
    [gb.players setObject:mockPlayer1 atIndexedSubscript:gb.activePlayerIndex];
    
    [state handle];
    
    STAssertEquals(4, gb.pool.token[kGoodOre], nil);
}

/*
id mock = [OCMockObject mockForClass:[SomeClass class]]
id mock = [OCMockObject partialMockForObject:anObject]
id aMock = [OCMockObject mockForProtocol:@protocol(SomeProtocol)]

[[mock expect] someMethod:[OCMArg checkWithBlock:^BOOL(id value) {  return YES if value is ok  }]]
[[[mock stub] andReturn:aValue] someMethod:someArgument]
*/

//- (void)testPushToStack {
//    id state1 = [OCMockObject mockForClass:[GameState class]];
//    [[state1 expect] enter];
//    id state2 = [OCMockObject mockForClass:[GameState class]];
//    [[state1 expect] exit];
//    [[state2 expect] enter];
//    
//    [stack push:state1];
//    [stack push:state2];
//    
//    [state1 verify];
//    [state2 verify];
//    STAssertEquals(state2, [stack top], nil);
//}


@end
