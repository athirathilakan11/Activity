//
//  LoginVCViewController.swift
//  Ust_TestDemo
//
//  Created by Athira Thilakan on 15/10/24.
//

import UIKit
import GoogleSignIn
class LoginVCViewController: UIViewController {

    @IBOutlet weak var lblStatus: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    @IBAction func btnloginTapped(_ sender: Any) {
        
//        LoginManger.sharedInstance().login { token, errorReturn in
//            if errorReturn != nil {
//                                            self.lblStatus.text = "Login failed: \(errorReturn.localizedDescription)"
//                                        } else {
//                                            self.lblStatus.text = "Logged in successfully!"
//                                            self.navigateToDiscoveryVc()
//            }
//        }
        
        LoginManger.sharedInstance().loginGoogle(self, completion:{ status in
            if status
            {
                self.lblStatus.text = "Logged in successfully!"
                self.navigateToDiscoveryVc()
            }
            else
            {
                self.lblStatus.text = "Unable to Loggin!"
            }
        
        })
    }
    
    
    func navigateToDiscoveryVc()
    {
        
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let discoveryVC = storyboard.instantiateViewController(withIdentifier: "Discoveryy")
                self.navigationController?.pushViewController(discoveryVC, animated: true)
//
//        let vc = storyboard?.instantiateViewController(identifier: "Discoveryy") as! DiscoveryVc
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
      
          
    }
}
