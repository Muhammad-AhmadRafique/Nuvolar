#import "AsyncURLConnection.h"
@implementation AsyncURLConnection

//NEW CODE
@synthesize imageTag=_imgTag;

+ (id)request:(NSURL *)requestUrl completeBlock:(completeBlock_t)completeBlock errorBlock:(errorBlock_t)errorBlock
{
	return [[self alloc] initWithRequest:requestUrl
							completeBlock:completeBlock errorBlock:errorBlock];
}

- (id)initWithRequest:(NSURL *)requestUrl completeBlock:(completeBlock_t)completeBlock errorBlock:(errorBlock_t)errorBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setValue: @"application/vnd.github+json" forHTTPHeaderField: @"Accept"];
    [request setValue:@"Bearer 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" forHTTPHeaderField: @"Authorization"];
	if ((self = [super
			initWithRequest:request delegate:self startImmediately:NO])) {
		data_ = [[NSMutableData alloc] init];
        _imgTag=-1;
		completeBlock_ = [completeBlock copy];
		errorBlock_ = [errorBlock copy];
		
		[self start];
	}

	return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[data_ setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[data_ appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    completeBlock_(data_);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	errorBlock_(error);
}

@end
