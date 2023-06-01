//
//  SearchUsersListTableViewCell.m
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 9/1/22.
//

#import "SearchUsersListTableViewCell.h"
#import "ImageCache.h"

@implementation SearchUsersListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) configureCell:(UserModel*) user {
    if ([user isKindOfClass:[UserModel class]]) {
        _userNameLbl.text = user.loginName;
    }
}
@end
