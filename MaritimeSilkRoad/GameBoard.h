//
//  GameBoard.h
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "Pool.h"
#import "Player.h"


@interface GameBoard : NSObject

@property (nonatomic, retain) Pool* pool;
@property (nonatomic, retain) NSArray* players;


@end
