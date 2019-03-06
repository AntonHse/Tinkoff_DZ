//
//  ThemesViewControllerDelegate.h
//  TinkoffChat
//
//  Created by Антон Шуплецов on 05/03/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "TinkoffChat-Bridging-Header.h"

@class ThemesViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol ThemesViewControllerDelegate <NSObject>

- (void)themesViewController:(ThemesViewController *)controller didSelectTheme:(UIColor *)selectedTheme;

@end


NS_ASSUME_NONNULL_END
