

#import "URLBuilder.h"
#import "Constants.h"

@implementation URLBuilder

+ (NSURL*)urlForMethod:(NSString*)method withParameters:(NSDictionary*)params{
    
    NSURL* result;
    NSMutableString *queryString = [[NSMutableString alloc] init];
    
    for (int i = 0; i < [params allKeys].count; i++) {
        
        NSString* key = [params allKeys][i];
        id object= [params objectForKey:key];
        
        if (object) {
            if (i == 0) {
                [queryString appendFormat:@"?%@=%@&", key, [params objectForKey:key]];
            } else {
                [queryString appendFormat:@"%@=%@&", key, [params objectForKey:key]];
            }
        } else {
            [NSException exceptionWithName:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__] reason:@"Invalid key value pair" userInfo:nil]; 
        }          
    }
    
    NSLog(@"%@",queryString);
	if([queryString length]>0) {
		queryString = [NSMutableString stringWithFormat:@"%@",[queryString substringToIndex:[queryString length]-1]];
	}

    NSString *url=[NSString stringWithFormat:@"%@%@%@",API_BASE_ADDRESS,method,queryString];

    NSLog(@"%@",url);
	NSString *encodedURL=[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    result = [NSURL URLWithString:encodedURL];
    
    return result;         
}
+ (NSURL*)urlWithBaseAddress:(NSString*)baseAddress ForMethod:(NSString*)method withParameters:(NSDictionary*)params{
    
    NSURL* result;
    
    NSMutableString *queryString = [[NSMutableString alloc] init];
    
    for(NSString *key in [params allKeys]){
        
        id object= [params objectForKey:key];
        
        if (object) {
            [queryString appendFormat:@"%@=%@&", key, [params objectForKey:key]];
        } else {
            [NSException exceptionWithName:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__] reason:@"Invalid key value pair" userInfo:nil];
        }
    }
    
	if([queryString length]>0) {
		queryString =[NSMutableString stringWithFormat:@"%@",[queryString substringToIndex:[queryString length]-1]];
	}
    
    NSString *url=[NSString stringWithFormat:@"%@%@%@",baseAddress,method,queryString];
	NSString *encodedURL=[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    result = [NSURL URLWithString:encodedURL];
    
    return result;
    
}

@end
