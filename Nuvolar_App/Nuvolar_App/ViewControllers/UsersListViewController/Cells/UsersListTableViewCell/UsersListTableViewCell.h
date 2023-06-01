//
//  UsersListTableViewCell.h
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/30/22.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UsersListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;

-(void) configureCell:(UserModel*) user;

@end

NS_ASSUME_NONNULL_END
