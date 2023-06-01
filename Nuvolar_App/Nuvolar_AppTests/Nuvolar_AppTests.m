//
//  Nuvolar_AppTests.m
//  Nuvolar_AppTests
//
//  Created by Ahmad Rafiq on 8/30/22.
//

#import <XCTest/XCTest.h>
#import "UsersListViewController.h"
#import "Constants.h"
#import "GenericFetcher.h"
#import "URLBuilder.h"

@interface Nuvolar_AppTests : XCTestCase
@end

@implementation Nuvolar_AppTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [self testFetchUsers];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void) testFetchUsers {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString* query = [NSString stringWithFormat:@"%@%@", @"", @"+in:login"];
    [params setValue:query forKey:kQuery];
    [params setValue:kUsers forKey:ktype];
    [params setValue:@"20" forKey:kper_page];
    [params setValue:[NSString stringWithFormat:@"%d", 1] forKey:kpage];
        
    GenericFetcher *fetcher = [GenericFetcher new];
    [fetcher fetchWithUrl:[URLBuilder urlForMethod:ksearch_user withParameters:params] withMethod:GET_REQUEST withParams:params completionBlock:^(NSDictionary *dict1) {
        XCTAssertNil(dict1);
        XCTAssertNotNil(dict1);
        
    } errorBlock:^(NSError *error) {
        XCTAssertNotNil(error);
    }];
}
@end
