//
//  Pool.h
//  MaritimeSilkRoad
//
//  Created by MagicStudio on 11-11-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "states.h"
#import "cocos2d.h"



@interface Pool : NSObject {
    int goodCards[GOOD_TYPE_COUNT * GOOD_COUNT_PER_TYPE];
    int specialCards[SPECIAL_TYPE_COUNT];
	int token[GOOD_TYPE_COUNT];
}

@property (readonly) int *goodCards;
@property (readonly) int *specialCards;
@property (readonly) int *token;
@property (readonly) int remainingCards;

- (GoodTypeEnum) fetchAGood;
- (bool) fetchASpecial: (SpecialTypeEnum) type;
- (bool) fetchAToken: (GoodTypeEnum) type;





@end
