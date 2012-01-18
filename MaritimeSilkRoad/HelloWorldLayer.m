//
//  HelloWorldLayer.m
//  MaritimeSilkRoad
//
//  Created by MagicStudio on 11-11-6.
//  Copyright __MyCompanyName__ 2011年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "GameLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Maritime Silk Road" fontName:@"Marker Felt" fontSize:64];

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height - 80 );
		
		// add the label as a child to this Layer
		[self addChild: label];

        [self setupMenus];

        [self scheduleUpdate];
	}
	return self;
}

- (void) setupMenus {
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Start Game" fontName:@"Marker Felt" fontSize:32];
    CCMenuItemLabel *itmStart = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(startTapped:)];
    CCMenu *menu = [CCMenu menuWithItems:itmStart, nil];
    [self addChild:menu];
    
}

- (void) startTapped: (CCMenuItem  *) menuItem {
    DLog(@"");
    UIActionSheet *asPlayerNbr = [[[UIActionSheet alloc] initWithTitle:@"Player Number" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"1", @"2", @"3", @"4", nil] autorelease];
    [asPlayerNbr showInView:[[CCDirector sharedDirector] openGLView]]; 
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    DLog(@"index %d", buttonIndex);
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:0.5f scene:[GameLayer sceneWithPlayerNumber:buttonIndex + 1]]];

}

- (void) update: (ccTime)dt {
    //DLog(@"dt=%f", dt);
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end



