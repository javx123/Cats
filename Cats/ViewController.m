//
//  ViewController.m
//  Cats
//
//  Created by Javier Xing on 2017-11-20.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

#import "ViewController.h"
#import "Photos.h"
#import "PhotoCollectionViewCell.h"
#import "FlikrAPI.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic,strong) NSArray <Photos*> *photos;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [FlikrAPI searchFor:@"cat" complete:^(NSArray *results) {
        self.photos = results;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photos.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    NSLog(@"%ld", indexPath.row);

    [cell setCellImage:self.photos[indexPath.row].photoURL];
//    cell.photoImage.image = self.photos[indexPath.row].photoImage;
    cell.photoLabel.text = self.photos[indexPath.row].title;
    return cell;
    
}

@end
