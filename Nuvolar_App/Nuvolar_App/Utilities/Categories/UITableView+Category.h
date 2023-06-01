//
//  UITableView+Category.h
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 9/2/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Category)

-(void) removeShadow;
-(void) addShadow;
- (void)reloadData:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
