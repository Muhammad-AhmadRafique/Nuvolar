//
//  ImageCache.h
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/31/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageCache : NSObject

@property (nonatomic, retain) NSCache *imgCache;

#pragma mark - Methods

+ (ImageCache*)sharedImageCache;
- (void) AddImage:(NSString *)imageURL withImage:(UIImage *)image;
- (UIImage*) GetImage:(NSString *)imageURL;
- (BOOL) DoesExist:(NSString *)imageURL;

@end
