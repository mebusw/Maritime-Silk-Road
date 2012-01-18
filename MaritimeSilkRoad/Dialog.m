//
//  Dialog.m
//  MaritimeSilkRoad
//
//  Created by MagicStudio on 11-11-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Dialog.h"
#import "HelloWorldLayer.h"
#import "rects.h"
#import "states.h"
#import "GameLayer.h"

@implementation Dialog
@synthesize _target, _sel;

-(id) initWithTarget:(id)target sel:(SEL)sel {
    self = [super initWithFile:IMG_DIALOG];
    if (self) {
        _target = target;
        _sel = sel;
        CGSize parentSize = ((CCNode*)target).contentSize;
        self.position = ccp(parentSize.width / 2, parentSize.height / 2);
        ((GameLayer*)_target).isDialoging = YES;
    }
    
    return self;
}

- (void) menuTapped: (CCMenuItem *) menuItem  {
    NSNumber *num = [NSNumber numberWithInt:menuItem.tag];
    ((GameLayer*)_target).isDialoging = NO;
    [_target performSelectorOnMainThread:_sel withObject:num waitUntilDone:NO];
    [self removeFromParentAndCleanup:YES];
}

- (void) animate {
    id fadeIn = [CCFadeIn actionWithDuration:0.1];
	id scale1 = [CCSpawn actions:fadeIn, [CCScaleTo actionWithDuration:0.15 scale:1.3], nil];
	id scale2 = [CCScaleTo actionWithDuration:0.1 scale:0.6];
	id scale3 = [CCScaleTo actionWithDuration:0.05 scale:1.0];
	id pulse = [CCSequence actions:scale1, scale2, scale3, nil];
	[self runAction:pulse];
}

/**
 * the goods dialog looks like:
 ===================
 =   Tea(2)
 =   China(3)
 =   ...
 ===================
 */
+ (Dialog*) dialogWithGoodCounts:(int*)goodCounts target:(id)target selector:(SEL)sel {
   	NSString *goodNames[GOOD_TYPE_COUNT] = {@"China", @"Glaze", @"Ore", @"Perfume", @"Silk", @"Tea"};
	CCMenuItem *items[GOOD_TYPE_COUNT];
	
	Dialog *dialog = [[Dialog alloc] initWithTarget:target sel:sel];
    CGSize size = dialog.contentSize;
    
    CCLabelTTF *title = [CCLabelTTF labelWithString:@"Choose A good from unused tokens" fontName:FONT_NAME fontSize:16];
    title.color = ccRED;
    [dialog addChild:title];
    title.position = ccp(size.width / 2, size.height - 15);

	for (int i = 0; i < GOOD_TYPE_COUNT; i++) {
		NSString *str = [NSString stringWithFormat:@"%@ (%d)", goodNames[i], goodCounts[i]];
		CCLabelTTF *label = [CCLabelTTF labelWithString:str fontName:FONT_NAME fontSize:16];
		CCMenuItemLabel *itm = [CCMenuItemLabel itemWithLabel:label target:dialog selector:@selector(menuTapped:)];
		items[i] = itm;
		itm.tag = i;
		itm.isEnabled = (0 == goodCounts[i]) ? NO : YES;
	}
    
    CCMenu *menu = [CCMenu menuWithItems:items[0], items[1], items[2], items[3], items[4], items[5], nil];
	[menu alignItemsVertically];
	menu.position = ccp(size.width / 2, size.height / 2);

	[dialog addChild:menu z:1];
	
    [dialog animate];
	
	return dialog;
}

/**
 * the action dialog looks like:
 ===================
 =   >ChangeGood   >BuyCards   >Pass   ...
 ===================
 */
+ (Dialog*) dialogWithPhase:(int)phase target:(id)target selector:(SEL)sel {
	NSString *phase1Actions[] = {@"Change Good", @"Buy Specials", @"Pass"};
	NSString *phase2Actions[] = {@"Sell", @"Take Cards"};
	CCMenuItem *items[3];

    Dialog *dialog = [[Dialog alloc] initWithTarget:target sel:sel];
    CCMenu *menu;
    
	switch(phase) {
		case PHASE1:
			for (int i = 0; i < 3; i++) {
				CCLabelTTF *label = [CCLabelTTF labelWithString:phase1Actions[i] fontName:FONT_NAME fontSize:16];
				CCMenuItemLabel *itm = [CCMenuItemLabel itemWithLabel:label target:dialog selector:@selector(menuTapped:)];
				items[i] = itm;
				itm.tag = PHASE1 + i + 1;
			}
			menu = [CCMenu menuWithItems:items[0], items[1], items[2], nil];
			break;
		case PHASE2:
			for (int i = 0; i < 2; i++) {
				CCLabelTTF *label = [CCLabelTTF labelWithString:phase2Actions[i] fontName:FONT_NAME fontSize:16];
				CCMenuItemLabel *itm = [CCMenuItemLabel itemWithLabel:label target:dialog selector:@selector(menuTapped:)];
				items[i] = itm;
				itm.tag = PHASE2 + i + 1;
			}
			menu = [CCMenu menuWithItems:items[0], items[1], nil];
			break;
		default:
			NSAssert(NO, @"Other phase not supported.");
	}
		
	[menu alignItemsVertically];
    CGSize size = dialog.contentSize;
	menu.position = ccp(size.width / 2, size.height / 2);

    [dialog addChild:menu];
	[dialog animate];
    
	return dialog;
}

/**
 * the YesNo dialog looks like:
 ===================
 =   "Are you asleep?"
 =   Yes       No
 =   ...
 ===================
 */
#define TWO_OPTIONS 2
+ (Dialog*) dialogWithNo:(BOOL)hasNo target:(id)target selector:(SEL)sel {
   	NSString *options[] = {@"Yes", @"No"};
	CCMenuItem *items[TWO_OPTIONS];
	Dialog *dialog = [Dialog spriteWithFile:IMG_DIALOG];
    
	for (int i = 0; i < TWO_OPTIONS; i++) {
		NSString *str = [NSString stringWithFormat:@"%@", options[i]];
		CCLabelTTF *label = [CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:16];
		CCMenuItemLabel *itm = [CCMenuItemLabel itemWithLabel:label target:dialog selector:@selector(menuTapped:)];
		items[i] = itm;
		itm.tag = i;
	}
	
	CCMenu *menu = [CCMenu menuWithItems:items[0], items[1], nil];
	[menu alignItemsVertically];
    [dialog addChild:menu];
	[dialog animate];
	return dialog;
}


@end
