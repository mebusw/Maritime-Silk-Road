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

@synthesize needRefresh;

-(id) init {
    if (self = [super init]) {
        for (int i = 0; i < MARKET_SIZE; i++) {
            _goodCards[i] = kGoodNone;
        }
    }
    return self;
}

-(GoodTypeEnum) goodAtIndex:(int) index {
    return _goodCards[index];
}

-(void) changeGood:(GoodTypeEnum)good atIndex:(int) index {
    _goodCards[index] = good;
    needRefresh = YES;
}


-(int) countOfGood:(GoodTypeEnum)good {
    int sum = 0;
    for (int i = 0; i < MARKET_SIZE; i++) {
        if (_goodCards[i] == good) {
            sum ++;
        }
    }
    return sum;
}


- (void)dealloc {
    [super dealloc];
}

@end
