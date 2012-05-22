#define GOOD_TYPE_COUNT 6
#define GOOD_COUNT_PER_TYPE 11
#define SPECIAL_TYPE_COUNT 4
#define SHIP_COUNT 14
#define OTHER_SPECIAL_COUNT 2
#define MARKET_SIZE 6
#define TOKEN_PER_TYPE 5
#define MAX_PLAYER 4
#define PHASE1 	10
#define PHASE2 	20

#define FONT_NAME		    @"Marker Felt"
#define IMG_DIALOG          @"dialog.png"
#define IMG_CARDBACK        @"cardback-small.png"
#define IMG_MARKET          @"market-placeholder.png"
#define IMG_SP_SHIP         @"special-ship-small.jpg"
#define IMG_SP_WORKER       @"special-worker-small.jpg"
#define IMG_SP_CONCESSION   @"special-concession-small.jpg"
#define IMG_SP_TRADE        @"special-trade-small.jpg"

#define IMG_TOKEN_CHINA     @"token-china.png"
#define IMG_TOKEN_GLAZE     @"token-glaze.png"
#define IMG_TOKEN_ORE       @"token-ore.png"
#define IMG_TOKEN_PERFUME   @"token-perfume.png"
#define IMG_TOKEN_SILK      @"token-silk.png"
#define IMG_TOKEN_TEA       @"token-tea.png"

#define IMG_GOOD_CHINA      @"good-china-small.jpg"
#define IMG_GOOD_GLAZE      @"good-glaze-small.jpg"
#define IMG_GOOD_ORE        @"good-ore-small.jpg"
#define IMG_GOOD_PERFUME    @"good-perfume-small.jpg"
#define IMG_GOOD_SILK       @"good-silk-small.jpg"
#define IMG_GOOD_TEA        @"good-tea-small.jpg"


typedef enum {
	kActionChangeGood = 11,
	kActionBuySpecials = 12,
	kActionPass = 13,
	kActionPlayCard = 21,
	kActionGetCard = 22,
} ActionEnum;

typedef enum {
	kWaitForStart = 1,
	kPreparing,
	kLoadGoods,
	kPhase1,
	kPhase2,
	kGameOver,
	kP11ChangeGood = 11,
	kP12BuySpecial,
    kP13Pass,
	kP21PlayCard = 21,
	kP22GetCard,
} 	GameStateEnum;

typedef enum {
    kGoodNone = -1,
	kGoodChina = 0,
	kGoodGlaze,
	kGoodOre,
	kGoodPerfume,
	kGoodSilk,
	kGoodTea,
} 	GoodTypeEnum;

typedef enum {
    kSpecialNone = -1,
	kSpecialShip = 0,
	kSpecialTrade,
    kSpecialConcession,
    kSpecialWorker,
} 	SpecialTypeEnum;

typedef enum {
    kDlgGoodType,
	kDlgUserAbility,
	kDlgSpecialType,
	kDlgCardHandIndex,
	kDlgCardMarketIndex,
    kDlgChooseActionForPhase1,
    kDlgChooseActionForPhase2,
} 	DialogEnum;
