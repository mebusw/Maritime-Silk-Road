//
//  StateStack.m
//  MaritimeSilkRoad
//
//  Created by  on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StateStack.h"

@implementation StateStack

NSMutableArray *_stack;

-(id) init {
    if (self == [super init]) {
        _stack = [[NSMutableArray alloc] init];
    }
    return self;
}
-(GameState*) top {
    return [_stack lastObject];
}

-(void) push:(GameState*) state {
    [_stack addObject:state];
}

-(GameState*) pop {
    GameState *last = [_stack lastObject];
    [_stack removeLastObject];
    return last;
}

-(void) change:(GameState*) state {
    [self pop];
    [self push:state];
}



-(void) dealloc {
    [_stack release];
    [super dealloc];
}

@end
