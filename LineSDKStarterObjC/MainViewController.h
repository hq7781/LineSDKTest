//
//  MainViewController.h
//  LineSDKTest
//
//  Created by HongQuan on 2016/05/15.
//  Copyright © 2016年 Line corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelAPPTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelCurrentLocation;

@property (weak, nonatomic) IBOutlet UIButton *buttonStartSafeMode;
@property (weak, nonatomic) IBOutlet UIButton *buttonDialEmergencyCall;
@property (weak, nonatomic) IBOutlet UIButton *buttonRecordVoice;
@property (weak, nonatomic) IBOutlet UIButton *buttonRecordPathway;
@property (weak, nonatomic) IBOutlet UIButton *buttonSendLINEMsg;
@property (weak, nonatomic) IBOutlet UIButton *buttonSetting;
@property (weak, nonatomic) IBOutlet UIButton *buttonGuide;
@property (weak, nonatomic) IBOutlet UIButton *buttonUpdateLocation;

@property (weak, nonatomic) IBOutlet UIButton *buttonDispDebug;
@end
