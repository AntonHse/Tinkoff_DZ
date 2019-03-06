//
//  ThemesViewController.m
//  TinkoffChat
//
//  Created by Антон Шуплецов on 05/03/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

#import "ThemesViewController.h"
@class Themes;

@interface ThemesViewController ()

@end

@implementation ThemesViewController


- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:(YES) completion: nil];
    [_model release];
    [_model dealloc];
    [_delegate release];
}

- (IBAction)theme1ButtonAction:(id)sender {
    self.view.backgroundColor = _model.theme1;
    [_delegate themesViewController:self didSelectTheme:_model.theme1];
}
- (IBAction)theme2ButtonAction:(id)sender {
    self.view.backgroundColor = _model.theme2;
    [_delegate themesViewController:self didSelectTheme:_model.theme2];
}
- (IBAction)theme3ButtonAction:(id)sender {
    self.view.backgroundColor = _model.theme3;
    [_delegate themesViewController:self didSelectTheme:_model.theme3];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [Themes new];
    makeBeautifullButton(_theme1ButtonOutlet);
    makeBeautifullButton(_theme2ButtonOutlet);
    makeBeautifullButton(_theme3ButtonOutlet);
    
}

void makeBeautifullButton(UIButton* button) {
    button.layer.cornerRadius = 5;    // радиус закругления закругление
    button.layer.borderWidth = 2;   // толщина обводки
    button.clipsToBounds = true;
}

@end
