//
//  Flowchart.m
//  aCDSprototype1
//
//  Created by Erik on 3/5/15.
//  Copyright (c) 2015 FWS. All rights reserved.
//
/*
 
 Abstract:
 
 Fake flowchart view using a picture as flowchart.
 
 */

#import "Flowchart.h"
#import "Screen.h"

@implementation Flowchart
{
    double   _lastTime;
    NSTimer* _inertiaTimer;
    BOOL     _isInertiaing;
    CGPoint  _velocity;
}

- (instancetype) initWithParent:(Layer*)parent
{
    self = [super initWithParent:parent];
    if (self == nil) { return nil; }
    
    _inertiaTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    _isInertiaing = NO;
    _velocity     = CGPointZero;
    _lastTime     = [NSDate timeIntervalSinceReferenceDate];
    
    return self;
}

- (void) clamp
{
    if ( self.y > 64 )
    {
        self.y = 64;
        _velocity.y = 0;
    }
    if ( self.y < -4000 )
    {
        self.y = -4000;
        _velocity.y = 0;
    }
    
    if ( self.x > 0 )
    {
        self.x = 0;
        _velocity.x = 0;
    }
    if ( self.x < -self.width + 320 )
    {
        self.x = -self.width + 320;
        _velocity.x = 0;
    }
}

- (void) tick
{
    if ( _isInertiaing )
    {
        [UIView performWithoutAnimation:^(void)
         {
             self.y += _velocity.y/60;
             self.x += _velocity.x/60;
             [self clamp];
         }];
        _velocity.x *= 0.9;
        _velocity.y *= 0.9;
    }
}

//------------------------------------------------------------------
//
//  overriding touch handlers in Layer
//

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _isInertiaing = NO;
    _velocity = CGPointZero;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch* touch = [touches anyObject];
    
    [UIView performWithoutAnimation:^(void)
     {
         self.x = self.x + [touch locationInView:[Screen layer]].x - [touch previousLocationInView:[Screen layer]].x;
         self.y = self.y + [touch locationInView:[Screen layer]].y - [touch previousLocationInView:[Screen layer]].y;
         [self clamp];
     }];
    
    CGPoint newVelocity;
    newVelocity.x = ([touch locationInView:[Screen layer]].x - [touch previousLocationInView:[Screen layer]].x)/(touch.timestamp - _lastTime);
    newVelocity.y = ([touch locationInView:[Screen layer]].y - [touch previousLocationInView:[Screen layer]].y)/(touch.timestamp - _lastTime);
    _velocity.x = 0.25*_velocity.x + 0.75*newVelocity.x;
    _velocity.y = 0.25*_velocity.y + 0.75*newVelocity.y;
    
    _lastTime = touch.timestamp;
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    
    CGPoint newVelocity;
    newVelocity.x = ([touch locationInView:[Screen layer]].x - [touch previousLocationInView:[Screen layer]].x)/(touch.timestamp - _lastTime);
    newVelocity.y = ([touch locationInView:[Screen layer]].y - [touch previousLocationInView:[Screen layer]].y)/(touch.timestamp - _lastTime);
    _velocity.x = 0.25*_velocity.x + 0.75*newVelocity.x;
    _velocity.y = 0.25*_velocity.y + 0.75*newVelocity.y;
    
    if ( fabs( _velocity.y ) > 100 || fabs( _velocity.x ) > 100 )
    {
        _isInertiaing = YES;
    }
    
}

@end
