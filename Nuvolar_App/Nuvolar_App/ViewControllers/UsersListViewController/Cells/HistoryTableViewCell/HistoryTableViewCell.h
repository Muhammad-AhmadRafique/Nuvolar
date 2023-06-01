//
//  HistoryTableViewCell.h
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 9/2/22.
//

#import <UIKit/UIKit.h>
#import "UserHistory.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;

-(void) configureCell:(UserHistory*) user;

@end

NS_ASSUME_NONNULL_END
