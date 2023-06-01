//
//  UserDetailModel.h
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/31/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDetailModel : NSObject

@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *avatarURL;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *followersCount;
@property (nonatomic, strong) NSString *reposCount;
@property (nonatomic, strong) NSString *followingCount;

@end

NS_ASSUME_NONNULL_END
