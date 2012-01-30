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


static InfoBox* instance;

+(InfoBox*) sharedInfoBox {
    //return [[[InfoBox alloc] initWithMsg:msg] autorelease];
    if (!instance) {
        instance = [[InfoBox alloc] initWithFile:IMG_DIALOG];
        instance.opacity = 100;
        

        CCLabelTTF *title = [CCLabelTTF labelWithString:@"(Info)" fontName:FONT_NAME fontSize:16];
        title.color = ccGREEN;
        [instance addChild:title z:0 tag:TAG_TITLE];
        
        [instance setNewMsg:@"Action Performed"];
        CGSize size = instance.contentSize;
        title.position = ccp(size.width / 2, size.height - 15);
        
        instance.visible = NO;
    }
    return instance;
}



+(id)alloc
{
	NSAssert(instance == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}

+(void)purgeSharedInfoBox
{
	[instance release];
    instance = nil;
}


-(void) show {
    self.visible = YES;
//    if (t && [t isValid]) {
//        [t invalidate];
//    }
    t = [NSTimer scheduledTimerWithTimeInterval:ELASPE_TICK target:self selector:@selector(onHide:) userInfo:nil repeats:NO];
}

/**
 *  @override
 */
-(void)setNewMsg:(NSString *)msg {
    DLog(@"%@", msg);
    CCLabelTTF *title = (CCLabelTTF*)[self getChildByTag:TAG_TITLE];
    title.string = msg;
    [self show];

}
- (void)onHide:(NSTimer*)theTimer {
    self.visible = NO;
    //[self removeFromParentAndCleanup:YES];
    DLog(@"is valid=%d", [t isValid]);
    
}


@end
