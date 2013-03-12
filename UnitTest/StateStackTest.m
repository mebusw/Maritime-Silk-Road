//
//  StateStackTest.m
//  MaritimeSilkRoad
//
//  Created by  on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StateStackTest.h"
#import "StateStack.h"
#import "GameState.h"

@implementation StateStackTest


StateStack *stack;


- (void)setUp
{
    [super setUp];
    stack = [[StateStack alloc] init];
}

- (void)tearDown
{
    [stack release];
    
    [super tearDown];
}

- (void)testGetNilFromTopOfEmptyStack {
    id top = [stack top];
    STAssertNil(top, nil);
}

- (void)testPushToStack {
    id state1 = [OCMockObject mockForClass:[GameState class]];
    [[state1 expect] enter];
    id state2 = [OCMockObject mockForClass:[GameState class]];
    [[state1 expect] exit];
    [[state2 expect] enter];
    
    [stack push:state1];
    [stack push:state2];
    
    [state1 verify];
    [state2 verify];
    STAssertEquals(state2, [stack top], nil);
}


- (void)testPopFromStack {
    id state1 = [OCMockObject mockForClass:[GameState class]];
    [[state1 expect] enter];
    id state2 = [OCMockObject mockForClass:[GameState class]];
    [[state1 expect] exit];
    [[state2 expect] enter];
    
    [stack push:state1];
    [stack push:state2];
    
    [state1 verify];
    [state2 verify];

    /////////////////
    
    [[state2 expect] exit];
    [[state1 expect] enter];
    [[state1 expect] exit];
    STAssertEquals(state2, [stack top], nil);
    STAssertEquals(state2, [stack pop], nil);
    STAssertEquals(state1, [stack top], nil);
    STAssertEquals(state1, [stack pop], nil);
    STAssertNil([stack top], nil);
    [state1 verify];
    [state2 verify];

}

- (void)testPopFromEmptyStack {
    STAssertNil([stack pop], nil);  
}



-(void) testChangeTopOfStack {
    id state1 = [OCMockObject mockForClass:[GameState class]];
    [[state1 expect] enter];
    id state2 = [OCMockObject mockForClass:[GameState class]];
    [[state1 expect] exit];
    [[state2 expect] enter];
    
    [stack push:state1];
    [stack push:state2];
    
    [state1 verify];
    [state2 verify];
    STAssertEquals(state2, [stack top], nil);

    //////////////////
    
    id state3 = [OCMockObject mockForClass:[GameState class]];
    [[state2 expect] exit];
    [[state3 expect] enter];

    [stack change:state3];
    
    STAssertEquals(state3, [stack top], nil);
    [state3 verify];
    [state2 verify];
        
}

-(void) testTransiteTo {
    id stateDummy = [OCMockObject mockForClass:[GameState class]];
    [stack addState:stateDummy forName:@"DUMMY"];
    [[stateDummy expect] enter];
    
    [stack transiteTo:@"DUMMY"];

    [stateDummy verify];
}


@end
