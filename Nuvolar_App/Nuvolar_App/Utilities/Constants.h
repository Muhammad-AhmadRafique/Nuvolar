#include <UIKit/UIDevice.h>
#include <UIKit/UIKit.h>

//API Base URL
#define API_BASE_ADDRESS                       @"https://api.github.com/"

#define IS_IPHONE (!IS_IPAD)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
#define bundle_identifier [[NSBundle mainBundle] bundleIdentifier]

//api methods
#define ksearch_user                        @"search/users"
#define kusers                              @"users/"

//constants
#define kOKMSG                              @"Ok"
#define kCongrats                           @""
#define kerror_message                      @"error_message"
#define ksuccess_message                    @"success_message"

#define kitems                              @"items"
#define klogin                              @"login"
#define kavatar_url                         @"avatar_url"
#define kfollowers_url                      @"followers_url"
#define krepos_url                          @"repos_url"
#define kfull_name                          @"full_name"
#define kprivate                            @"private"
#define kdescription                        @"description"
#define kname                               @"name"
#define kemail                              @"email"
#define klocation                           @"location"
#define kpublic_repos                       @"public_repos"
#define kfollowers                          @"followers"
#define kfollowing                          @"following"
#define kfollowers                          @"followers"
#define kfollowers                          @"followers"
#define ktype                               @"type"
#define kper_page                           @"per_page"
#define kpage                               @"page"
#define kUsers                              @"Users"
#define kQuery                              @"q"
#define kuserHistory                        @"userHistory"

//UITableViewCell identifiers
#define kMain                               @"Main"

//Images
#define profilePlaceholder                  [UIImage imageNamed:@"profile_placeholder"]
