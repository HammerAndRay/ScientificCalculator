//
//  Brain.h
//  Calculator
//
//  Created by Rahim Baraky on 24/02/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brain : NSObject {
    
    double operaterType;
    double operaterType2;
    NSString * waitingoperaterType2;
    

    
}

- (void) setOperaterType:(double) Opp;
- (double)doOperation:(NSString *)operation :(Boolean)CheckRad: (NSString *) LastOoperater;
- (void)doWaitingOperation;
//- (Boolean) IfRad:(Boolean)CheckRad;

@end
