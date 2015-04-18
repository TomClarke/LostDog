//
//  MissingDogTableViewController.h
//  DogWalkerPro
//
//  Created by Thomas Clarke on 16/08/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Parse/Parse.h"

@interface MissingDogsViewController : PFQueryTableViewController

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end
