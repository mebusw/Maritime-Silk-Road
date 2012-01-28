//
//  GameLayer.m
//  MaritimeSilkRoad
//
//  Created by MagicStudio on 11-11-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "HelloWorldLayer.h"
#import "Dialog.h"
#import "ShipsPanel.h"
#import "HandMarketPanel.h"

@implementation GameLayer

@synthesize isDialoging;
@synthesize playerNbr;
@synthesize gameState;
@synthesize activePlayerIndex;
@synthesize activePlayer;
@synthesize startPlayerIndex;
@synthesize pool;
@synthesize players;
#define Z_MOST_FRONT    1000
#define Z_MOST_BACK     -1000
#define Z_BOARD         2
#define DIALOG_GOODS   	100
#define DIALOG_ACTIONS 	101
#define DIALOG_YESNO		102

- (int*) market {
    return market;
}

+ (CCScene *) sceneWithPlayerNumber: (NSUInteger) _playerNbr {
    
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'lShipsPanelayer' is an autorelease object.
	GameLayer *layer = [[[GameLayer alloc] initWithPlayerNumber:_playerNbr] autorelease];
	
	// add layer as a child to scene
	[scene addChild:layer];

	// return the scene
	return scene;
}


- (id) initWithPlayerNumber: (NSUInteger) _playerNbr {	
    if (self = [super init]) {
		DLog(@"player nbr=%d", _playerNbr);
		gameState = kWaitForStart;
		playerNbr = _playerNbr;
		startPlayerIndex = (int) (CCRANDOM_0_1() * playerNbr);
		
        CGSize size = [[CCDirector sharedDirector] winSize];
        DLog(@"screen w=%f, h=%f, factor%f", size.width, size.height, CC_CONTENT_SCALE_FACTOR());
        
        CCSprite *background = [CCSprite spriteWithFile:@"bg.png"];
        background.position = ccp( size.width /2 , size.height /2 );
        [self addChild:background z:Z_MOST_BACK];
        
		gameState = kPreparing;

		[self scheduleUpdate];
                
    }
    return self;
    
}

- (void) setupMenus {
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF *labelPause = [CCLabelTTF labelWithString:@"||" fontName:FONT_NAME fontSize:32];
    CCMenuItemLabel *itmPause = [CCMenuItemLabel itemWithLabel:labelPause target:self selector:@selector(pauseTapped:)];
    itmPause.position = ccp(size.width / 2 - 32, size.height / 2 - 32);
    CCMenu *menu = [CCMenu menuWithItems:itmPause, nil];
    menu.position = ccp(size.width / 2, size.height / 2);
    [self addChild:menu z:Z_MOST_FRONT tag:1]; 
    
    for (int i = 0; i < players.count; i++) {
        Player *p = [players objectAtIndex:i];
        labelPlayers[i] = [CCLabelTTF labelWithString:p.name fontName:FONT_NAME fontSize:16];
        labelPlayers[i].position = ccp(40, 260 - i * 30);
        [self addChild:labelPlayers[i] z:Z_BOARD tag:(10 + i)];
    }


                             
    for (int i = 0; i < GOOD_TYPE_COUNT; i++) {
        labelTokens[i] = [CCLabelTTF labelWithString:STR(@"=%d", pool.token[i]) fontName:FONT_NAME fontSize:16];
        labelTokens[i].position = ccp(440, 145 - i * 20);
        [self addChild:labelTokens[i] z:Z_BOARD tag:(20 + i)];
    }
    
    
    labelSpecials = [CCLabelTTF labelWithString:STR(@"w%d c%d t%d s%d", pool.specialCards[kSpecialWorker], pool.specialCards[kSpecialConcession], pool.specialCards[kSpecialTrade], pool.specialCards[kSpecialShip]) fontName:FONT_NAME fontSize:16];
    labelSpecials.position = ccp(400, 220);
    [self addChild:labelSpecials z:Z_BOARD];

    labelDeck = [CCLabelTTF labelWithString:STR(@"Deck %d", pool.remainingCards) fontName:FONT_NAME fontSize:16];
    labelDeck.position = ccp(400, 240);
    [self addChild:labelDeck z:Z_BOARD];  
    
    labelYourCoin = [CCLabelTTF labelWithString:STR(@"Coin %d", human.coin) fontName:FONT_NAME fontSize:16];
    labelYourCoin.position = ccp(30, 50);
    [self addChild:labelYourCoin z:Z_BOARD];
    
    labelYourSpecials = [CCLabelTTF labelWithString:STR(@"w%d c%d t%d", human.specials[kSpecialWorker], human.specials[kSpecialConcession], human.specials[kSpecialTrade]) fontName:FONT_NAME fontSize:16];
    labelYourSpecials.position = ccp(30, 70);
    [self addChild:labelYourSpecials z:Z_BOARD];
    
        
    shipsPanel.position = ccp(size.width / 2, size.height / 2);
    [self addChild:shipsPanel z:Z_BOARD + 1];
    
    handMarketPanel.position = ccp(size.width / 2, size.height / 2);
    [self addChild:handMarketPanel z:Z_BOARD];

}

- (void) update: (ccTime)dt {
    //DLog(@"pos %f %f", itm.position.x, itm.position.y);
    //DLog(@"gameState=%d", gameState);

	if (NO == isDialoging) {
        handMarketPanel.isTouchEnabled = YES;
        shipsPanel.isTouchEnabled = YES;

		switch(gameState) {
            case kWaitForStart:
                break;
            case kPreparing:
                [self prepareGame]; 
                break;
            case kLoadGoods:
                [self loadGoods]; 
                break;
            case kPhase1:
                [self phase1]; 
                break;
            case kP11ChangeGood:
                [self p11ChangeGood]; 
                break;
            case kP12BuySpecial:
                break;
            case kPhase2:
                [self phase2]; 
                break;
            case kP21PlayCard:
                break;
            case kP22GetCard:
                break;
            case kGameOver:
                break;
        }
	
        //update players' labels
        for (int i = 0; i < players.count; i++) {
            Player *p = [players objectAtIndex:i];

            NSMutableString *str = [NSMutableString stringWithFormat:@"%@ %d=", p.name, [p cardHandCount]];
            for (int j = 0; j < p.specials[kSpecialShip]; j++) {	
                [str appendFormat:@"%d ", p.ships[j]];
            }
            [labelPlayers[i] setString:str]; 
        }
        //update lables of tokens in pool
        for (int i = 0; i < GOOD_TYPE_COUNT; i++) {
            [labelTokens[i] setString:[NSString stringWithFormat:@"%d", pool.token[i]]];
        }
        
        Human *user = [players objectAtIndex:0];
        [labelYourCoin setString:STR(@"Coin %d", user.coin)];
        [labelYourSpecials setString:STR(@"w%d c%d t%d", user.specials[kSpecialWorker], user.specials[kSpecialConcession], user.specials[kSpecialTrade])];
        [shipsPanel refresh];
        [handMarketPanel refresh];
    }
    else {
        handMarketPanel.isTouchEnabled = NO;
        shipsPanel.isTouchEnabled = NO;
    }
}

/**
 * switch to next player, both activePlayerIndex and activePlayer are changed.
 */
- (void) nextPlayer {
    activePlayerIndex = (activePlayerIndex + 1)  % playerNbr;
    activePlayer = [players objectAtIndex:activePlayerIndex];
}

- (void) dealloc {
    [players release];
    [pool release];
	[super dealloc];
}


#pragma mark - state handlers
- (void) prepareGame {	
	// shuffle decks
	pool = [[Pool alloc] init];

    NSString *names[MAX_PLAYER] = {@"You", @"Alice", @"Bob", @"Carl"};

	// create Human player
    DLog(@"");
	players = [[NSMutableArray alloc] initWithCapacity:playerNbr];
	human = [[Human alloc] initWithDelegate:self];
    human.name = names[0];
	[players addObject:human];
	
	// create AI players
	for (int i = 1; i < playerNbr; i++) {
		NPC *npc = [[NPC alloc] initWithDelegate:self];
        npc.name = names[i];
		[players addObject:npc];
	}
	
	// distribute 3 good cards and 2 ships to every player
	for (Player *player in players) {
		for (int i = 0; i < 3; i++) {
			GoodTypeEnum good = [pool fetchAGood];
			//DLog(@"player %@ got good card %d", player, good);
			[player addCardToHand:good];
		}
		for (int i = 0; i < 2; i++) {
            [pool fetchASpecial:kSpecialShip];
			[player addSpecial:kSpecialShip];			
		}
	}
	
    
    shipsPanel = [[[ShipsPanel alloc] initWithHuman:human] autorelease];
    handMarketPanel = [[[HandMarketPanel alloc] initWithHuman:human market:market] autorelease];
    
	// distribute 6 good cards to market
	for (int i = 0; i < MARKET_SIZE; i++) {
		GoodTypeEnum good = [pool fetchAGood];
		DLog(@"market got good card %d",  good);
        [handMarketPanel setMarketAtIndex:i good:good];
	}

	activePlayerIndex = startPlayerIndex;
    activePlayer = [players objectAtIndex:activePlayerIndex];
	_loadGoodsTurns = 2 * playerNbr; // two round of loading goods

    [self setupMenus];
    
	gameState = kLoadGoods;
}

- (void) loadGoods {
	if (_loadGoodsTurns > 0) {
        [activePlayer chooseAGoodTypeFromPool:pool];

	} else {
        _phaseTurns = playerNbr;
		gameState = kPhase1;
	}
}

- (void) phase1 {
	DLog(@"tun=%d %@", _phaseTurns, activePlayer);
    if (_phaseTurns > 0) {
        [activePlayer chooseActionForPhase1];
    } else {
        _phaseTurns = playerNbr;
        gameState = kPhase2;
    }
    
    
}

- (void) p11ChangeGood {
	DLog(@"turn=%d %@", _phaseTurns, activePlayer);
    //TODO isDialoging
    [activePlayer chooseAShipForAction11];
}

- (void) phase2 {
    
}

#pragma mark - dialog touch events
- (void) pauseTapped: (CCMenuItem  *) menuItem {
    DLog(@"%@", menuItem);
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:0.5f scene:[HelloWorldLayer scene]]];
}


- (void) didChooseAGoodType: (NSNumber *)num {
    GoodTypeEnum goodType = [num intValue];
    DLog(@"goodType=%d gameState=%d", goodType, gameState);

    switch (gameState) {
        case kLoadGoods:
            [pool fetchAToken: goodType];
            [activePlayer loadGoodToShip:goodType atIndex:((_loadGoodsTurns - 1) / playerNbr)];	
            [self nextPlayer];
            _loadGoodsTurns--; 
        
            break;
        case kP11ChangeGood: 
            [pool fetchAToken: goodType];
            GoodTypeEnum goodOnChosenShip = activePlayer.ships[_chosenShip];
            activePlayer.ships[_chosenShip] = goodType;
            [pool putAToken:goodOnChosenShip];
            
            [self nextPlayer];
            _phaseTurns--;
            gameState = kPhase1;
            break;
        default:
            DLog(@"state %d can't be handled by this func", gameState);
            break;
    }

}

- (void) didChooseActionForPhase1: (NSNumber *)num {
    ActionEnum action = [num intValue];
    DLog(@"action %d", action);
    switch (action) {
        case kActionChangeGood:
            //
            gameState = kP11ChangeGood;

            break;
        case kActionBuySpecials:
            break;
        case kActionPass:
        default:
            break;
    }

}


- (void) didChooseYesNo: (NSNumber *)num  {
    BOOL isYes = [num intValue];
	DLog(@"isYes %d", isYes);
}

-(void) didChooseAShip: (NSNumber*) num {
    int ship = [num intValue];
	DLog(@"ship %d", ship);    
    _chosenShip = ship;
    [activePlayer chooseAGoodTypeFromPool:pool];
}

@end
