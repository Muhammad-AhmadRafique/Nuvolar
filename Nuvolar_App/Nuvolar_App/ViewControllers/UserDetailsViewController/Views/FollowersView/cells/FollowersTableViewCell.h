//
//  FollowersTableViewCell.h
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/31/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FollowersTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;

-(void) configureCell:(NSDictionary*) item;
@end

NS_ASSUME_NONNULL_END
