//
//  ThemesViewController.h
//  TinkoffChat
//
//  Created by Антон Шуплецов on 05/03/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TinkoffChat-Bridging-Header.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThemesViewController : UIViewController

@property (retain) id<ThemesViewControllerDelegate> delegate;
@property (retain) Themes* model;


@property (weak, nonatomic) IBOutlet UIButton *theme1ButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *theme2ButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *theme3ButtonOutlet;


@end

NS_ASSUME_NONNULL_END
