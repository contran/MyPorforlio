//
//  ViewController.m
//  PatternOccurance
//
//  Created by Cong Tran on 2017-08-18.
//  Copyright © 2017 minhtran. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface ViewController()
{
   
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.inputLength.delegate = self;
    self.inputString.delegate = self;
    
    self.inputString.layer.cornerRadius=8.0f;
    self.inputString.layer.masksToBounds=YES;
    self.inputString.layer.borderColor=[[UIColor orangeColor]CGColor];
    self.inputString.layer.borderWidth= 1.0f;
    self.inputString.text = @"Please enter your input...";
    
    self.outputResult.layer.cornerRadius=8.0f;
    self.outputResult.layer.masksToBounds=YES;
    self.outputResult.layer.borderColor=[[UIColor orangeColor]CGColor];
    self.outputResult.layer.borderWidth= 1.0f;
    self.outputResult.delegate = self;
    
    self.inputLength.layer.cornerRadius=8.0f;
    self.inputLength.layer.masksToBounds=YES;
    self.inputLength.layer.borderColor=[[UIColor orangeColor]CGColor];
    self.inputLength.layer.borderWidth= 1.0f;
    self.inputLength.delegate = self;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    double wei = appDelegate.window.frame.size.width;
    double hei = appDelegate.window.frame.size.height;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad &&
        [[[UIDevice currentDevice] model] hasPrefix:@"iPad"]) {
        self.inputString.frame = CGRectMake(4, 40, wei-8, hei/4);
        self.inputLength.frame = CGRectMake(4,self.inputString.frame.origin.y+self.inputString.frame.size.height+20, wei/2, 30);
        self.goBut.frame= CGRectMake(4,self.inputLength.frame.origin.y+self.inputLength.frame.size.height+20, 100, 100);
        self.outputResult.frame = CGRectMake(4,self.goBut.frame.origin.y+self.goBut.frame.size.height+20, wei-8, hei/4);
    } else {
        self.inputString.frame = CGRectMake(4, 40, wei-8, hei/4);
        self.inputLength.frame = CGRectMake(4,self.inputString.frame.origin.y+self.inputString.frame.size.height+20, 2*wei/3, 30);
        self.goBut.frame= CGRectMake(4,self.inputLength.frame.origin.y+self.inputLength.frame.size.height+20, 50, 50);
        self.outputResult.frame = CGRectMake(4,self.goBut.frame.origin.y+self.goBut.frame.size.height+20, wei-8, hei/4);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) Go:(id) sender
{
    [self.inputLength resignFirstResponder];
    [self checkPatternOccurance];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad ||
        ![[[UIDevice currentDevice] model] hasPrefix:@"iPad"]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self checkPatternOccurance];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == self.inputString)
    if ([textView.text isEqualToString:@"Please enter your input..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}


- (BOOL)textViewShouldReturn:(UITextView *)textView
{
    [textView resignFirstResponder];
    [_inputLength becomeFirstResponder];
    return YES;
}

- (void)checkPatternOccurance {
    NSMutableArray *patternArr = [[NSMutableArray alloc] init];
    NSMutableArray *countArr = [[NSMutableArray alloc] init];
    NSString *inputStr = _inputString.text;
    if (!inputStr || inputStr.length == 0) {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"PLease enter your input!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
        return;
    }
    int inputLen = [_inputLength.text intValue];
    if (!self.inputLength || self.inputLength.text.length == 0 || inputLen < 1 || inputLen > inputStr.length/2) {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"PLease enter your correct input length!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
        return;
    }
    unsigned long len = [inputStr length];
    for (int i=0;i<len - inputLen;i++) {
        NSRange range = NSMakeRange(i, inputLen);
        NSString *pattern = [inputStr substringWithRange:range];
        BOOL found = NO;
        for (int h=0;h<[patternArr count];h++) {
            if ([pattern isEqualToString:patternArr[h]]) {
                found = YES;
                break;
            }
        }
        if (found == YES)
            continue;
        for (int j=i+inputLen;j<len-inputLen;j++) {
            NSRange givenRange = NSMakeRange(j, inputLen);
            NSString *givenStr = [inputStr substringWithRange:givenRange];
            if ([pattern isEqualToString:givenStr]) {
                found = NO;
                for (int k=0;k<[patternArr count];k++) {
                    if ([pattern isEqualToString:patternArr[k]]) {
                        int val = [countArr[k] intValue];
                        val++;
                        countArr[k] = [NSNumber numberWithInt:val];
                        found = YES;
                        break;
                    }
                }
                if (found == NO) {
                    [patternArr addObject:givenStr];
                    [countArr addObject:[NSNumber numberWithInt:2]];
                }
                
            }
        }
    }
    NSMutableString *output = [[NSMutableString alloc] init];
    [output appendString:@"Number of pattern occurances found are :\n"];
    for (int i=0;i<[patternArr count];i++) {
        [output appendString:[NSString stringWithFormat:@"  %@   %d\n", patternArr[i], [countArr[i] intValue]]];
    }
    _outputResult.text = output;
}


- (void)keyboardWillShow:(NSNotification *)note {
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 163, 106, 53);
    doneButton.adjustsImageWhenHighlighted = NO;
    [doneButton setTitle:@"Go" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(Go:) forControlEvents:UIControlEventTouchUpInside];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *keyboardView = [[[[[UIApplication sharedApplication] windows] lastObject] subviews] firstObject];
            [doneButton setFrame:CGRectMake(0, keyboardView.frame.size.height - 53, 106, 53)];
            [keyboardView addSubview:doneButton];
            [keyboardView bringSubviewToFront:doneButton];
            
            [UIView animateWithDuration:[[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]-.02
                                  delay:.0
                                options:[[note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]
                             animations:^{
                                 self.view.frame = CGRectOffset(self.view.frame, 0, 0);
                             } completion:nil];
        });
    }else {
        // locate keyboard view
        dispatch_async(dispatch_get_main_queue(), ^{
            UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
            UIView* keyboard;
            for(int i=0; i<[tempWindow.subviews count]; i++) {
                keyboard = [tempWindow.subviews objectAtIndex:i];
                // keyboard view found; add the custom button to it
                if([[keyboard description] hasPrefix:@"UIKeyboard"] == YES)
                    [keyboard addSubview:doneButton];
            }
        });
    }
}

@end
