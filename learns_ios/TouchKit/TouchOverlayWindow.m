//
//  TouchOverlayWindow.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//

#import "TouchOverlayWindow.h"
#import "TouchView.h"

@implementation TouchOverlayWindow

- (void)sendEvent:(UIEvent *)event {
    NSSet *touches = [event allTouches];
    NSMutableSet *began = nil;
    NSMutableSet *moved = nil;
    NSMutableSet *ended = nil;
    NSMutableSet *cancelled = nil;
    
    for (UITouch *touch in touches) {
        switch ([touch phase]) {
            case UITouchPhaseBegan:
                if (!began) began = [NSMutableSet set];
                [began addObject:touch];
                break;
            case UITouchPhaseMoved:
                if (!moved) moved = [NSMutableSet set];
                [moved addObject:touch];
                break;
            case UITouchPhaseEnded:
                if (!ended) ended = [NSMutableSet set];
                [ended addObject:touch];
                break;
            case UITouchPhaseCancelled:
                if (!cancelled) cancelled = [NSMutableSet set];
                [cancelled addObject:touch];
                break;
            default:
                break;
        }
    }
    
    if (began) {
        [[TouchView sharedInstance] touchesBegan:began withEvent:event];
    }
        
    if (moved) {
        [[TouchView sharedInstance] touchesMoved:moved withEvent:event];
    }
    
    if (ended) {
        [[TouchView sharedInstance] touchesEnded:ended withEvent:event];
    }
    
    if (cancelled) {
        [[TouchView sharedInstance] touchesCancelled:cancelled withEvent:event];
    }
}

@end
