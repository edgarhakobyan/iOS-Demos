//
//  LoginViewController.swift
//  Networking
//
//  Created by Edgar on 01.05.21.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

class LoginViewController: UIViewController {
    var userProfile: UserProfile?
    
    lazy var fbLoginButton: UIButton = {
        let loginButton = FBLoginButton()
        loginButton.frame = CGRect(x: 32, y: 360, width: view.frame.width - 64, height: 50)
        loginButton.delegate = self
        return loginButton
    }()
    
    lazy var fbCustomLoginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.backgroundColor = UIColor(hexValue: "#3B5999", alpha: 1)
        loginButton.setTitle("Login with Facebook", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.frame = CGRect(x: 32, y: 360 + 80, width: view.frame.width - 64, height: 50)
        loginButton.layer.cornerRadius = 4
        loginButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
        return loginButton
    }()
    
    lazy var googleLoginButton: GIDSignInButton = {
        let loginButton = GIDSignInButton()
        loginButton.frame = CGRect(x: 32, y: 360 + 80 + 80, width: view.frame.width - 64, height: 50)
        return loginButton
    }()
    
    lazy var customGoogleLoginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.frame = CGRect(x: 32, y: 360 + 80 + 80 + 80, width: view.frame.width - 64, height: 50)
        loginButton.backgroundColor = .white
        loginButton.setTitle("Login with Google", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.setTitleColor(.gray, for: .normal)
        loginButton.layer.cornerRadius = 4
        loginButton.addTarget(self, action: #selector(handleCustomGoogleLogin), for: .touchUpInside)
        return loginButton
    }()
    
    lazy var signInWithEmail: UIButton = {
        let loginButton = UIButton()
        loginButton.frame = CGRect(x: 32, y: 360 + 80 + 80 + 80 + 80, width: view.frame.width - 64, height: 50)
        loginButton.setTitle("Sign In with Email", for: .normal)
        loginButton.addTarget(self, action: #selector(openSignInVC), for: .touchUpInside)
        return loginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        view.addVerticalGradientLayer(topColor: UIColor.primaryColor, bottomColor: UIColor.secondaryColor)
        
        setupViews()
        
        if let token = AccessToken.current,!token.isExpired {
            print("The user is logged in")
        }
    }
    
    @objc private func openSignInVC() {
        performSegue(withIdentifier: "SignIn", sender: self)
    }
    
    private func setupViews() {
        view.addSubview(fbLoginButton)
        view.addSubview(fbCustomLoginButton)
        view.addSubview(googleLoginButton)
        view.addSubview(customGoogleLoginButton)
        view.addSubview(signInWithEmail)
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error)
            return
        }
        print("Successfully logged in with Facebook")
        signinToFirebase()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Successfully logged out of Facebook")
    }
    
    @objc private func handleCustomFBLogin() {
        LoginManager().logIn(permissions: ["email", "public_profile"], from: self) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let result = result else { return }
            
            if result.isCancelled {
                return
            } else {
                self.signinToFirebase()
            }
        }
    }
    
    private func openMainViewController() {
        dismiss(animated: true)
    }
    
    private func signinToFirebase() {
        let accessToken = AccessToken.current
        guard let accessTokenString = accessToken?.tokenString else { return }
        let gradientals = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: gradientals) { (result, error) in
            if let error = error {
                print("Something went wrong with FB user \(error)")
            }
            print("Successfully logged in with FB user \(String(describing: result))")
            self.fetchFacebookFields()
        }
    }
    
    private func fetchFacebookFields() {
        GraphRequest(graphPath: "me", parameters: ["fields": "email, name"]).start { (_, result, error) in
            if let error = error {
                print("Error \(error)")
                return
            }
            if let userData = result as? [String: Any] {
                self.userProfile = UserProfile(data: userData)
                self.saveIntoFirebase()
            }
        }
    }
    
    private func saveIntoFirebase() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["name": userProfile?.name, "email": userProfile?.email]
        let values = [uid: userData]
        Database.database().reference().child("users").updateChildValues(values) { (error, _) in
            if let error = error {
                print(error)
                return
            }
            print("Successfully saved user into firebase database")
            self.openMainViewController()
        }
    }
}

// MARK: - Google SDK

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Failed to signin with Google \(error)")
            return
        }
        
        print("Succesfully logged into the Google")
        
        if let userName = user.profile.name, let userEmail = user.profile.email {
            let userData = ["name": userName, "email": userEmail]
            userProfile = UserProfile(data: userData)
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                print("Something went wrong with Google user \(error)")
                return
            }
            
            print("Successfully logged into Firabase with Google")
            self.saveIntoFirebase()
        }
    }
    
    @objc private func handleCustomGoogleLogin() {
        GIDSignIn.sharedInstance()?.signIn()
    }
}
