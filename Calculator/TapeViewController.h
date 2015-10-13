//
//  TapeViewController.h
//  Calculator
//
//  Created by Rahim Baraky on 26/02/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *ButtonGoBack;
- (IBAction)ButtonBack:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextView *LabelTapeMainView;
@property (weak, nonatomic) IBOutlet UITextView *LabelTapeView2;

@end
