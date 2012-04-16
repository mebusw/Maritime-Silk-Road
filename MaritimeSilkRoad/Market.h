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
    NSMutableArray *_array;
}

-(GoodTypeEnum) goodAtIndex:(int) index;
-(void) changeGood:(GoodTypeEnum)good atIndex:(int) index;

@end
