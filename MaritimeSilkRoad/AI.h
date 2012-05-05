//
//  AI.h
//  MaritimeSilkRoad
//
//  Created by  on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameBoard.h"

@interface AI : NSObject


-(id) initWithGameBoard:(GameBoard*) gameBoard;
- (void) chooseAGoodType;
-(void) chooseForPhase1;
-(void) chooseForChangeGood;
-(void) chooseForPhase2;

@end
