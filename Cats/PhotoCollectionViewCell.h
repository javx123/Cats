//
//  PhotoCollectionViewCell.h
//  Cats
//
//  Created by Javier Xing on 2017-11-20.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *photoLabel;

-(void)setCellImage:(NSURL*)imageURL;

@end
