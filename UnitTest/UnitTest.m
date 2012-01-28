//
//  UnitTest.m
//  UnitTest
//
//  Created by mebusw on 12-1-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UnitTest.h"
#import "ccMacros.h"

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

- (void)testExample
{
    float f;
    f = CCRANDOM_0_1() * 2;
    DLog(@"rnd=%f %d", f, (NSInteger)f);
    f = CCRANDOM_0_1() * 2;
    DLog(@"rnd=%f %d", f, (NSInteger)f);
}

@end
