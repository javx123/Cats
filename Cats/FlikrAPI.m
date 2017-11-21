//
//  FlikrAPI.m
//  Cats
//
//  Created by Javier Xing on 2017-11-20.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

#import "FlikrAPI.h"

@implementation FlikrAPI

+ (void)searchFor:(NSString*)tag complete:(void (^)(NSArray *results))done{
    NSURL *flikrUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=e885c2393fbb17e24c24fa4756c93fbc&tags=%@", tag]];
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
        done([NSArray arrayWithArray:allPhotos]);
        }];
    [task resume];
}

+ (void)loadImage:(Photos*)photo completionHandler:(void (^)(UIImage *image))finishedCallback{
    if (photo.photoImage != nil) {
        finishedCallback(photo.photoImage);
    }
    else{
        NSURLSessionTask *task = [[NSURLSession sharedSession] downloadTaskWithURL:photo.photoURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            UIImage * image = [UIImage imageWithContentsOfFile:location.path];
            photo.photoImage = image;
        }];
        [task resume];
    }
}



@end
