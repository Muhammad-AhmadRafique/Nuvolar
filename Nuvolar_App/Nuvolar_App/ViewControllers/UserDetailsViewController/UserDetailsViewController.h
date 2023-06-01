//
//  UserDetailsViewController.h
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/31/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewLeadingConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *followersCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *reposCountLbl;

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UILabel *locationLbl;

@property (nonatomic, assign) NSString* userName;

@end

NS_ASSUME_NONNULL_END
