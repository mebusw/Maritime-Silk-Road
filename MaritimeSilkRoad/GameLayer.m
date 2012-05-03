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
#import "InfoBox.h"
#import "Preparing.h"
#import "StateStack.h"

@implementation GameLayer

@synthesize isDialoging;
@synthesize gameState;
@synthesize stateStack;

#define Z_MOST_FRONT    1000
#define Z_MOST_BACK     -1000
#define Z_BOARD         2
#define DIALOG_GOODS   	100
#define DIALOG_ACTIONS 	101
#define DIALOG_YESNO		102

int _loadGoodsTurns;
int _phaseTurns;
int _chosenShip;

CCLabelTTF *labelDeck;
CCLabelTTF *labelSpecials;
CCLabelTTF *labelYourCoin;
CCLabelTTF *labelYourSpecials;
CCLabelTTF *lableYourShips[SHIP_COUNT];
CCLabelTTF *labelTokens[GOOD_TYPE_COUNT];
CCLabelTTF *labelPlayers[MAX_PLAYER];
ShipsPanel *shipsPanel;
HandMarketPanel *handMarketPanel;


GameBoard *_gameBoard;

int _playerCount;
Player *_activePlayer;

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



- (id) initWithPlayerNumber: (NSUInteger) playerNbr {	
    if (self = [super init]) {
		DLog(@"player nbr=%d", playerNbr);
        
        _gameBoard = [[GameBoard alloc] init];
        [_gameBoard buildGameBoardWithPlayerNumber:playerNbr];
        
		_playerCount = playerNbr;        
        
        stateStack = [[StateStack alloc] init];
        [stateStack push:[[Preparing alloc] initWithObserver:self gameBoard:_gameBoard]];
        //TODO should move Preparing to a builder of GameBoard
        
        [self handleRequest];
		

        [self createViews];
        
        //start game logic
		[self scheduleUpdate];
        [self handleRequest];        
                
    }
    return self;
    
}

- (void) createViews {
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    DLog(@"screen w=%f, h=%f, factor%f", size.width, size.height, CC_CONTENT_SCALE_FACTOR());
    CCSprite *background = [CCSprite spriteWithFile:@"bg.png"];
    background.position = ccp( size.width /2 , size.height /2 );
    [self addChild:background z:Z_MOST_BACK];
    
    CCLabelTTF *labelPause = [CCLabelTTF labelWithString:@"||" fontName:FONT_NAME fontSize:32];
    CCMenuItemLabel *itmPause = [CCMenuItemLabel itemWithLabel:labelPause target:self selector:@selector(pauseTapped:)];
    itmPause.position = ccp(size.width / 2 - 32, size.height / 2 - 32);
    CCMenu *menu = [CCMenu menuWithItems:itmPause, nil];
    menu.position = ccp(size.width / 2, size.height / 2);
    [self addChild:menu z:Z_MOST_FRONT tag:1]; 
    
    NSString *names[MAX_PLAYER] = {@"You", @"Alice", @"Bob", @"Carl"};
    for (int i = 0; i < _gameBoard.playerCount; i++) {
        labelPlayers[i] = [CCLabelTTF labelWithString:names[i] fontName:FONT_NAME fontSize:16];
        labelPlayers[i].position = ccp(40, 260 - i * 30);
        [self addChild:labelPlayers[i] z:Z_BOARD tag:(10 + i)];
    }

                             
    for (int i = 0; i < GOOD_TYPE_COUNT; i++) {
        labelTokens[i] = [CCLabelTTF labelWithString:STR(@"=%d", _gameBoard.pool.token[i]) fontName:FONT_NAME fontSize:16];
        labelTokens[i].position = ccp(440, 145 - i * 20);
        [self addChild:labelTokens[i] z:Z_BOARD tag:(20 + i)];
    }
    
    
    labelSpecials = [CCLabelTTF labelWithString:STR(@"w%d c%d t%d s%d", _gameBoard.pool.specialCards[kSpecialWorker], _gameBoard.pool.specialCards[kSpecialConcession], _gameBoard.pool.specialCards[kSpecialTrade], _gameBoard.pool.specialCards[kSpecialShip]) fontName:FONT_NAME fontSize:16];
    labelSpecials.position = ccp(400, 220);
    [self addChild:labelSpecials z:Z_BOARD];

    labelDeck = [CCLabelTTF labelWithString:STR(@"Deck %d", _gameBoard.pool.remainingCards) fontName:FONT_NAME fontSize:16];
    labelDeck.position = ccp(400, 240);
    [self addChild:labelDeck z:Z_BOARD];  
    

    labelYourCoin = [CCLabelTTF labelWithString:@"Coin 000" fontName:FONT_NAME fontSize:16];
    labelYourCoin.position = ccp(30, 50);
    [self addChild:labelYourCoin z:Z_BOARD];
    
    labelYourSpecials = [CCLabelTTF labelWithString:@"w0 c0 t0" fontName:FONT_NAME fontSize:16];
    labelYourSpecials.position = ccp(30, 70);
    [self addChild:labelYourSpecials z:Z_BOARD];
    
        
    handMarketPanel = [[[HandMarketPanel alloc] initWithHuman:[_gameBoard.players objectAtIndex:0] market:_gameBoard.market] autorelease];
    handMarketPanel.position = ccp(size.width / 2, size.height / 2);
    [self addChild:handMarketPanel z:Z_BOARD];

    shipsPanel = [[[ShipsPanel alloc] initWithHuman:[_gameBoard.players objectAtIndex:0]] autorelease];
    shipsPanel.position = ccp(size.width / 2, size.height / 2);
    [self addChild:shipsPanel z:Z_BOARD + 1];

    
}

- (void) update: (ccTime)dt {

	if (NO == isDialoging) {
        handMarketPanel.isTouchEnabled = YES;
        shipsPanel.isTouchEnabled = YES;
        
        [self updateViews];
    }
    else {
        handMarketPanel.isTouchEnabled = NO;
        shipsPanel.isTouchEnabled = NO;
    }
}

- (void) updateViews {
    Human *human = [_gameBoard.players objectAtIndex:0];
    
    //update players' labels
    NSString *names[MAX_PLAYER] = {@"You", @"Alice", @"Bob", @"Carl"};
    for (int i = 0; i < _gameBoard.playerCount; i++) {
        Player *p = [_gameBoard.players objectAtIndex:i];
        
        NSMutableString *str = [NSMutableString stringWithFormat:@"%@ %d=", names[i], [p cardHandCount]];
        for (int j = 0; j < p.specials[kSpecialShip]; j++) {	
            [str appendFormat:@"%d ", p.ships[j]];
        }
        [labelPlayers[i] setString:str]; 
    }
    //update lables of tokens in pool
    for (int i = 0; i < GOOD_TYPE_COUNT; i++) {
        [labelTokens[i] setString:[NSString stringWithFormat:@"%d", _gameBoard.pool.token[i]]];
    }
    

    [labelYourCoin setString:STR(@"Coin %d", human.coin)];
    [labelYourSpecials setString:STR(@"w%d c%d t%d", human.specials[kSpecialWorker], human.specials[kSpecialConcession], human.specials[kSpecialTrade])];
    [labelYourCoin setString:STR(@"Coin %d", human.coin)];
    [labelSpecials setString:STR(@"w%d c%d t%d s%d", _gameBoard.pool.specialCards[kSpecialWorker], _gameBoard.pool.specialCards[kSpecialConcession], _gameBoard.pool.specialCards[kSpecialTrade], _gameBoard.pool.specialCards[kSpecialShip])];
    [labelDeck setString:STR(@"Deck %d", _gameBoard.pool.remainingCards)];  
    
    [shipsPanel refresh];
    [handMarketPanel refresh];
}


- (void) dealloc {
    [stateStack release];
    [_gameBoard release];
	[super dealloc];
}


#pragma mark - state handlers

-(void) handleRequest {
    [[stateStack top] handle:self gameBoard:_gameBoard];
}


#pragma mark - dialog and input

- (void) chooseAGoodType {
    Dialog *dialog = [Dialog dialogWithGoodCounts:_gameBoard.pool.token target:self selector:@selector(didChooseFromDialog:)];
    [self addChild:dialog z:Z_MOST_FRONT tag:DIALOG_GOODS];
}

-(void) didChooseFromDialog:(NSNumber*)number {
    DLog(@"%@", number);
    _gameBoard.chosenGoodType = [number intValue];
    [self removeChildByTag:DIALOG_GOODS cleanup:YES];
    [self handleRequest];
}

#pragma mark -

- (void) loadGoods {
	if (_loadGoodsTurns > 0) {
        [_activePlayer chooseAGoodTypeFromPool:_gameBoard.pool];

	} else {
        _phaseTurns = _playerCount;
		gameState = kPhase1;
	}
}

- (void) phase1 {
	DLog(@"tun=%d %@", _phaseTurns, _activePlayer);
    if (_phaseTurns > 0) {
        [_activePlayer chooseActionForPhase1];
    } else {
        _phaseTurns = _playerCount;
        gameState = kPhase2;
    }
    
    
}

- (void) p11ChangeGood {
	DLog(@"turn=%d %@", _phaseTurns, _activePlayer);
    //TODO isDialoging
    [_activePlayer chooseAShipForAction11];
}

- (void) p12BuySpecial {
    [_activePlayer chooseASpecialForAction12FromPool:_gameBoard.pool];
}


-(void) displayFinalScore {
    //when game over
    
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
        case kLoadGoods: {
            [_gameBoard.pool fetchAToken: goodType];
            [_activePlayer loadGoodToShip:goodType atIndex:((_loadGoodsTurns - 1) / _playerCount)];

            [InfoBox infoBoxWithMsg:STR(@"%@ chooses good type %d", _activePlayer.name, goodType) above:self];
            
            [_gameBoard nextPlayer];
            _loadGoodsTurns--; 
        
            break;
        }
        case kP11ChangeGood: {
            [_gameBoard.pool fetchAToken: goodType];
            GoodTypeEnum goodOnChosenShip = _activePlayer.ships[_chosenShip];
            _activePlayer.ships[_chosenShip] = goodType;
            [_gameBoard.pool putAToken:goodOnChosenShip];
            
            [InfoBox infoBoxWithMsg:STR(@"%@ chooses good type %d", _activePlayer.name, goodType) above:self];

            
            [_gameBoard nextPlayer];
            _phaseTurns--;
            gameState = kPhase1;
            break;
        }
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
            
            gameState = kP11ChangeGood;

            break;
        case kActionBuySpecials:
            gameState = kP12BuySpecial;
            
            break;
        case kActionPass:
            gameState = kP13Pass;
            break;
        default:
            break;
    }


    [InfoBox infoBoxWithMsg:STR(@"%@ chooses action for phase1 %d", _activePlayer.name, action) above:self];
 
}

-(void) didChooseASpecial: (NSNumber *)num {
    SpecialTypeEnum special = [num intValue];
    DLog(@"special %d", special);
    
    [_gameBoard.pool fetchASpecial:special];
    [_activePlayer addSpecial:special];
    int pricesOfSpecials[] = {10, 8, 11, 12};
    _activePlayer.coin -= pricesOfSpecials[special];
    

    [InfoBox infoBoxWithMsg:STR(@"%@ chooses special %d", _activePlayer.name, special) above:self];
    
    [_gameBoard nextPlayer];
    _phaseTurns--;
    gameState = kPhase1;
}

- (void) didChooseYesNo: (NSNumber *)num  {
    BOOL isYes = [num intValue];
	DLog(@"isYes %d", isYes);
}

-(void) didChooseAShip: (int)shipIndex {
	DLog(@"ship %d", shipIndex);    
    _chosenShip = shipIndex;
    [_activePlayer chooseAGoodTypeFromPool:_gameBoard.pool];
}

@end
