//
//  UserHistory.h
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 9/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserHistory : NSObject<NSSecureCoding> {
    NSString* loginName;
    NSString* avatarURL;
}

@property NSString* loginName;
@property NSString* avatarURL;

- (void) saveHistory:(NSArray*) array;
- (NSArray*) getHistory;

@end

NS_ASSUME_NONNULL_END
