

#import "AbstractFetcher.h"
#import "ASyncURLConnection.h"
#import <UIKit/UIKit.h>

@implementation AbstractFetcher
@synthesize container;

- (id) init {
	if (self = [super init]) {
	}
	return self;
}

- (void)fetchWithUrl:(NSURL *)url completionBlock:(AbstractFetcherCompletion)completed errorBlock:(AbstractFetcherError)errored
{
	[AsyncURLConnection request:url completeBlock:^(NSData *data) {

		if (data) {
			completed(data);
		} else {
			errored(nil);
		}
		
	} errorBlock:^(NSError *error) {
        NSLog(@"ERROR in request");
		errored(error);
	}];
}

@end
