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
    [(GameState*)[_stack lastObject] exit]; 
    [_stack addObject:state];
    [(GameState*)[_stack lastObject] enter]; 

}

-(GameState*) pop {
    GameState *last = [_stack lastObject];
    [last exit];
    [_stack removeLastObject];
    [[_stack lastObject] enter];
    return last;
}

-(void) change:(GameState*) state {
    [(GameState*)[_stack lastObject] exit];
    [_stack removeLastObject];
    [_stack addObject:state];
    [(GameState*)[_stack lastObject] enter];     
}



-(void) dealloc {
    [_stack release];
    [super dealloc];
}

@end
