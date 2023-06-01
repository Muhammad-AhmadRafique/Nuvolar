//
//  Router.h
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/31/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Router : NSObject

+(Router *)sharedInstance;
-(void) openUserDetailsScreen:(UINavigationController*)navController : (NSString*)userName;

@end

NS_ASSUME_NONNULL_END
