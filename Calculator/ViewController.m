//
//  ViewController.m
//  Calculator
//
//  Created by Rahim Baraky on 22/02/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import "ViewController.h"
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

@interface ViewController ()
{
    int CounterFor3rdFunctionPort;
    int CounterFor3rdFunctionLand;
    
}
@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionClear;
@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionPrecent;
@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionDivide;
@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionTimes;
@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionPlus;
@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionMinus;
@property (weak, nonatomic) IBOutlet UILabel *LabelRad;
@property (weak, nonatomic) IBOutlet UILabel *LabelSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *SwitchRad;
@property (weak, nonatomic) IBOutlet UISwitch *SwitchRad2;
@property (weak, nonatomic) IBOutlet UILabel *LabelRadIndcator;
@property (weak, nonatomic) IBOutlet UILabel *LabelRadIndcator2;

@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionSin;
@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionCos;
@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionTan;
@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionReciprocal;
@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionSquared;
@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionPi;
@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionLog10;
@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionLog;

@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionArcSin;
@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionArcCos;
@property (weak, nonatomic) IBOutlet UIButton *ButtonFunctionArcTan;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    Tape = [prefs stringForKey:@"info"];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    CounterFor3rdFunctionPort = 0;
    CounterFor3rdFunctionLand =0;
    TapeBuffer = @"";
    //    Tape = @"";
    // IsRadOn = YES;
    [_SwitchRad addTarget:self action:@selector(SwitchRad:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_SwitchRad];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:Tape forKey:@"info"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    _ButtonFunctionArcSin.hidden = YES;
    _ButtonFunctionArcCos.hidden = YES;
    _ButtonFunctionArcTan.hidden = YES;
    _ButtonFunctionSin.hidden = NO;
    _ButtonFunctionCos.hidden = NO;
    _ButtonFunctionTan.hidden = NO;
    _ButtonFunctionReciprocal.hidden = NO;
    _ButtonFunctionSquared.hidden = NO;
    _ButtonFunctionPi.hidden = NO;
    _ButtonFunctionLog10.hidden = NO;
    _ButtonFunctionLog.hidden = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//////////////////////////////////////////////////////////////////////////////

- (Brain *)SendToBrain
{
    if (!SendToBrain){ SendToBrain = [[Brain alloc] init];};
    return SendToBrain;
}

//////////////////////////////////////////////////////////////////////////////
- (void) NumberPressed:(NSString*)number{
    
    if (InTheMiddleOfTyping) {
        
        LabelActiveCal.text = [LabelActiveCal.text stringByAppendingString:number];
        LabelActiveCalLand.text = [LabelActiveCalLand.text stringByAppendingString:number];
    } else
    {
        [LabelActiveCal setText:number];
        [LabelActiveCalLand setText:number];
        InTheMiddleOfTyping = YES;
    }
}
//////////////////////////////////////////////////////////////////////////////

- (void) AllClear{
    //   [SendToBrain release];
    SendToBrain = [[Brain alloc] init];
    [LabelActiveCal setText:@"0"];
    [LabelNonActiveCal setText:@""];
    [LabelActiveCalLand setText:@"0"];
    [LabelNonActiveCalLand  setText:@""];
    DecimalPressed = NO;
    InTheMiddleOfTyping = NO;
    TapeBuffer = @"";
}
//////////////////////////////////////////////////////////////////////////////

- (void) clear {
    
    if (InTheMiddleOfTyping) {
        
        NSString * TextInCalLabel = LabelActiveCal.text;
        NSString * UpdatedCal = [TextInCalLabel substringToIndex:[TextInCalLabel length] - 1];
        
        NSString * TextInCalLabel2 = LabelActiveCalLand.text;
        NSString * UpdatedCal2 = [TextInCalLabel2 substringToIndex:[TextInCalLabel2 length] - 1];
        
        if ([UpdatedCal length] > 0)
        {
            LabelActiveCal.text = UpdatedCal;
            LabelActiveCalLand.text = UpdatedCal2;
        }
        else
        {
            InTheMiddleOfTyping= NO;
            LabelActiveCal.text = @"0";
            LabelActiveCalLand.text = @"0";
        }
    }
}
//////////////////////////////////////////////////////////////////////////////

- (void) decimalPoint {
    
    if (DecimalPressed == NO)
    {
        if (InTheMiddleOfTyping == NO)
        {
            InTheMiddleOfTyping = YES;
            [LabelActiveCal setText:@"0."];
            [LabelActiveCalLand setText:@"0."];
        }
        else
        {
            [LabelActiveCal setText:[[LabelActiveCal text] stringByAppendingString:@"."]];
            [LabelActiveCalLand setText:[[LabelActiveCalLand text] stringByAppendingString:@"."]];
        }
        DecimalPressed = YES;
    }
    
    
}
//////////////////////////////////////////////////////////////////////////////

- (void) operater:(NSString*)operaterType{
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        //    NSLog(@"This is Port");
        if ([LabelActiveCal.text isEqualToString:@"0"] &&( [operaterType isEqualToString:@"1/x"] || [operaterType isEqualToString:@"x²"]) ){
            
            [LabelNonActiveCal setText:@"Error!"];
            
            [self performSelector:@selector(AllClear) withObject:self afterDelay:1.0];
        }
        
        if (InTheMiddleOfTyping) {
            [[self SendToBrain] setOperaterType:[[LabelActiveCal text] doubleValue]];
            [LabelNonActiveCal setText:operaterType];
            InTheMiddleOfTyping = NO;
            DecimalPressed = NO;
            
            TapeBuffer = [TapeBuffer stringByAppendingString:LabelActiveCal.text];
            TapeBuffer = [TapeBuffer stringByAppendingString:operaterType];
            //    NSLog(@"This is when :%@",TapeBuffer);
            
            
            if ([operaterType isEqualToString:@"="])
            {
                InTheMiddleOfTyping = YES;
            }
            
        }
        else if ([operaterType isEqualToString:@"Sin"] || [operaterType isEqualToString:@"Cos"] || [operaterType isEqualToString:@"Tan"]|| [operaterType isEqualToString:@"ArcSin"]|| [operaterType isEqualToString:@"ArcCos"]|| [operaterType isEqualToString:@"ArcTan"]|| [operaterType isEqualToString:@"π"]) {
            [LabelNonActiveCal setText:operaterType];
        }
        double result = [[self SendToBrain] doOperation:operaterType:IsRadOn:[LabelNonActiveCal text]];
        ConvertDouble = [NSNumber numberWithDouble:result];
        [LabelActiveCal setText:[NSString stringWithFormat:@"%@", ConvertDouble]];
        
        if ([operaterType isEqualToString:@"="])
        {
            NSString * TempResult = [NSString stringWithFormat:@"%@",ConvertDouble];
            TapeBuffer = [TapeBuffer stringByAppendingString:TempResult];
            TapeBuffer = [TapeBuffer stringByAppendingString:@"\n"];
            Tape = [Tape stringByAppendingString:TapeBuffer];
            // NSLog(@"This is TapeBuffer :%@",TapeBuffer);
            // NSLog(@"This is Tape :%@",Tape);
        }
    }
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        //   NSLog(@"This is Land");
        if ([LabelActiveCalLand.text isEqualToString:@"0"] &&( [operaterType isEqualToString:@"1/x"] || [operaterType isEqualToString:@"x²"]) ){
            
            [LabelNonActiveCalLand setText:@"Error!"];
            
            [self performSelector:@selector(AllClear) withObject:self afterDelay:1.0];
        }
        
        if (InTheMiddleOfTyping) {
            [[self SendToBrain] setOperaterType:[[LabelActiveCalLand text] doubleValue]];
            [LabelNonActiveCalLand setText:operaterType];
            InTheMiddleOfTyping = NO;
            DecimalPressed = NO;
            
            //      Tape = [Tape stringByAppendingString:LabelActiveCal.text];
            
            TapeBuffer = [TapeBuffer stringByAppendingString:LabelActiveCalLand.text];
            TapeBuffer = [TapeBuffer stringByAppendingString:operaterType];
            //    NSLog(@"This is when :%@",TapeBuffer);
            
            
            if ([operaterType isEqualToString:@"="])
            {
                InTheMiddleOfTyping = YES;
            }
            
        }
        else if ([operaterType isEqualToString:@"Sin"] || [operaterType isEqualToString:@"Cos"] || [operaterType isEqualToString:@"Tan"]|| [operaterType isEqualToString:@"ArcSin"]|| [operaterType isEqualToString:@"ArcCos"]|| [operaterType isEqualToString:@"ArcTan"]|| [operaterType isEqualToString:@"π"]) {
            [LabelNonActiveCalLand setText:operaterType];
        }
        double result = [[self SendToBrain] doOperation:operaterType:IsRadOn:[LabelNonActiveCalLand text]];
        ConvertDouble = [NSNumber numberWithDouble:result];
        [LabelActiveCalLand setText:[NSString stringWithFormat:@"%@", ConvertDouble]];
        
        if ([operaterType isEqualToString:@"="])
        {
            NSString * TempResult = [NSString stringWithFormat:@"%@",ConvertDouble];
            TapeBuffer = [TapeBuffer stringByAppendingString:TempResult];
            Tape = [Tape stringByAppendingString:TapeBuffer];
            //  NSLog(@"This is TapeBuffer :%@",TapeBuffer);
            //  NSLog(@"This is Tape :%@",Tape);
        }
    }
}


//////////////////////////////////////////////////////////////////////////////
///////////////This section below  is for the first function buttons//////////
//////////////////////////////////////////////////////////////////////////////

- (IBAction)ButtonNumber0:(UIButton *)sender {
    [self NumberPressed:@"0"];
}
- (IBAction)ButtonNumber1:(UIButton *)sender {
    [self NumberPressed:@"1"];}

- (IBAction)ButtonNumber2:(UIButton *)sender {
    [self NumberPressed:@"2"];}

- (IBAction)ButtonNumber3:(UIButton *)sender {
    [self NumberPressed:@"3"];}

- (IBAction)ButtonNumber4:(UIButton *)sender {
    [self NumberPressed:@"4"];}

- (IBAction)ButtonNumber5:(UIButton *)sender {
    [self NumberPressed:@"5"];}

- (IBAction)ButtonNumber6:(UIButton *)sender {
    [self NumberPressed:@"6"];}

- (IBAction)ButtonNumber7:(UIButton *)sender {
    [self NumberPressed:@"7"];}

- (IBAction)ButtonNumber8:(UIButton *)sender {
    [self NumberPressed:@"8"];}

- (IBAction)ButtonNumber9:(UIButton *)sender {
    [self NumberPressed:@"9"];}


- (IBAction)ButtonFunctionPoint:(UIButton *)sender {
    [self decimalPoint];
}

- (IBAction)ButtonFunctionSignChange:(UIButton *)sender {
    [self operater:@"±"];
}

- (IBAction)ButtonFunctionClearAll:(UIButton *)sender {
    [self AllClear];
}

- (IBAction)ButtonFunctionClear:(UIButton *)sender {
    [self clear];
}

- (IBAction)ButtonFunctionPrecent:(UIButton *)sender {
    [self operater:@"%"];
}

- (IBAction)ButtonFunctionDivide:(UIButton *)sender {
    [self operater:@"÷"];
}

- (IBAction)ButtonFunctionTimes:(UIButton *)sender {
    [self operater:@"X"];
}

- (IBAction)ButtonFunctionPlus:(UIButton *)sender {
    [self operater:@"+"];
}

- (IBAction)ButtonFunctionMinus:(UIButton *)sender {
    [self operater:@"−"];
}

- (IBAction)ButtonFunctionEquals:(UIButton *)sender {
    [self operater:@"="];
}

- (IBAction)SwitchRad:(UISwitch *)sender {
    
    
    if (_SwitchRad.isOn){
        [[self LabelRadIndcator] setText:@"Rad"];
        [[self LabelRadIndcator2] setText:@"Rad"];
        IsRadOn = YES;
    }
    else {
        IsRadOn = NO;
        [[self LabelRadIndcator] setText:@"Deg"];
        [[self LabelRadIndcator2] setText:@"Deg"];
        
    }
}
- (IBAction)SwitchRad2:(UISwitch *)sender {
    
    if (_SwitchRad2.isOn){
        [[self LabelRadIndcator] setText:@"Rad"];
        [[self LabelRadIndcator2] setText:@"Rad"];
        IsRadOn = YES;
    }
    else {
        IsRadOn = NO;
        [[self LabelRadIndcator] setText:@"Deg"];
        [[self LabelRadIndcator2] setText:@"Deg"];
        
    }
}

//////////////////////////////////////////////////////////////////////////////
//////////////This section below  is for the second function buttons//////////
//////////////////////////////////////////////////////////////////////////////
- (IBAction)ButtonFunctionSin:(UIButton *)sender {
    [self operater:@"Sin"];
}
- (IBAction)ButtonFunctionCos:(UIButton *)sender {
    [self operater:@"Cos"];
}
- (IBAction)ButtonFunctionTan:(UIButton *)sender {
    [self operater:@"Tan"];
}
- (IBAction)ButtonFunction1x:(UIButton *)sender {
    [self operater:@"1/x"];
}
- (IBAction)ButtonFunctionx2:(UIButton *)sender {
    [self operater:@"x²"];
}
- (IBAction)ButtonFunctionPi:(UIButton *)sender {
    [self operater:@"π"];
}
- (IBAction)ButtonFunctionLog10:(UIButton *)sender {
    [self operater:@"Log10"];
}
- (IBAction)ButtonFunctionLn:(UIButton *)sender {
    [self operater:@"ln"];
}


//////////////////////////////////////////////////////////////////////////////
///////////////This section below  is for the thrid function buttons//////////
//////////////////////////////////////////////////////////////////////////////
- (IBAction)ButtonFunctionArcSin:(UIButton *)sender {
    [self operater:@"ArcSin"];
}

- (IBAction)ButtonFunctionArcCos:(UIButton *)sender {
    [self operater:@"ArcCos"];
}

- (IBAction)ButtonFunctionArcTan:(UIButton *)sender {
    [self operater:@"ArcTan"];
}

//////////////////////////////////////////////////////////////////////////////
//This section below  is for the "3rd" function which changes the buttons/////
//////////////////////////////////////////////////////////////////////////////

- (IBAction)ButtonFunction3rd:(UIButton *)sender {
    
    
    [self SetAnimationForButtons];
    
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        if (CounterFor3rdFunctionPort==0) {
            _ButtonFunctionArcSin.hidden = YES;
            _ButtonFunctionArcCos.hidden = YES;
            _ButtonFunctionArcTan.hidden = YES;
            _ButtonFunctionDivide.hidden = YES;
            _ButtonFunctionMinus.hidden = YES;
            _ButtonFunctionClear.hidden = YES;
            _ButtonFunctionPlus.hidden = YES;
            _ButtonFunctionPrecent.hidden = YES;
            _ButtonFunctionTimes.hidden = YES;
            _LabelRad.hidden = YES;
            _LabelSwitch.hidden = YES;
            _SwitchRad.hidden   = YES;
            
            //////
            
            _ButtonFunctionLog10.hidden = NO;
            _ButtonFunctionLog.hidden = NO;
            _ButtonFunctionSin.hidden = NO;
            _ButtonFunctionCos.hidden = NO;
            _ButtonFunctionTan.hidden = NO;
            _ButtonFunctionReciprocal.hidden = NO;
            _ButtonFunctionSquared.hidden = NO;
            _ButtonFunctionPi.hidden = NO;
            
            CounterFor3rdFunctionPort = 1;
            
        } else if(CounterFor3rdFunctionPort==1) {
            //   NSLog(@"In the Second If");
            _ButtonFunctionSin.hidden = YES;
            _ButtonFunctionCos.hidden = YES;
            _ButtonFunctionTan.hidden = YES;
            
            //////
            
            _ButtonFunctionArcSin.hidden = NO;
            _ButtonFunctionArcCos.hidden = NO;
            _ButtonFunctionArcTan.hidden = NO;
            
            CounterFor3rdFunctionPort = 2;
        } else if (CounterFor3rdFunctionPort==2){
            //   NSLog(@"In the Third If");
            _ButtonFunctionArcSin.hidden = YES;
            _ButtonFunctionArcCos.hidden = YES;
            _ButtonFunctionArcTan.hidden = YES;
            
            _ButtonFunctionDivide.hidden = NO;
            _ButtonFunctionMinus.hidden = NO;
            _ButtonFunctionClear.hidden = NO;
            _ButtonFunctionPlus.hidden = NO;
            _ButtonFunctionPrecent.hidden = NO;
            _ButtonFunctionTimes.hidden = NO;
            _LabelRad.hidden = NO;
            _LabelSwitch.hidden = NO;
            _SwitchRad.hidden   = NO;
            
            //////
            
            _ButtonFunctionLog10.hidden = YES;
            _ButtonFunctionLog.hidden = YES;
            _ButtonFunctionSin.hidden = YES;
            _ButtonFunctionCos.hidden = YES;
            _ButtonFunctionTan.hidden = YES;
            _ButtonFunctionReciprocal.hidden = YES;
            _ButtonFunctionSquared.hidden = YES;
            _ButtonFunctionPi.hidden = YES;
            CounterFor3rdFunctionPort = 0;
            
        }
    }
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        //  NSLog(@"This is Land");
        
        if (CounterFor3rdFunctionLand==0) {
            _ButtonFunctionArcSin.hidden = NO;
            _ButtonFunctionArcCos.hidden = NO;
            _ButtonFunctionArcTan.hidden = NO;
            _ButtonFunctionCos.hidden = YES;
            _ButtonFunctionSin.hidden = YES;
            _ButtonFunctionTan.hidden = YES;
            NSLog(@"This is Land");
            
            CounterFor3rdFunctionLand =1;
            
        }
        else if (CounterFor3rdFunctionLand==1) {
            _ButtonFunctionArcSin.hidden = YES;
            _ButtonFunctionArcCos.hidden = YES;
            _ButtonFunctionArcTan.hidden = YES;
            _ButtonFunctionCos.hidden = NO;
            _ButtonFunctionSin.hidden = NO;
            _ButtonFunctionTan.hidden = NO;
            CounterFor3rdFunctionLand=0;
            NSLog(@"This is Land2");
        }
        
    }
    
    
    
    
}


- (void) SetAnimationForButtons
{
    
    //////////////////////////////////////////////////////////////////////////
    //This will Set the Amimation for The buttons that will be disappareing///
    [UIView transitionWithView:_ButtonFunctionDivide
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_ButtonFunctionMinus
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_ButtonFunctionClear
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_ButtonFunctionPlus
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_ButtonFunctionPrecent
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_ButtonFunctionTimes
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_LabelRad
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_LabelSwitch
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_SwitchRad
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    ///////////////////////////////////////////////////////////////////////
    //This will Set the Amimation for The Science buttons
    [UIView transitionWithView:_ButtonFunctionSin
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_ButtonFunctionCos
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_ButtonFunctionTan
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_ButtonFunctionReciprocal
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_ButtonFunctionSquared
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_ButtonFunctionPi
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_ButtonFunctionLog10
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_ButtonFunctionLog
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    ///////////////////////////////////////////////////////////////////////
    //This will Set the Amimation for The Arc buttons
    [UIView transitionWithView:_ButtonFunctionArcSin
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_ButtonFunctionArcCos
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_ButtonFunctionArcTan
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    ///////////////////////////////////////////////////////////////////////
    
}








@end
