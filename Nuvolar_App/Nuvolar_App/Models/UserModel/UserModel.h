//
//  UserModel.h
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/30/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (nonatomic, strong) NSString *loginName;
@property (nonatomic, strong) NSString *avatarURL;
@property (nonatomic, strong) NSString *followersURL;
@property (nonatomic, strong) NSString *reposURL;


@end

NS_ASSUME_NONNULL_END
