//
//  SearchUsersListTableViewCell.h
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 9/1/22.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchUsersListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;

-(void) configureCell:(UserModel*) user;

@end

NS_ASSUME_NONNULL_END
