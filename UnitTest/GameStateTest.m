//
//  GameStateTest.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameStateTest.h"
#import "OCMock/OCMock.h"

#import "Setup.h"

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
    GameState *newState = [[Setup alloc] init];
    id observerMock = [OCMockObject mockForProtocol:@protocol(StateObserverProtocol)];
    [[observerMock expect] changeState:[OCMArg any]];
    
    
    [newState handle:observerMock];
    
    
    [observerMock verify];
    
}


@end
