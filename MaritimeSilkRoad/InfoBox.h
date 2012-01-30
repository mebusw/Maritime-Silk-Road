//
//  InfoBox.h
//  MaritimeSilkRoad
//
//  Created by mebusw on 12-1-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface InfoBox : CCSprite {
    
}

@property (nonatomic, retain) CCTimer *timer;

+(InfoBox*) infoBoxWithMsg:(NSString*)msg;
-(id) initWithMsg:(NSString*) msg;
- (void)onTick:(id)obj;
@end
