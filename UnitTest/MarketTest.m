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

- (void)testGoodAtIndexInit {
    STAssertEquals(kGoodNone, market.goodCards[0], nil);
    STAssertEquals(kGoodNone, market.goodCards[MARKET_SIZE - 1], nil);
}


- (void)testChangeGoodAtIndex {
    [market changeGood:kGoodOre atIndex:3];
    STAssertEquals(kGoodOre, market.goodCards[3], nil);
}


- (void)testCountOfGood {
    STAssertEquals(0, [market countOfGood:kGoodOre], nil);
    
    [market changeGood:kGoodOre atIndex:3];
    [market changeGood:kGoodOre atIndex:1];
    STAssertEquals(2, [market countOfGood:kGoodOre], nil);

    [market changeGood:kGoodPerfume atIndex:1];
    STAssertEquals(1, [market countOfGood:kGoodOre], nil);

}

@end
