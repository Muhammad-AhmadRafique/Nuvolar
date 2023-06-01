//
//  UserDetailsViewController.m
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/31/22.
//

#import "UserDetailsViewController.h"
#import "FollowersView.h"
#import "RepositoriesView.h"
#import "GenericFetcher.h"
#import "URLBuilder.h"
#import "JsonParser.h"
#import "Constants.h"
#import "UserDetailModel.h"
#import "ImageCache.h"

@interface UserDetailsViewController ()
@property (strong, nonatomic) IBOutlet FollowersView *followersView;
@property (strong, nonatomic) IBOutlet RepositoriesView *repositoriesView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end

@implementation UserDetailsViewController

UserDetailModel* userDetail;

#pragma mark - UIView life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:_followersView];
    [self.view addSubview:_repositoriesView];
    
    [self hideSegmentedViews];
    [_followersView setHidden:NO];
    [_followersView configureView:_userName];
    [_repositoriesView configureView:_userName];
    
    [self fetchUserDetail:_userName];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
       addObserver:self selector:@selector(orientationChanged:)
       name:UIDeviceOrientationDidChangeNotification
       object:[UIDevice currentDevice]];
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        _stackViewLeadingConstraint.constant = 50;
    } else {
        _stackViewLeadingConstraint.constant = 20;
    }
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_followersView setFrame:_mainView.frame];
    [_repositoriesView setFrame:_mainView.frame];
    
    _followersView.bounds = _mainView.bounds;
    _repositoriesView.bounds = _mainView.bounds;
    
    [_repositoriesView reloadViews];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [_repositoriesView reloadViews];
}

- (void) orientationChanged:(NSNotification *)note
{
   UIDevice * device = note.object;

   switch(device.orientation)
   {
       case UIDeviceOrientationPortrait:
           _stackViewLeadingConstraint.constant = 20;
           break;
       case UIDeviceOrientationLandscapeLeft:
       case UIDeviceOrientationLandscapeRight:
           _stackViewLeadingConstraint.constant = 50;
           break;
       default:
           break;
   };
}

#pragma mark - Helper Methods

-(void) hideSegmentedViews {
    [_followersView setHidden:YES];
    [_repositoriesView setHidden:YES];
}

#pragma mark - IBActions

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    [self hideSegmentedViews];
    if (sender.selectedSegmentIndex == 0 ) {
        [_followersView setHidden:NO];
    } else {
        [_repositoriesView setHidden:NO];
    }
}

#pragma mark - API Calls

-(void) fetchUserDetail:(NSString*)username {
    
    GenericFetcher *fetcher = [GenericFetcher new];
    NSString* apiURL = [NSString stringWithFormat:@"%@%@", kusers, username];
    
    [_activityIndicator startAnimating];
    __weak typeof(self) weakSelf = self;
    [fetcher fetchWithUrl:[URLBuilder urlForMethod:apiURL withParameters:nil] withMethod:GET_REQUEST withParams:nil completionBlock:^(NSDictionary *dict1) {
        
        [weakSelf.activityIndicator stopAnimating];
        
        JsonParser* parser = [[JsonParser alloc] init];
        userDetail = [parser objectWith:dict1];
                
        weakSelf.followersCountLbl.text = userDetail.followersCount;
        weakSelf.followingCountLbl.text = userDetail.followingCount;
        weakSelf.reposCountLbl.text = userDetail.reposCount;
        weakSelf.nameLbl.text = userDetail.fullName;
        weakSelf.emailLbl.text = userDetail.email;
        weakSelf.locationLbl.text = userDetail.location;
        
        [weakSelf.nameLbl setHidden:userDetail.fullName.length == 0];
        [weakSelf.emailLbl setHidden:userDetail.email.length == 0];
        [weakSelf.locationLbl setHidden:userDetail.location.length == 0];
        
        if ([[ImageCache sharedImageCache] DoesExist:userDetail.avatarURL] == true) {
            UIImage* image = [[ImageCache sharedImageCache] GetImage:userDetail.avatarURL];
            weakSelf.profileImageView.image = image;
        } else {
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: userDetail.avatarURL]];
                if ( data == nil )
                    return;
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage* img = [UIImage imageWithData: data];
                    [[ImageCache sharedImageCache] AddImage:userDetail.avatarURL withImage:img];
                    weakSelf.profileImageView.image = img;
                });
            });
        }
        
    } errorBlock:^(NSError *error) {
        [weakSelf.activityIndicator stopAnimating];
        NSLog(@"Error");
    }];
    
}
@end
