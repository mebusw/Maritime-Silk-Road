//
//  GameStateTest.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameStateTest.h"
#import "OCMock/OCMock.h"

#import "WaitForStart.h"
#import "Preparing.h"

@implementation GameStateTest



- (void)setUp
{
    [super setUp];
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

-(void) test_Setup_ChangeGood {
    GameState *oldState = [[[WaitForStart alloc] init] autorelease];
    //GameState *newState = [[[Preparing alloc] init] autorelease];
    id observerMock = [OCMockObject mockForProtocol:@protocol(StateObserverProtocol)];
    [[observerMock expect] changeState:[OCMArg any]];
    
    
    [oldState handle:observerMock gameBoard:nil];
    
    
    [observerMock verify];
    
}


@end
