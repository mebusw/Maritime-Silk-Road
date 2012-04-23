//
//  PlayerTest.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlayerTest.h"
#import "Player.h"
#import "states.h"

@implementation PlayerTest

Player *player;



- (void)setUp
{
    [super setUp];
    
    player = [[Human alloc] init];
}

- (void)tearDown
{
    [player release];
    
    [super tearDown];
}


- (void)testCardHand {
    STAssertEquals(0, player.cardHand[kGoodOre], nil);
    
    [player addCardToHand:kGoodOre];
    [player addCardToHand:kGoodOre];
    STAssertEquals(2, player.cardHand[kGoodOre], nil);
    
    [player playCardOfType:kGoodOre];
    STAssertEquals(1, player.cardHand[kGoodOre], nil);
}

-(void) testAddSpecial {
    STAssertEquals(0, player.specials[kSpecialTrade], nil);
    [player addSpecial:kSpecialTrade];
    STAssertEquals(1, player.specials[kSpecialTrade], nil);
}

-(void) testLoadGoodToShip {
    STAssertEquals(kGoodNone, player.ships[1], nil);
    [player loadGoodToShip:kGoodSilk atIndex:1];
    STAssertEquals(kGoodSilk, player.ships[1], nil);
    
}

-(void) testCardHandCount {
    [player addCardToHand:kGoodOre];
    [player addCardToHand:kGoodTea];
    STAssertEquals(2, [player cardHandCount], nil);
}

@end
