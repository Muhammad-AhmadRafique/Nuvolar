//
//  FollowersTableViewCell.m
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/31/22.
//

#import "FollowersTableViewCell.h"
#import "UserModel.h"
#import "ImageCache.h"

@implementation FollowersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) configureCell:(UserModel*) user {
    if ([user isKindOfClass:[UserModel class]]) {
        _userNameLbl.text = user.loginName;
        
        if ([[ImageCache sharedImageCache] DoesExist:user.avatarURL] == true)
        {
            UIImage* image = [[ImageCache sharedImageCache] GetImage:user.avatarURL];
            _profileImageView.image = image;
        }
        else
        {
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: user.avatarURL]];
                if ( data == nil )
                    return;
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage* img = [UIImage imageWithData: data];
                    [[ImageCache sharedImageCache] AddImage:user.avatarURL withImage:img];
                    self->_profileImageView.image = img;
                });
            });
        }
    }
}

@end
