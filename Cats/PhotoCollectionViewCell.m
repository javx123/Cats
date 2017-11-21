//
//  PhotoCollectionViewCell.m
//  Cats
//
//  Created by Javier Xing on 2017-11-20.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

-(void)setCellImage:(NSURL*)imageURL{
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.photoImage.image = image;
        }];
    }];
    
    
//    [[NSURLSession sharedSession] downloadTaskWithURL:imageURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
//        self.photoImage.image = image;
//    }];
    [task resume];
}

@end
