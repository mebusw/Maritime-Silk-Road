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
