//
//  PoolTest.m
//  MaritimeSilkRoad
//
//  Created by mebusw on 12-1-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PoolTest.h"
#import "Pool.h"

@implementation PoolTest

// All code under test must be linked into the Unit Test bundle
- (void)testfetchAGood
{
    Pool *pool = [[Pool alloc] init];
    STAssertEquals(GOOD_TYPE_COUNT * GOOD_COUNT_PER_TYPE, pool.remainingCards, @"not 66 cards");
    STAssertTrue([pool fetchAGood] > kGoodNone, @"can not fetched a good");
    STAssertEquals(GOOD_TYPE_COUNT * GOOD_COUNT_PER_TYPE - 1, pool.remainingCards, @"not 65 cards");
}

@end
