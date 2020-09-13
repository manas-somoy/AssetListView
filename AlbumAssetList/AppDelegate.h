//
//  AppDelegate.h
//  AlbumAssetList
//
//  Created by Somoy on 20/10/19.
//  Copyright © 2019 Somoy Das Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) UIWindow *window;

- (void)saveContext;


@end

