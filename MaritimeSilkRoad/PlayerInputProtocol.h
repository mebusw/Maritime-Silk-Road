//
//  PlayerInputProtocol.h
//  MaritimeSilkRoad
//
//  Created by  on 12-5-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameState.h"

@protocol PlayerInputProtocol <NSObject> 


-(void) chooseAGoodFromPool;
-(void) chooseForPhase1;
-(void) chooseAShipFromHand;
-(void) chooseASpecialFromPool;
-(void) chooseForPhase2;
-(void) chooseToSell;


@end
