//
//  CellIdentifierCell.h
//  DogWalkerPro
//
//  Created by Thomas Clarke on 20/08/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (nonatomic, strong) IBOutlet UILabel *locationLabel;
@property (nonatomic, strong) IBOutlet UILabel *PetNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *DescriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *ContactNoLabel;
@property (nonatomic, strong) IBOutlet UIImageView *ImageViewSet;
@end