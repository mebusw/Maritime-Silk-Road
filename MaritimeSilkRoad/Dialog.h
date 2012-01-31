//
//  Dialog.h
//  MaritimeSilkRoad
//
//  Created by MagicStudio on 11-11-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
@interface Dialog : CCSprite {
    
}
@property (nonatomic, assign) id _target;
@property (nonatomic, assign) SEL _sel;
@property (nonatomic, assign) NSString *title;


+ (Dialog*) dialogWithGoodCounts:(int*)goodCounts target:(id)target selector:(SEL)sel;
+ (Dialog*) dialogWithPhase:(int)phase target:(id)target selector:(SEL)sel;
+ (Dialog*) dialogWithNo:(BOOL)hasNo target:(id)target selector:(SEL)sel;
+ (Dialog*) dialogWithShips:(int*)ships count:(int)count target:(id)target selector:(SEL)sel;
+ (Dialog*) dialogWithSpecials:(int*)specials target:(id)target selector:(SEL)sel;

@end
