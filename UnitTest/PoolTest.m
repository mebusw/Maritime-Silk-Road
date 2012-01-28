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
Pool *pool;

- (void)setUp
{
    [super setUp];
    
    pool = [[Pool alloc] init];
}

- (void)tearDown
{
    [pool release];

    [super tearDown];
}

// All code under test must be linked into the Unit Test bundle
- (void)testfetchAGood {
    STAssertEquals(GOOD_TYPE_COUNT * GOOD_COUNT_PER_TYPE, pool.remainingCards, @"not 66 cards");
    STAssertTrue([pool fetchAGood] > kGoodNone, @"can not fetched a good");
    STAssertEquals(GOOD_TYPE_COUNT * GOOD_COUNT_PER_TYPE - 1, pool.remainingCards, @"not 65 cards");
}

- (void) testPutAToken {
    int currentValue = pool.token[kGoodGlaze];
    [pool putAToken:kGoodGlaze];
    STAssertEquals(currentValue + 1, pool.token[kGoodGlaze], @"fail to put");
    

}

- (void) testPutAInvalidToken {
    STAssertThrowsSpecific([pool putAToken:kGoodNone], NSException, @"no exception");
    
//    @try {
//        [pool putAToken:kGoodNone];
//        STFail(@"no exception");
//    }
//    @catch (NSException *e) {
//        STAssertTrue(true, nil);
//        DLog(@"%@ %@", [e name], [e reason]);
//    }
//    @finally {
//        
//    }
}

@end
