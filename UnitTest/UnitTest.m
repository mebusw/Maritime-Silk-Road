//
//  UnitTest.m
//  UnitTest
//
//  Created by MagicStudio on 11-11-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UnitTest.h"
#import "Pool.h"

@implementation UnitTest

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

- (void)testfetchAGood
{
    Pool *pool = [[Pool alloc] init];
    STAssertEquals(GOOD_TYPE_COUNT * GOOD_COUNT_PER_TYPE, pool.remainingCards, @"not 66 cards");
    STAssertTrue([pool fetchAGood] > kGoodNone, @"can not fetched a good");
    STAssertEquals(GOOD_TYPE_COUNT * GOOD_COUNT_PER_TYPE - 1, pool.remainingCards, @"not 65 cards");
}



@end
