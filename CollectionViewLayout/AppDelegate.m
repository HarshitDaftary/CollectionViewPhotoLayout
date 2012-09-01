//
//  CollectionViewLayout
//
//  Created by Devon on 2012-07-09.
//  Copyright (c) 2012 Devon. All rights reserved.
//	https://github.com/fishpie
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "PhotoLayout.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	PhotoLayout *layout = [[PhotoLayout alloc] init];
    self.viewController = [[ViewController alloc] initWithCollectionViewLayout:layout];
    layout.delegate = (id <ScaledViewProtocol>)self.viewController;
	
    self.window.rootViewController = self.viewController;
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
