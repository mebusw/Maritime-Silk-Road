//
//  WaitForStart.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WaitForStart.h"
#import "Preparing.h"

@implementation WaitForStart


-(void) handle:(id)observer gameBoard:(GameBoard*)gameBoard {
    DLog(@"");
    [observer changeState:[[[Preparing alloc] init] autorelease]];
}


@end
