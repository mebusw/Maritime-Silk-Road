//
//  Market.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Market.h"
#import "states.h"

@implementation Market

-(id) init {
    if (self = [super init]) {
        _array =  [[NSMutableArray alloc] initWithCapacity:MARKET_SIZE];
        for (int i = 0; i < MARKET_SIZE; i++) {
            NSNumber *num = [[NSNumber alloc] initWithInt:kGoodNone];
            [_array addObject:num];
        }
    }
    return self;
}

-(GoodTypeEnum) goodAtIndex:(int) index {
    NSNumber *num = [_array objectAtIndex:index];
    return (GoodTypeEnum)[num intValue];
}

-(void) changeGood:(GoodTypeEnum)good atIndex:(int) index {
    NSNumber *num = [NSNumber numberWithInt:good];
    [_array insertObject:num atIndex:index];    
}

- (void)dealloc {
    [super dealloc];
    [_array release];
}

@end
