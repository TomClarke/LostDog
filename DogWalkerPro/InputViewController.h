//
//  InputViewController.h
//  DogWalkerPro
//
//  Created by Thomas Clarke on 16/07/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPKeyboardAvoidingScrollView;
@interface InputViewController : UIViewController

@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

- (IBAction)backgroundClick:(id)sender;

@end
