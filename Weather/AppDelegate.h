//
//  AppDelegate.h
//  Weather
//
//  Created by Kai on 2022/8/15.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

