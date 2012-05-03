//
//  InfoBox.m
//  MaritimeSilkRoad
//
//  Created by mebusw on 12-1-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InfoBox.h"
#import "rects.h"
#import "states.h"

#define ELASPE_TICK 1.5
#define TAG_TITLE   100

@implementation InfoBox

NSTimer *t;

+(InfoBox*) infoBoxWithMsg:(NSString*)msg above:(CCNode*)parent {
    InfoBox *ib = [[[InfoBox alloc] initWithFile:IMG_DIALOG] autorelease];
    
    
    CCLabelTTF *title = [CCLabelTTF labelWithString:msg fontName:FONT_NAME fontSize:16];
    title.color = ccGREEN;
    [ib addChild:title z:0 tag:TAG_TITLE];

    ib.opacity = 150;
    
    CGSize size = ib.contentSize;
    title.position = ccp(size.width / 2, size.height - 15);
    
    [parent addChild:ib z:1000];

    CGSize parentSize = parent.contentSize;
    ib.position = ccp(parentSize.width / 2, parentSize.height / 2 + 50);
    ib.visible = YES;
	
    
    //TODO
    //timer should be handle by state handler, not a view itself
    
    t = [[NSTimer scheduledTimerWithTimeInterval:ELASPE_TICK target:self selector:@selector(onHide:) userInfo:nil repeats:NO] retain];

    return ib;

}

- (void)onHide:(NSTimer*)theTimer {
    self.visible = NO;
    [self removeFromParentAndCleanup:YES];
    //DLog(@"is valid=%d", [t isValid]);
    
}


@end
