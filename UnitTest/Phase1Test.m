//
//  Phase1Test.m
//  MaritimeSilkRoad
//
//  Created by mebusw on 13-3-12.
//
//

#import "Phase1Test.h"
#import "Phase1.h"
#import "GameBoard.h"

@implementation Phase1Test


Phase1 *state;
GameBoard *gb;
id mockView;

- (void)setUp
{
    [super setUp];
    gb = [[GameBoard alloc] init];
    [gb prepareForPlayerNumber:1];
    gb.remainingTurns = 1;
    
    mockView = [OCMockObject mockForProtocol:@protocol(PlayerInputProtocol)];
    state = [[Phase1 alloc] initWithObserver:mockView gameBoard:gb];
}

- (void)tearDown
{
    [state release];
    [gb release];
    [super tearDown];
}


- (void)testEnter_promptToCHooseActionIfRemainsTurns {
    [[mockView expect] chooseForPhase1];
    
    [state enter];
  
    [mockView verify];
//    STAssertEquals(4, gb.pool.token[kGoodOre], nil);
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
