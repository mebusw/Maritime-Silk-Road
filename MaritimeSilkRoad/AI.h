//
//  AI.h
//  MaritimeSilkRoad
//
//  Created by  on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameBoard.h"
#import "PlayerInputProtocol.h"

@interface AI : NSObject<PlayerInputProtocol>


-(id) initWithGameBoard:(GameBoard*) gameBoard;


@end
