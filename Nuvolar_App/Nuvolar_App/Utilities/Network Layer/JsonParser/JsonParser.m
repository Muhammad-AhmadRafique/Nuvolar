//
//  JsonParser.m
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/30/22.
//

#import "JsonParser.h"
#import "UserModel.h"
#import "RepoModel.h"
#import "Constants.h"

@implementation JsonParser

- (NSMutableArray*)arrayOfUsersWithDictionary:(NSDictionary*)dictionary {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray* itemsArray = [dictionary valueForKey:kitems];
    
    for (NSDictionary* dictionary in itemsArray) {
        
        UserModel *model = [[UserModel alloc] init];
        
        NSString* loginName = [dictionary objectForKey:klogin];
        NSString* avatarURL = [dictionary objectForKey:kavatar_url];
        NSString* followersURL = [dictionary objectForKey:kfollowers_url];
        NSString* reposURL = [dictionary objectForKey:krepos_url];

        if ([loginName isEqual:[NSNull null]]) {
            model.loginName = @"";
        } else {
            model.loginName = loginName;
        }
        if ([avatarURL isEqual:[NSNull null]]) {
            model.avatarURL = @"";
        } else {
            model.avatarURL = avatarURL;
        }
        if ([followersURL isEqual:[NSNull null]]) {
            model.followersURL = @"";
        } else {
            model.followersURL = followersURL;
        }
        if ([reposURL isEqual:[NSNull null]]) {
            model.reposURL = @"";
        } else {
            model.reposURL = reposURL;
        }
        
        [array addObject:model];
        
    }
    
    return array;
}

- (NSMutableArray*)arrayOfReposWith:(NSMutableArray*)array {
    
    NSMutableArray *usersArray = [[NSMutableArray alloc] init];

    for (NSDictionary* dictionary in array) {

        RepoModel *model = [[RepoModel alloc] init];
        
        NSString* fullName = [dictionary objectForKey:kfull_name];
        BOOL status = [[dictionary objectForKey:kprivate] boolValue];
        NSString* shortDescription = [dictionary objectForKey:kdescription];

        if ([fullName isEqual:[NSNull null]]) {
            model.fullName = @"";
        } else {
            model.fullName = fullName;
        }
        
        if(status == YES) {
            model.status = @"PRIVATE";
        } else {
            model.status = @"PUBLIC";
        }
        
        if ([shortDescription isEqual:[NSNull null]]) {
            model.shortDescription = @"";
        } else {
            model.shortDescription = shortDescription;
        }

        [usersArray addObject:model];

    }
    
    return usersArray;
}

- (NSMutableArray*)arrayOfFollowersWith:(NSMutableArray*)array {
    
    NSMutableArray *usersArray = [[NSMutableArray alloc] init];

    for (NSDictionary* dictionary in array) {

        UserModel *model = [[UserModel alloc] init];
        
        NSString* loginName = [dictionary objectForKey:klogin];
        NSString* avatarURL = [dictionary objectForKey:kavatar_url];
        NSString* followersURL = [dictionary objectForKey:kfollowers_url];
        NSString* reposURL = [dictionary objectForKey:krepos_url];

        if ([loginName isEqual:[NSNull null]]) {
            model.loginName = @"";
        } else {
            model.loginName = loginName;
        }
        
        if ([avatarURL isEqual:[NSNull null]]) {
            model.avatarURL = @"";
        } else {
            model.avatarURL = avatarURL;
        }
        
        if ([followersURL isEqual:[NSNull null]]) {
            model.followersURL = @"";
        } else {
            model.followersURL = followersURL;
        }
        
        if ([reposURL isEqual:[NSNull null]]) {
            model.reposURL = @"";
        } else {
            model.reposURL = reposURL;
        }
        
        [usersArray addObject:model];
    }
    
    return usersArray;
}

- (UserDetailModel*)objectWith:(NSDictionary*)dictionary {
    
    UserDetailModel *model = [[UserDetailModel alloc] init];
    
    NSString* fullName = [dictionary objectForKey:kname];
    NSString* avatarURL = [dictionary objectForKey:kavatar_url];
    NSString* email = [dictionary objectForKey:kemail];
    NSString* location = [dictionary objectForKey:klocation];
    int reposCount = [[dictionary objectForKey:kpublic_repos] intValue];
    int followersCount = [[dictionary objectForKey:kfollowers] intValue];
    int followingCount = [[dictionary objectForKey:kfollowing] intValue];

    if ([fullName isEqual:[NSNull null]]) {
        model.fullName = @"";
    } else {
        model.fullName = fullName;
    }
    if ([avatarURL isEqual:[NSNull null]]) {
        model.avatarURL = @"";
    } else {
        model.avatarURL = avatarURL;
    }
    if ([email isEqual:[NSNull null]]) {
        model.email = @"";
    } else {
        model.email = email;
    }
    if ([location isEqual:[NSNull null]]) {
        model.location = @"";
    } else {
        model.location = location;
    }
    
    model.reposCount = [NSString stringWithFormat:@"%d", reposCount];
    model.followersCount = [NSString stringWithFormat:@"%d", followersCount];
    model.followingCount = [NSString stringWithFormat:@"%d", followingCount];
    
    return model;
}

@end
