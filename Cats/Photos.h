//
//  photos.h
//  Cats
//
//  Created by Javier Xing on 2017-11-20.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Photos : NSObject
@property (nonatomic, strong) NSURL *photoURL;
@property (nonatomic, strong) UIImage *photoImage;

@property (nonatomic, strong) NSString *farmId;
@property (nonatomic, strong) NSString *photoId;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *serverId;
@property (nonatomic,strong) NSString *title; 



- (instancetype)initWithInfo:(NSDictionary*)info;
-(void)photoImageURL;


@end
