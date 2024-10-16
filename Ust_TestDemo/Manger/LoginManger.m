//
//  LoginManger.m
//  Ust_TestDemo
//
//  Created by Athira Thilakan on 15/10/24.
//

#import "LoginManger.h"
#import <GoogleSignIn/GoogleSignIn.h>
@implementation LoginManger


+ (instancetype)sharedInstance {
    static LoginManger *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (NSString *)savedToken {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"OAuthToken"];
}

- (BOOL)isTokenCached {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"OAuthToken"];
    return (token != nil);
}


- (void)logout {
    [[GIDSignIn sharedInstance] signOut];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userToken"];
}

- (void)performSilentLogin:(void (^)(BOOL success, NSError *error))completion {
    NSString *token = [self savedToken];
    if (token) {
        if ([self isNetworkReachable]) {
                
            [[GIDSignIn sharedInstance] restorePreviousSignInWithCompletion:^(GIDGoogleUser *user, NSError *error) {
                       if (error) {
                           NSLog(@"Error restoring sign-in: %@", error.localizedDescription);
                           [self logout];
                           completion(NO,error);
                           return;
                       }
                       completion(YES,error);
                   }];
            
            
               } else {
                   [self logout];
                   NSError *error = [NSError errorWithDomain:@"NetworkError" code:500 userInfo:@{NSLocalizedDescriptionKey: @"Network not reachable."}];
                   completion(NO, error);
               }
    } else {
        [self logout];
        completion(NO, [NSError errorWithDomain:@"LoginManager" code:500 userInfo:@{NSLocalizedDescriptionKey: @"No cached token found."}]);
    }
}

- (BOOL)isNetworkReachable {
    return YES;  // Assume network is available
}



- (void)loginGoogle:(UIViewController *)vc completion:(void(^)(BOOL success))completion {
    
    [[GIDSignIn sharedInstance] signInWithPresentingViewController:vc completion:^(GIDSignInResult * _Nullable signInResult, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error signing in: %@", error.localizedDescription);
            completion(NO);
            return;
        }
        GIDToken *gidtoken = signInResult.user.accessToken;
        NSString *token = gidtoken.tokenString;
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"OAuthToken"];
        completion(YES);
        
    }];
           
           
}
    

@end
