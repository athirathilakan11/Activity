//
//  SceneDelegate.swift
//  Ust_TestDemo
//
//  Created by Athira Thilakan on 15/10/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let _ = (scene as? UIWindowScene) else { return }
        self.goToWiseLoginFramework()

    }
    
    public func goToWiseLoginFramework() {
        
        LoginManger.sharedInstance().performSilentLogin { [self] status in
            if (status) {
                navigateToHome()
            } else {
                self.showLoginScreen()
            }
        }
    }
    func showLoginScreen()
    {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let logInViewController = storyboard.instantiateViewController(withIdentifier: "logInVC")
            let navc = UINavigationController.init(rootViewController: logInViewController)
            window?.makeKeyAndVisible()
            window?.rootViewController  = navc
    }
    func navigateToHome()
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let discoveryVC = storyboard.instantiateViewController(withIdentifier: "Discoveryy")
            let navc = UINavigationController.init(rootViewController: discoveryVC)
            window?.makeKeyAndVisible()
            window?.rootViewController  = navc
        }
   

    func sceneDidDisconnect(_ scene: UIScene) {
    
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    
    }

    func sceneWillResignActive(_ scene: UIScene) {
       
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

