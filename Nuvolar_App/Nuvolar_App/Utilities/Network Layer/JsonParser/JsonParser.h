//
//  JsonParser.h
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/30/22.
//

#import <Foundation/Foundation.h>
#import "UserDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JsonParser : NSObject
- (NSMutableArray*)arrayOfUsersWithDictionary:(NSDictionary*)dictionary;
- (NSMutableArray*)arrayOfReposWith:(NSDictionary*)dictionary;
- (NSMutableArray*)arrayOfFollowersWith:(NSMutableArray*)array;
- (UserDetailModel*)objectWith:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END
