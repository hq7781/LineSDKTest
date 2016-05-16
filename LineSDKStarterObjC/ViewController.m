//
//  ViewController.m
//  LineSDKStarterObjC
//
//  Copyright (c) 2015 Line corp. All rights reserved.
//

#import "ViewController.h"
#import <LineAdapter/LineAdapter.h>
#import <LineAdapterUI/LineAdapterUI.h>

@interface ViewController ()

@end

@implementation ViewController {
    LineAdapter *adapter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    adapter = [LineAdapter adapterWithConfigFile];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authorizationDidChange:) name:LineAdapterAuthorizationDidChangeNotification object:nil];

    _loginStatus.hidden = YES;
    //[self updateStatus];
}

- (IBAction)loginWithLine:(id)sender {
    if (adapter.isAuthorized) {
        [self alert:NSLocalizedString( @"Already authorized", null) message:nil];
        return;
    }

    if (!adapter.canAuthorizeUsingLineApp) {
        [self alert:NSLocalizedString( @"LINE is not installed", null) message:nil];
        return;
    }

    [adapter authorize];
    //    [self updateStatus];

}

- (IBAction)loginInApp:(id)sender {
    if (adapter.isAuthorized) {
        [self alert:NSLocalizedString( @"Already authorized", null ) message:nil];
        return;
    }
    LineAdapterWebViewController *viewController = [[LineAdapterWebViewController alloc] initWithAdapter:adapter withWebViewOrientation:kOrientationAll];
    viewController.navigationItem.leftBarButtonItem = [LineAdapterNavigationController barButtonItemWithTitle:NSLocalizedString(@"Cancel",null) target:self action:@selector(cancel:)];
    LineAdapterNavigationController *navigationController = [[LineAdapterNavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigationController animated:YES completion:nil];

//    [self updateStatus];
}

- (IBAction)tryApi:(id)sender {
    if (!adapter.isAuthorized) {
        [self alert:NSLocalizedString(@"Login first!",null) message:nil];
        return;
    }

    [adapter.getLineApiClient getMyProfileWithResultBlock:^(NSDictionary *aResult, NSError *aError) {
        if (aError) {
            [self alert:NSLocalizedString(@"Error occured!",null) message: aError.localizedDescription];
            return;
        }

        NSString *displayName = aResult[@"displayName"];
        [self alert:[NSString stringWithFormat:NSLocalizedString(@"Your name is %@",null), displayName] message:nil];
    }];
}

- (IBAction)getProfileApi:(id)sender {
    if (!adapter.isAuthorized) {
        [self alert:NSLocalizedString(@"Login first!",null) message:nil];
        return;
    }

    [adapter.getLineApiClient getMyProfileWithResultBlock:^(NSDictionary *aResult, NSError *aError) {
        if (aError) {
            [self alert:NSLocalizedString(@"Error occured!",null) message: aError.localizedDescription];
            return;
        }
        if (aResult)
        {   // API call successed.
            NSString *displayName = aResult[@"displayName"];
            NSString *id          = aResult[@"id"];
            NSString *mid         = aResult[@"mid"];
            //NSString *pictureUrl  = aResult[@"pictureUrl"];
            //NSString *profileImageUrl = aResult[@"profileImageUrl"];
            NSString *statusMessage = aResult[@"statusMessage"];
            [self alert:[NSString stringWithFormat:
                     NSLocalizedString(@"Your's info name: %@ id: %@ mid: %@ statusMessage: %@",null),
                     displayName,id,mid,statusMessage ] message:nil];
        }
        else
        {   // API call failed.
            NSDictionary *userInfo = [aError userInfo];
            NSLog(@"statusCode : %@", userInfo[@"statusCode"]);
            NSLog(@"statusMessage : %@", userInfo[@"statusMessage"]);
            [self alert:[NSString stringWithFormat:
                         NSLocalizedString(@"Error statusCode: %@, statusMessage: %@",null),
                         userInfo[@"statusCode"],userInfo[@"statusMessage"] ] message:nil];
        }
    }];
}



#pragma mark - sendText
- (IBAction)sentText:(id)sender {
    if (!adapter.isAuthorized) {
        [self alert:NSLocalizedString(@"Login first!",null) message:nil];
        return;
    }
    
//  NSArray *mids = @[@"u167b8fda9b13eaa89f4574f94b252b7c"];
    NSArray *mids = @[@"uade2041e3680ab9b7bd49da3a0692dcc"];
    NSString *toChannel = @"1383378250";
    NSString *eventType = @"138311608800106203";
    NSDictionary *content = @{@"contentType" : @1, // NSNumberで格納される
                              @"toType"      : @1, // NSNumberで格納される
                              @"text"        : @"send text message"
                              };
    NSDictionary *push = nil;
    
    [adapter.getLineApiClient postEventTo: mids
                                toChannel:toChannel
                                eventType:eventType
                                  content:content
                                     push:push
                              resultBlock:^(NSDictionary *aResult, NSError *aError)
     {
         if (aResult) {
             // API call successed.
             NSString *version = aResult[@"version"];
             NSNumber *timestamp = aResult[@"timestamp"];
             NSString *messageId = aResult[@"messageId"];
             
             [self alert:[NSString stringWithFormat:
                          NSLocalizedString(@"Sent version: %@ timestamp: %@ messageId: %@",null),
                          version, timestamp, messageId ] message:nil];
         }
         else
         {   // API call failed.
             NSDictionary *userInfo = [aError userInfo];
             NSLog(@"statusCode : %@", userInfo[@"statusCode"]);
             NSLog(@"statusMessage : %@", userInfo[@"statusMessage"]);
             [self alert:@"Error occured!" message: aError.localizedDescription];
         }
     }];

}


#pragma mark - sendLinkMsg
- (IBAction)sendLinkMsg:(id)sender {
    if (!adapter.isAuthorized) {
        [self alert:NSLocalizedString(@"Login first!",null) message:nil];
        return;
    }
    
//    NSArray *mids = @[@"u167b8fda9b13eaa89f4574f94b252b7c"];
    NSArray *mids = @[@"uade2041e3680ab9b7bd49da3a0692dcc"];
    NSString *toChannel = @"1341301715";
    NSString *eventType = @"137299299800026303";
    NSDictionary *content = @{
              @"contentType" : @1, // NSNumberで格納される
              @"toType"      : @1, // NSNumberで格納される
              @"text"        : @"send text message"
              };
    NSDictionary *push = nil;
    
    [adapter.getLineApiClient postEventTo: mids
                                toChannel:toChannel
                                eventType:eventType
                                  content:content
                                     push:push
                              resultBlock:^(NSDictionary *aResult, NSError *aError)
    {
        if (aResult) {
            // API call successed.
            NSString *version = aResult[@"version"];
            NSNumber *timestamp = aResult[@"timestamp"];
            NSString *messageId = aResult[@"messageId"];

            [self alert:[NSString stringWithFormat:
                             NSLocalizedString(@"Sent version: %@ timestamp: %@ messageId: %@",null),
                             version, timestamp, messageId ] message:nil];
       }
        else
        {   // API call failed.
            NSDictionary *userInfo = [aError userInfo];
            NSLog(@"statusCode : %@", userInfo[@"statusCode"]);
            NSLog(@"statusMessage : %@", userInfo[@"statusMessage"]);
            [self alert:@"Error occured!" message: aError.localizedDescription];
        }
    }];

}
#pragma mark - sendLocation
- (IBAction)sendLocation:(id)sender {
    if (!adapter.isAuthorized) {
        [self alert:NSLocalizedString(@"Login first!",null) message:nil];
        return;
    }
    
 //   NSArray *mids = @[@"u167b8fda9b13eaa89f4574f94b252b7c"];
    NSArray *mids = @[@"uade2041e3680ab9b7bd49da3a0692dcc"];
    NSString *toChannel = @"1383378250";
    NSString *eventType = @"138311608800106203";
    NSDictionary *content = @{
                              @"contentType" : @7, // NSNumberで格納される
                              @"toType"      : @1, // NSNumberで格納される
                              @"text"        : @"send Location message",
                              @"location"    : @{
                                  @"title"      : @"Convention center",
                                  @"latitude"   : @35.61823286112982,
                                  @"longitude"  : @139.72824096679688
                              },
                              };
    NSDictionary *push = nil;
    
    [adapter.getLineApiClient postEventTo: mids
                                toChannel:toChannel
                                eventType:eventType
                                  content:content
                                     push:push
                              resultBlock:^(NSDictionary *aResult, NSError *aError)
     {
         if (aResult) {
             // API call successed.
             NSString *version = aResult[@"version"];
             NSNumber *timestamp = aResult[@"timestamp"];
             NSString *messageId = aResult[@"messageId"];
             
             [self alert:[NSString stringWithFormat:
                          NSLocalizedString(@"Sent version: %@ timestamp: %@ messageId: %@",null),
                          version, timestamp, messageId ] message:nil];
         }
         else
         {
             // API call failed.
             NSDictionary *userInfo = [aError userInfo];
             NSLog(@"statusCode : %@", userInfo[@"statusCode"]);
             NSLog(@"statusMessage : %@", userInfo[@"statusMessage"]);
             [self alert:@"Error occured!" message: aError.localizedDescription];
         }
     }];
    
}

#pragma mark - get AccessToken
- (IBAction)getAccessTokenApi:(id)sender {
    if (!adapter.isAuthorized) {
        [self alert:NSLocalizedString(@"Login first!",null) message:nil];
        return;
    }
    
    [adapter.getLineApiClient getMyProfileWithResultBlock:^(NSDictionary *aResult, NSError *aError) {
        if (aError) {
            [self alert:NSLocalizedString(@"Error occured!",null) message: aError.localizedDescription];
            return;
        }
        
        NSString *displayName = aResult[@"displayName"];
        NSString *id          = aResult[@"id"];
        NSString *mid         = aResult[@"mid"];
        //NSString *pictureUrl  = aResult[@"pictureUrl"];
        //NSString *profileImageUrl = aResult[@"profileImageUrl"];
        NSString *statusMessage = aResult[@"statusMessage"];
        
        [self alert:[NSString stringWithFormat:
                     @"Your's info name: %@, id: %@, mid: %@, statusMessage: %@",
                     displayName,id,mid,statusMessage ] message:nil];
    }];
}

#pragma mark - Logout
- (IBAction)logout:(id)sender {
    [adapter unauthorize];

//    [self updateStatus];
    [self alert:NSLocalizedString(@"Logged out",null) message:nil];
}

#pragma mark - alert
- (void)alert:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",null) otherButtonTitles:nil];
    [alert show];
}

- (void)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) updateStatus {
    if (adapter.isAuthorized) {
        _loginStatus.text = NSLocalizedString(@"Status is login",null);
        _buttonloginApp.hidden = YES;
        _buttonloginLine.hidden = YES;
        _buttonTryAPI.hidden = NO;
        _buttonProfileAPI.hidden = NO;
        _buttonLogout.hidden = NO;
    }
    else {
        _loginStatus.text = NSLocalizedString(@"Status is logout",null);
        _buttonloginApp.hidden = NO;
        _buttonloginLine.hidden = NO;
        _buttonTryAPI.hidden = YES;
        _buttonProfileAPI.hidden = YES;
        _buttonLogout.hidden = YES;
    }
}

#pragma mark - Handle Notification

- (void)authorizationDidChange:(NSNotification *)notification {
    LineAdapter *lineAdapter = notification.object;
    if (lineAdapter.isAuthorized) {
        [self alert:NSLocalizedString(@"Login success!",null) message:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }

    NSError *error = notification.userInfo[@"error"];
    if (error) {
        [self alert:NSLocalizedString(@"Login error!",null) message:error.localizedDescription];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
