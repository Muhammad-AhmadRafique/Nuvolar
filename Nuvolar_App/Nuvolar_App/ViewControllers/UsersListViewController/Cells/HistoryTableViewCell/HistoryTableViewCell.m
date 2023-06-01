//
//  HistoryTableViewCell.m
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 9/2/22.
//

#import "HistoryTableViewCell.h"
#import "ImageCache.h"
#import "Constants.h"
#import "UIView+Category.h"

@implementation HistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    [_mainView addLighterShadow];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) configureCell:(UserHistory*) user {
    if ([user isKindOfClass:[UserHistory class]]) {
        _userNameLbl.text = user.loginName;
        
        if ([[ImageCache sharedImageCache] DoesExist:user.avatarURL] == true) {
            UIImage* image = [[ImageCache sharedImageCache] GetImage:user.avatarURL];
            _profileImageView.image = image;
        } else {
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: user.avatarURL]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ( data == nil ) {
                        self->_profileImageView.image = profilePlaceholder;
                    } else {
                        // WARNING: is the cell still using the same data by this point??
                        UIImage* img = [UIImage imageWithData: data];
                        [[ImageCache sharedImageCache] AddImage:user.avatarURL withImage:img];
                        self->_profileImageView.image = img;
                    }
                });
            });
        }
    }
}
@end
