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

- (void)testSyntaxSugarOfiOS6SDK {
    NSArray *array = @[ @"object1", @"object2", @"object3" ];
    STAssertEquals(@"object2", array[1], nil);
    
    NSDictionary *dict = @{@"key1": @"value1", @"key2": @"value2", @"key3": @"value3" };
    STAssertEquals(@"value2", dict[@"key2"], nil);
    
    NSNumber *number = @12345;
    STAssertEqualObjects(@12345, number, nil);
    STAssertEquals(12345, [number intValue], nil);
    
    // @synthesize is not needed any more
    
    typedef enum Week:NSUInteger{
        Monday,
        Tuesday,
        Wednesday,
        Thursday,
        Friday,
        Saturday,
        Sunday
    } Week;
    
    NSUInteger weekday = Monday;
    STAssertEquals(Monday, weekday, nil);
    
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
