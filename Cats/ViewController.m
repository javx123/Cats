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
//    [FlikrAPI searchFor:@"cats" complete:^(NSArray *results) {
//        self.photos = results;
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            [self.collectionView reloadData];
//        }];
//    }];
    [self fetchDataFromAPI];


}
-(void)fetchDataFromAPI{
    NSURL *flikrUrl = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=e885c2393fbb17e24c24fa4756c93fbc&tags=cat"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL: flikrUrl];

    NSURLSessionTask *task= [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
            return;
        }
        NSHTTPURLResponse *resp = (NSHTTPURLResponse*)response;
        if (resp.statusCode > 299) {
            NSLog(@"Bad status code: %ld", resp.statusCode);
            abort();
        }

//        Start json parsing
        NSError *jsonError = nil;
        NSDictionary* photos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"Error:%@",jsonError.localizedDescription);
            return;
        }
        NSMutableArray *allPhotos = [[NSMutableArray alloc]init];

        for (NSDictionary* photoInfo in photos[@"photos"][@"photo"]) {
            NSString* photoTitle = photoInfo[@"title"];
            NSLog(@"Title: %@", photoTitle);
            Photos *photo = [[Photos alloc]initWithInfo:photoInfo];
            [photo photoImageURL];
            [allPhotos addObject:photo];
        }
        self.photos = [allPhotos mutableCopy];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
        NSLog(@"%@", self.photos);
    }];
    [task resume];
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
