//
//  RepositoriesCollectionViewCell.h
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/31/22.
//

#import <UIKit/UIKit.h>
#import "RepoModel.h"
#import "ImageCache.h"
#import "CircularView.h"

NS_ASSUME_NONNULL_BEGIN

@interface RepositoriesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *imgContainer;

@property (weak, nonatomic) IBOutlet UILabel *repositoryNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (weak, nonatomic) IBOutlet UILabel *isPublicLbl;

-(void) configureCell:(RepoModel*) repo;

@end

NS_ASSUME_NONNULL_END
