//
//  Router.m
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/31/22.
//

#import "Router.h"
#import "UserDetailsViewController.h"
#import "Constants.h"

@implementation Router

static Router *sharedInstance = nil;

+(Router *)sharedInstance {
    @synchronized([Router class]) {
        if (!sharedInstance)
            sharedInstance= [[self alloc] init];
        return sharedInstance;
    }
    return nil;
}

-(void) openUserDetailsScreen:(UINavigationController*)navController : (NSString*)userName {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:kMain bundle:nil];
    UserDetailsViewController* controller = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([UserDetailsViewController class])];
    controller.userName = userName;
    [navController pushViewController:controller animated:YES];
}

@end
