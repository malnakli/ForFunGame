//
//  ForFunViewController.h
//  ForFunGame
//
//  Created by MoAir on 1/19/2014.
//  Copyright (c) 2014 MoAir. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "DefineAttributes.h"

@interface ForFunViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *start_restart_button;
/*
 look to DefineAttributes header
 */
@property (nonatomic) int startGameMode;
@end
