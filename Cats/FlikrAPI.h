//
//  FlikrAPI.h
//  Cats
//
//  Created by Javier Xing on 2017-11-20.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photos.h"

@interface FlikrAPI : NSObject

+ (void)searchFor:(NSString*)tag complete:(void (^)(NSArray *results))done;

+ (void)loadImage:(Photos*)photo completionHandler:(void (^)(UIImage *image))finishedCallback;

@end
