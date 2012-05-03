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
    GameState *state1 = [[GameState alloc] init];
    GameState *state2 = [[GameState alloc] init];
    [stack push:state1];
    [stack push:state2];
    
    STAssertEquals(state2, [stack top], nil);
}


- (void)testPopFromStack {
    GameState *state1 = [[GameState alloc] init];
    GameState *state2 = [[GameState alloc] init];
    [stack push:state1];
    [stack push:state2];
    
    STAssertEquals(state2, [stack top], nil);
    STAssertEquals(state2, [stack pop], nil);
    STAssertEquals(state1, [stack top], nil);
    STAssertEquals(state1, [stack pop], nil);
    STAssertNil([stack top], nil);
}

-(void) testChangeTopOfStack {
    GameState *state1 = [[GameState alloc] init];
    [stack push:state1];

    STAssertEquals(state1, [stack top], nil);

    GameState *state2 = [[GameState alloc] init];
    [stack change:state2];
    
    STAssertEquals(state2, [stack top], nil);
    
}

/*
 -(void) testOCMockExample {
 MasterViewController *controller = [[MasterViewController alloc] init];
 NSIndexPath *dummyIndexPath = [NSIndexPath indexPathForRow:3 inSection:1];
 id tableViewMock = [OCMockObject mockForClass:[UITableView class]];
 [[tableViewMock expect] deleteRowsAtIndexPaths:[NSArray arrayWithObject:dummyIndexPath] withRowAnimation:UITableViewRowAnimationFade];
 
 // Invoke functionality to be tested
 // If you want to see the test fail you can, for example, change the editing style to UITableViewCellEditingStyleNone. In
 // that case the method in the controller does not make a call to the table view and the mock will raise an exception when
 // verify is called further down.
 
 [controller tableView:tableViewMock commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:dummyIndexPath];
 
 // Verify that expectations were met
 
 [tableViewMock verify];
 
 
 }
 */

@end
