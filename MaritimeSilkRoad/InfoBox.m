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

CCNode* _parent;

+(InfoBox*) infoBox:(NSString*) msg {
    InfoBox *ib = [[InfoBox alloc] initWithFile:IMG_DIALOG];
    ib.opacity = 150;
    
    
    CCLabelTTF *title = [CCLabelTTF labelWithString:msg fontName:FONT_NAME fontSize:16];
    title.color = ccGREEN;
    [ib addChild:title z:0 tag:TAG_TITLE];

    
    CGSize size = ib.contentSize;
    title.position = ccp(size.width / 2, size.height - 15);
    
    ib.visible = NO;
    return ib;

}



-(void) show:(CCNode*)parent {
    _parent = parent;
    [_parent addChild:self z:1000];
    CGSize size = _parent.contentSize;
    self.position = ccp(size.width / 2, size.height / 2 + 50);
    
    self.visible = YES;
	
	[t release];
    t = [[NSTimer scheduledTimerWithTimeInterval:ELASPE_TICK target:self selector:@selector(onHide:) userInfo:nil repeats:NO] retain];
    
}


- (void)onHide:(NSTimer*)theTimer {
    self.visible = NO;
    [self removeFromParentAndCleanup:YES];
    _parent = nil;
    //DLog(@"is valid=%d", [t isValid]);
    
}


@end
