//
//  AppDelegate.h
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/30/22.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

