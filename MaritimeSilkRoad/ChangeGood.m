//
//  ChangeGood.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChangeGood.h"

@implementation ChangeGood

-(void) handle:(id)observer gameBoard:(GameBoard*)gameBoard {
    
    [observer changeState:[[[ChangeGood alloc] init] autorelease]];
}

@end
