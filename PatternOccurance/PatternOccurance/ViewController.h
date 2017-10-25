//
//  ViewController.h
//  PatternOccurance
//
//  Created by Cong Tran on 2017-08-18.
//  Copyright © 2017 minhtran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
@property(atomic, strong) IBOutlet UITextView *inputString;
@property(atomic, strong) IBOutlet UITextField *inputLength;
@property(atomic, strong) IBOutlet UITextView *outputResult;
@property(atomic, strong) IBOutlet UIButton *goBut;


@end

