
#import "GenericFetcher.h"

@implementation GenericFetcher
- (id) init {
    if (self = [super init]) {
    }
    return self;
}

- (void)fetchWithUrl:(NSURL *)url withMethod:(RequestType)requestType withParams:(NSDictionary *)params completionBlock:(GenericFetcherCompletion)completed errorBlock:(GenericFetcherError)errored{
    AbstractFetcher *fetcher = [[AbstractFetcher alloc]init];
    [fetcher fetchWithUrl:url completionBlock:
     ^(NSData *webRawData){
        
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:webRawData options:kNilOptions error:&error];
        completed((NSDictionary*)json);
        
    } errorBlock:^(NSError *error){
        errored(error);
    }];
}

@end
