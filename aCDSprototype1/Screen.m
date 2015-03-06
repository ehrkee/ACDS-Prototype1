//
//  Screen.m
//  aCDSprototype1
//
//  Created by Erik on 3/5/15.
//  Copyright (c) 2015 FWS. All rights reserved.
//
/*
 
 Abstract:
 
 The entry point to our project where we setup all layers / pictures (see setup function).
 Screen is also the base layer and parent layer to most other layers (pictures).
 The dimensions of the screen layer correspond to the dimensions of the real screen.
 
 The commented out code in the setup function corresponds to the code snippets that we showed in our presentation.
 Uncommenting these code snippets requires commenting out the other parts in the setup function.
 
 */

#import "HelperKit.h"
#import "Screen.h"
#import "Flowchart.h"

@implementation Screen
{
}

//====================================================================================
//
//  setup your own picture layers here
//

- (void) setup {
    NSLog(@"%%Screen-I-DEBUG, Running Setup method.");
    //----------------------------------------------------------------------
    //
    // Complete Prototype
    
    Layer* screen = [Screen layer];
    
    // Create flowchart
    Flowchart* flowchart = [Flowchart layerWithParent:screen];
    [flowchart loadImage:@"junk.png"];
    /*
    // Create flowchart cover
    NSLog(@"%%Screen-I-DEBUG, Creating flowchart cover.");
    Layer* flowchartCover = [Layer layerWithParent:screen];
    flowchartCover.width = 768;
    //flowchartCover.height = screen.height - 225;
    flowchartCover.height = 900;
    flowchartCover.y = 0;
    flowchartCover.layer.backgroundColor = RGBA(220, 220, 220, 255);
     */

    /*
    Layer *flowchart = [Layer layerWithParent:screen];
    [flowchart loadImage:@"SepsisFlowchart2.png"];
    flowchart.x = -100;
    flowchart.y = -50;
     */
}

//====================================================================================
//
// screen initialization
//

static Screen* gScreen; // global screen layer

+ (void) initWithWindow:(UIWindow*)window
{
    gScreen = [Screen layerWithParent:window];
    gScreen.size = window.frame.size;
    [gScreen setup];
}

+ (Layer*) layer {
    return gScreen;
}


@end
