//
//  MarketTest.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MarketTest.h"
#import "Market.h"
#import "states.h"

@implementation MarketTest

Market *market;

- (void)setUp
{
    [super setUp];
    
    market = [[Market alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testGoodAtIndex {
    STAssertEquals(kGoodNone, [market goodAtIndex:0], nil);
    STAssertEquals(kGoodNone, [market goodAtIndex:MARKET_SIZE - 1], nil);
}


- (void)testChangeGoodAtIndex {
    [market changeGood:kGoodOre atIndex:3];
    STAssertEquals(kGoodOre, [market goodAtIndex:3], nil);
}

@end
