//
//  MissingDogsTableViewController.h
//  DogWalkerPro
//
//  Created by Thomas Clarke on 16/08/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MissingDogsTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong,nonatomic) NSArray *LostDogsArray;
@property (strong,nonatomic) NSMutableArray *filteredLostDogsArray;
@property IBOutlet UISearchBar *LostDogsSearchBar;

