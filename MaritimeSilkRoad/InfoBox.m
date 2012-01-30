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
@implementation InfoBox
@synthesize timer;


+(InfoBox*) infoBoxWith {


     
    return nil;
    
}

-(id) initWithMsg:(NSString*) msg {
    self = [super initWithFile:IMG_DIALOG];
    if (self) {
        self.opacity = 100;
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"Action Performed" fontName:FONT_NAME fontSize:16];
        title.color = ccGREEN;
        [self addChild:title];
        CGSize size = self.contentSize;
        title.position = ccp(size.width / 2, size.height - 15);
        [self performSelector:@selector(onTick:) withObject:nil afterDelay:ELASPE_TICK];
    }
    
    return self;
}

- (void)onTick:(id)obj {
    DLog(@"");
    
    [self removeFromParentAndCleanup:YES];
    
}

@end
