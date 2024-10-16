//
//  LoginManger.h
//  Ust_TestDemo
//
//  Created by Athira Thilakan on 15/10/24.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginManger : NSObject

+ (instancetype)sharedInstance;
- (void)loginWithToken:(void (^)(NSString *token, NSError *error))completion;
- (NSString *)savedToken;
- (void)logoutFromAccount;
- (void)loginSlientWithCompletion:(void (^)(BOOL success, NSError *error))completion;
-(BOOL)isTokenCached;


- (void)loginGoogle:(UIViewController *)vc completion:(void(^)(BOOL success))completion;
- (void)performSilentLogin:(void(^)(BOOL success))completion;
- (BOOL)isUserLoggedIn;

@end

NS_ASSUME_NONNULL_END
