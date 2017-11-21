//
//  photos.m
//  Cats
//
//  Created by Javier Xing on 2017-11-20.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

#import "Photos.h"

@implementation Photos

- (instancetype)initWithInfo:(NSDictionary*)info
{
    self = [super init];
    if (self) {
        _farmId = info[@"farm"];
        _photoId = info[@"id"];
        _serverId = info[@"server"];
        _secret = info [@"secret"];
        _title = info[@"title"];
    }
    return self;
}

-(void)photoImageURL{
    NSString *urlString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg",self.farmId, self.serverId, self.photoId, self.secret];
    NSURL *url = [NSURL URLWithString:urlString];
    self.photoURL = url;
}

-(UIImage *)photoImage{
    self.photoImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.photoURL]];
    return self.photoImage;
}
@end
