//
//  TapeViewController.m
//  Calculator
//
//  Created by Rahim Baraky on 26/02/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import "TapeViewController.h"
#import "ViewController.h"

@interface TapeViewController ()

@end

@implementation TapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _LabelTapeMainView.text = Tape;
    _LabelTapeView2.text = Tape;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewWillDisappear: animated];
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    [prefs setObject:Tape forKey:@"info"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//}
- (IBAction)ButtonClearTape:(UIButton *)sender {
    Tape = @" ";
    _LabelTapeMainView.text=@" ";
    _LabelTapeView2.text=@" ";
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)ButtonBack:(UIButton *)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
