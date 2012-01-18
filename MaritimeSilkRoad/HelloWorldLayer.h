//
//  HelloWorldLayer.h
//  MaritimeSilkRoad
//
//  Created by MagicStudio on 11-11-6.
//  Copyright __MyCompanyName__ 2011年. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer  : CCLayer  <UIActionSheetDelegate>
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
- (void) setupMenus;

@end
