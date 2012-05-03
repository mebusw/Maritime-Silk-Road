//
//  GameState.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameState.h"


@implementation GameState


-(id) init {
    if (self = [super init]) {
        ;
    }
    return self;
}

-(void) enter {
    
}

-(void) handle {
    @throw [NSException exceptionWithName:@"Can't execute abstract ethod" reason:@"This method must be overrived by subclass" userInfo:nil];
}

-(void) exit {
    
}


@end
