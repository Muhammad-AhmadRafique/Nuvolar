
#import <Foundation/Foundation.h>

typedef void (^AbstractFetcherCompletion)(NSData *rawWebData);
typedef void (^AbstractFetcherError)(NSError *error);

@interface AbstractFetcher : NSObject

@property (nonatomic,retain) id container;

- (void)fetchWithUrl:(NSURL *)url completionBlock:(AbstractFetcherCompletion)objects errorBlock:(AbstractFetcherError)errorBlock;

@end
