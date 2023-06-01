//
//  UserHistory.m
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 9/2/22.
//

#import "UserHistory.h"
#import "Constants.h"

@implementation UserHistory

@synthesize loginName;
@synthesize avatarURL;

// Confirms to NSSecureCoding
+ (BOOL)supportsSecureCoding {
    return true;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.loginName forKey: klogin];
    [coder encodeObject:self.avatarURL forKey: kavatar_url];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [self init];
    if (self){
        self.loginName = [coder decodeObjectOfClass:[NSString class] forKey:klogin];
        self.avatarURL = [coder decodeObjectOfClass:[NSString class] forKey:kavatar_url];
    }
    return  self;
}

- (void) saveHistory:(NSArray*) array {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kuserHistory];
}

- (NSArray*) getHistory {
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:kuserHistory];
    
    if (@available(iOS 14.0, *)) {
        NSArray *historyList = [NSKeyedUnarchiver unarchivedArrayOfObjectsOfClass:[NSObject class] fromData:data error:nil];
        return historyList;
    } else {
        // Fallback on earlier versions
        return @[];
    }
}
@end
