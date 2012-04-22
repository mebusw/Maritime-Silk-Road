//
//  Market.h
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "states.h"
@interface Market : NSObject {
    int _goodCards[MARKET_SIZE];
}

@property (readonly) int *goodCards;


-(void) changeGood:(GoodTypeEnum)good atIndex:(int) index;
-(int) countOfGood:(GoodTypeEnum)good;

@end
