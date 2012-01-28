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

@implementation InfoBox



+(InfoBox*) infoBoxWith {
    InfoBox *infoBox = [CCSprite spriteWithFile:IMG_DIALOG];

    
    CCLabelTTF *title = [CCLabelTTF labelWithString:@"Action Performed" fontName:FONT_NAME fontSize:16];
    title.color = ccGREEN;
    [infoBox addChild:title];
    CGSize size = infoBox.contentSize;
    title.position = ccp(size.width / 2, size.height - 15);

    return infoBox;
    
}

@end
