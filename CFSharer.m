//
//  Sharer.m
//  CFShareCircle
//
//  Created by Camden on 1/15/13.
//  Copyright (c) 2013 Camden. All rights reserved.
//

#import "CFSharer.h"

@implementation CFSharer

@synthesize name = _name;
@synthesize image = _image;

- (id)initWithName:(NSString *)name imageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        _name = name;
        _image = [UIImage imageNamed:imageName];
    }
    return self;    
}



+ (CFSharer *)photoLibrary {
    return [[CFSharer alloc] initWithName:@"Photos" imageName:@"photo_library.png"];
}

+ (CFSharer *)dropbox {
    return [[CFSharer alloc] initWithName:@"Dropbox" imageName:@"dropbox.png"];
}

+ (CFSharer *)whatsapp {
    return [[CFSharer alloc] initWithName:@"Whatsapp" imageName:@"whatsapp.png"];
}

+ (CFSharer *)facebook {
    return [[CFSharer alloc] initWithName:@"Facebook" imageName:@"facebook.png"];
}
+ (CFSharer *)line {
    return [[CFSharer alloc] initWithName:@"line" imageName:@"lineicon.png"];
}
+ (CFSharer *)wechat {
    return [[CFSharer alloc] initWithName:@"wechat" imageName:@"wechat.png"];
}

+ (CFSharer *)googleDrive {
    return [[CFSharer alloc] initWithName:@"Google Drive" imageName:@"google_drive.png"];
}

+ (CFSharer *)pinterest {
    return [[CFSharer alloc] initWithName:@"photo_library" imageName:@"photo_library.png"];
}
+ (CFSharer *)more {
    return [[CFSharer alloc] initWithName:@"more" imageName:@"more.png"];
}
+ (CFSharer *)twitter {
    return [[CFSharer alloc] initWithName:@"twitter" imageName:@"twitter.png"];
}
+ (CFSharer *)sina_weibo {
    return [[CFSharer alloc] initWithName:@"sina_weibo" imageName:@"sina-weibo.png"];
}
@end
