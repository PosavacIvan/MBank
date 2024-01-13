//
//  ViewController.swift
//  Bankey
//
//  Created by Ivan Posavac on 01.12.2023..
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let heading1 = UILabel()
    let heading2 = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    //optional string ne vraca nil vrijednost nego prazan string
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        style()
        layout()
    }
}

extension LoginViewController {
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        heading1.translatesAutoresizingMaskIntoConstraints = false
        heading1.textAlignment = .center
        heading1.text = "Bankey"
        heading1.font = UIFont(name: "Arial", size: 32)
        
        heading2.translatesAutoresizingMaskIntoConstraints = false
        heading2.textAlignment = .center
        heading2.text = "Your premium source for all\nthings banking!"
        heading2.numberOfLines = 0
        heading2.font = UIFont(name: "Arial", size: 20)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8        //fot indicator spacing
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.text = "Error failure"
        errorMessageLabel.isHidden = true
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        view.addSubview(heading1)
        view.addSubview(heading2)
        
        //Heading1
        NSLayoutConstraint.activate([
            heading1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heading1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60.0)
        ])
        
        //Heading2
        NSLayoutConstraint.activate([
            heading2.centerXAnchor.constraint(equalToSystemSpacingAfter: heading1.centerXAnchor, multiplier: 1),
            heading2.topAnchor.constraint(equalToSystemSpacingBelow: heading1.bottomAnchor, multiplier: 6)
        ])
        
        // LoginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        //Button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        //ERROR Label
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
    }
}

//MARK: Actions
extension LoginViewController {
    @objc func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        //optional string unwrappa o sprema u varijablu username
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
        }
        
        if username == "" && password == "" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    //Unutar withMessage argumenta se nalazi teks koji se mora ispisati taj tekst se u ovoj funkciji sprema u varijablu message da se kasnije moze koristiti
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}

