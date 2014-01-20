//
//  ForFunViewController.m
//  ForFunGame
//
//  Created by MoAir on 1/19/2014.
//  Copyright (c) 2014 MoAir. All rights reserved.
//

#import "ForFunViewController.h"
#import "boxView.h"
#import "CircleView.h"
#define RIGHT 0
#define LEFT 1
//#define HIT_FROM_RIGHT_ANGLE 1 // PLUSE
//#define HIT_FROM_LEFT_ANGLE

@interface ForFunViewController ()

@property (strong, nonatomic) IBOutlet boxView *boxView;
@property (strong, nonatomic) IBOutlet CircleView *circleView;

//@property  CircleView* circleView;

@property NSTimer* gamePlayingTimer;
@property BOOL BoxViewHasBeenTouch;// in order to make the move of BoxView smooth
@property NSTimeInterval time;
@property  NSDate* dateNow;
@end

@implementation ForFunViewController

@synthesize startGameMode = _startGameMode;

// some varaible that is used only in this class
CGPoint  boxViewTouchPostion;
CGFloat boxViewWidth;
CGFloat boxViewFramPositionX;
CGFloat circleViewWidth;
CGFloat circleViewHeight;
CGFloat circleViewPositionX;
CGFloat circleViewPositionY;
CGFloat boxViewSpeed;
CGPoint  orginalX_Y = {0,0} ; // always zero in this program
// this struct use to hold information about from which positioin the circle is hiting
struct CircleInfo{
    bool isHit;
    float positionHit;
} circleHoldInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    //    UITouch *myTouch = [[touches allObjects] objectAtIndex: 0];
    //
    //    CGPoint currentPos = [myTouch locationInView:self.boxView];
    //    NSLog(@"Point in myView: (%f,%f)", currentPos.x, currentPos.y);
    //
    //    if (currentPos.x > 0 && currentPos.y > 0) {
    //        CGPoint currentPos2 = [myTouch locationInView:self.view];
    //        NSLog(@"Point in View: (%f,%f)", currentPos2.x, currentPos2.y);
    //        CGFloat a =  currentPos2.x ;
    //        [self.boxView setFrame:CGRectMake(a-currentPos.x,970,273,34)];
    //
    //
    //    }
    //
    //
    //
}

-(void)viewDidLayoutSubviews{
    NSLog(@"layout subvviws ");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.startGameMode = RUN_APP_MODE;
	// Do any additional setup after loading the view.
    //  [self.view setBackgroundColor:[UIColor colorWithRed:1.0 green:1.4 blue:1.4 alpha:1.0]];
    // self.boxView = [[self.view subviews]objectAtIndex:0];
    //   self.circleView = [[self.view subviews]objectAtIndex:1];
    boxViewWidth = self.boxView.bounds.size.width;
    circleViewWidth = self.circleView.bounds.size.width;
    circleViewHeight = self.circleView.bounds.size.height;
    [self.circleView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.0]];
    circleViewPositionY = self.circleView.positionY;
    self.BoxViewHasBeenTouch = NO;
    boxViewFramPositionX = 300; // it used to setFrame boxView
    boxViewSpeed = 0;
}


#pragma boxView
/*
 Move the boxView only
 */
float  orginalPositionX = 300;
BOOL startMoveRight = NO,startMoveLeft = NO;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    
    if (self.startGameMode == PLAY_MODE ) {
        
        UITouch *myTouch = [[touches allObjects] objectAtIndex: 0];
        //In order to move we need to calculate  where the frame of boxView should be draw
        if (!self.BoxViewHasBeenTouch) {
            boxViewTouchPostion =[myTouch locationInView:self.boxView];
            boxViewSpeed = 0;
            
            self.BoxViewHasBeenTouch = YES;
            //  NSLog(@" time: %f",self.time);
            
        }
        if ( [self touchBoxViewwithinAcceptedRange:boxViewTouchPostion] ) {
            
            
            ++boxViewSpeed;
            // get the position of main view or super view of boxView
            CGPoint boxViewNewPostion = [myTouch locationInView:self.view];
            /* here we are converting the orginal of boxView to mian view.
             boxViewTouchPostion.x will not change when the boxView start move, its value will change when the touch end. we are using self.BoxViewHasBeenTouch.
             an example:
             boxViewTouchPostion.x = 10; // point away from the boxView orginal
             boxViewNewPostion.x = 200 // point away from the mian view orginal
             boxViewFramPositionX = 200 -10 = 190;
             while the boxView move boxViewNewPostion.x
             example when boxViewNewPostion.x change only
             boxViewNewPostion.x = 250 => boxViewFramPositionX = 240
             then the boxView move to the point 240 of its superView
             */
            boxViewFramPositionX = boxViewNewPostion.x - boxViewTouchPostion.x;
            
            NSLog(@"%f",boxViewFramPositionX);
            if ([self boxViewMovePosition:boxViewFramPositionX] == RIGHT) {
                
                if (!startMoveRight) {
                    NSLog(@"RIGHT");
                    startMoveRight = YES;
                    startMoveLeft = NO;
                    
                    self.dateNow = [NSDate date];
                    orginalPositionX = boxViewFramPositionX;
                }
                
                self.time = -1 * ([self.dateNow timeIntervalSinceNow]);
                
            }else if ([self boxViewMovePosition:boxViewFramPositionX] == LEFT){
                
                if (!startMoveLeft) {
                    NSLog(@"LEFT");
                    startMoveRight = NO;
                    startMoveLeft = YES;
                    self.dateNow = [NSDate date];
                    orginalPositionX = boxViewFramPositionX;
                }
                self.time = -1 * ([self.dateNow timeIntervalSinceNow]);
            }
            
            else{
                orginalPositionX = 0;
                
            }
            
            if ( [self isBoxViewPostionAccepted:boxViewFramPositionX])
            {
                [self.boxView setFrame:CGRectMake(boxViewFramPositionX,self.boxView.positionY_RelatToItsSuperView,boxViewWidth,self.boxView.bounds.size.height)];
                
            }
        }
    }
    
}

-(BOOL)touchBoxViewwithinAcceptedRange:(CGPoint)position{
    return [self CGPointGreaterThanZero:boxViewTouchPostion] && boxViewTouchPostion.x < boxViewWidth;
}
-(BOOL) CGPointGreaterThanZero:(CGPoint)point{
    
    return point.x > 0 && point.y> 0;
}

/*
 - (id)tempVariable:(id)Varibles{
 
 return nil;
 }
 */
float oldPoitionX = -1;
// return right or left
- (int) boxViewMovePosition:(float) positionX{
    
    if (positionX > oldPoitionX) {
        oldPoitionX = positionX;
        return RIGHT;
    }else{
        oldPoitionX = positionX;
        return LEFT;
    }
    
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    // NSLog(@"has end with speed: %f and time %f orgin positon: %f",boxViewSpeed, self.time , boxViewTouchPostion.x);
    self.BoxViewHasBeenTouch = NO;
}


- (BOOL) isBoxViewPostionAccepted:(float) postion{
    if (postion > (CGRectGetMinX(self.view.bounds) - (boxViewWidth * .75) )&& postion < ( CGRectGetMaxX(self.view.bounds) - (boxViewWidth/4) )) {
        return YES;
    }
    return NO;
}





#pragma Ball (circleView)

float reduce = 0;

- (void) MoveBall:(NSTimer *)theTimer{
    
    circleViewPositionY= circleViewPositionY + reduce;
    [self.circleView setFrame:CGRectMake(circleViewPositionX, circleViewPositionY, circleViewWidth, circleViewHeight)];
    
    if ([self circleViewHasHitBoxView].isHit == true)
    {
        //   NSLog(@"inside");
        
        float d = 0;
        if ( orginalPositionX) {
            d = boxViewFramPositionX - orginalPositionX;
            if (d < 0) {
                d = -1 * d;
            }
        }
        
        
        
        NSLog(@"d: %f .t: %f . then speed: %f", d, self.time, (d/self.time));
        
        if (((d/self.time))/1000 < 1 || !self.time) {
            reduce = -1;
        }else{
            reduce = - 1 * ((d/self.time))/1000;
            
            
            
        }
        
    }
    else if (circleViewPositionY <= 0 ){//self.view.bounds.origin.y) {
        
        reduce = 1;
    }else if (circleViewPositionY > self.boxView.positionY_RelatToItsSuperView){
        self.startGameMode = GAMEOVER;
        [self.gamePlayingTimer invalidate];
        //  [self.start_restart_button setTitle:@"Restart Game " forState:UIControlStateNormal];
        [self.start_restart_button setHidden:NO];
        circleViewPositionY = 0;
        
    }
    
}
// using "SSA" means "Side, Side, Angle Triangles;
// calculate how much should the circle goes down before revese direction
- (float) howMuch_Y_positionShouldIncreas:(float)differeceBewteenTwoPositions{
    float _AnAngle;
    float angleNeed;
    float const _90DgreeInRadian = M_PI/2;
    float radius = circleViewHeight/2; // height = width
    
    // for calculate the length that need to be reduce in Y positin
    // sin(90) = 1;
    _AnAngle =  asin( (differeceBewteenTwoPositions )/radius );
    // to find the angle that will used to find the Yposition by what amout should decrees
    angleNeed = M_PI - _AnAngle - _90DgreeInRadian;
    return  (radius -  ( (sin(angleNeed) * radius) ))   ;
}


- (struct CircleInfo) circleViewHasHitBoxView{
    //circleView
    float circle_Y_PositionFromButtom = circleViewPositionY + circleViewHeight;
    float circle_X_PositinoLeft = circleViewPositionX  ;
    float circle_X_PositionRight = circleViewPositionX + circleViewWidth;
    float circle_X_PositionMid = circleViewPositionX + circleViewWidth/2;
    //boxView
    float box_X_positionLeft = boxViewFramPositionX;
    float box_X_positionRight = boxViewFramPositionX+ boxViewWidth ;
    // for calculate the length that need to be reduce in Y positin
    float differeceBewteenTwoPositions;
    float newCircle_Y_PositionFromButtom;
    // check if the circle in the range of the boxView
    if ( (circle_X_PositionRight >= box_X_positionLeft) && (circle_X_PositinoLeft <  box_X_positionRight) ) {
        // check if the boxView will hit from an angle
        if (circle_X_PositionMid < box_X_positionLeft) {
            // using "SSA" means "Side, Side, Angle Triangles;
            differeceBewteenTwoPositions = box_X_positionLeft - circle_X_PositionMid;
            
            newCircle_Y_PositionFromButtom = circle_Y_PositionFromButtom - [ self howMuch_Y_positionShouldIncreas:differeceBewteenTwoPositions] ;
            if ( newCircle_Y_PositionFromButtom >= self.boxView.positionY_RelatToItsSuperView ) {
                circleHoldInfo.isHit = true;
                return circleHoldInfo;
            }
        }else if(circle_X_PositionMid >  box_X_positionRight){
            // see "SSA" means "Side, Side, Angle;
            differeceBewteenTwoPositions = circle_X_PositionMid - box_X_positionRight ;
            newCircle_Y_PositionFromButtom = circle_Y_PositionFromButtom - [ self howMuch_Y_positionShouldIncreas:differeceBewteenTwoPositions] ;
            
            if (newCircle_Y_PositionFromButtom >= self.boxView.positionY_RelatToItsSuperView ) {
                circleHoldInfo.isHit = true;
                return circleHoldInfo;
            }
            
        }else{
            // hit from the mid
            if (circle_Y_PositionFromButtom >= (self.boxView.positionY_RelatToItsSuperView )) {
                circleHoldInfo.isHit = true;
                return circleHoldInfo;
            }
            
        }
        
    }
    circleHoldInfo.isHit = false;
    return circleHoldInfo;
    
}




- (IBAction)SatrtGame:(id)sender {
    circleViewPositionX = [self.circleView positionX];
    self.gamePlayingTimer = [NSTimer scheduledTimerWithTimeInterval:0.003f target:self selector:@selector(MoveBall:) userInfo:nil repeats:YES];
    [sender setHidden:YES];
    self.startGameMode = PLAY_MODE;
}
- (void) restarGame{
    self.startGameMode = RESTART_GAME_MODE;
    [self.gamePlayingTimer invalidate];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
