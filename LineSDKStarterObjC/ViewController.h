//
//  ViewController.h
//  LineSDKStarterObjC
//
//  Copyright (c) 2015 Line corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/// line3rdp.{YOUR_URL_SCHEME}
/// line3rdp.$(APP_IDENTIFIER)://authorize/

@property (weak, nonatomic) IBOutlet UIButton *buttonloginApp;
@property (weak, nonatomic) IBOutlet UIButton *buttonloginLine;
@property (weak, nonatomic) IBOutlet UIButton *buttonTryAPI;
@property (weak, nonatomic) IBOutlet UIButton *buttonProfileAPI;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogout;
@property (weak, nonatomic) IBOutlet UILabel *loginStatus;
@property (weak, nonatomic) IBOutlet UIButton *buttonSendTextAPI;
@property (weak, nonatomic) IBOutlet UIButton *buttonSendLinkMsgAPI;
@property (weak, nonatomic) IBOutlet UIButton *buttonSendLocation;


@end

