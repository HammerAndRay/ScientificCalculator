//
//  ViewController.h
//  Calculator
//
//  Created by Rahim Baraky on 22/02/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brain.h"
    NSString * Tape;
    NSString * TapeBuffer;

@interface ViewController : UIViewController{
    
    IBOutlet UILabel *LabelActiveCal;
    IBOutlet UILabel *LabelNonActiveCal;
    Brain * SendToBrain;
    Boolean InTheMiddleOfTyping;
    Boolean DecimalPressed;
    Boolean IsRadOn;
    Boolean OppPressed;
    Boolean numberpressed;
    NSNumber * ConvertDouble;

    __weak IBOutlet UILabel *LabelActiveCalLand;
    __weak IBOutlet UILabel *LabelNonActiveCalLand;
}

@end

