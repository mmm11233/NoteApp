//
//  ViewController.swift
//  NoteApp
//
//  Created by Mariam Joglidze on 05.11.23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let presentImage: UIImageView = {
        let imageName = "Rectangle 4"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let presentStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    let presentSecondStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private var emailTextField: UITextField?  = nil
    private var passwordTextField: UITextField? = nil
    
    let signInButton: UIButton =  {
        let button = UIButton()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPresentImage()
        setUpStackView()
        setUpSecondStackView()
        setupSignInhBtn()
        
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func signInButtonTapped() {
        if let email = emailTextField?.text, let password = passwordTextField?.text, !email.isEmpty, !password.isEmpty {
            let defaults = UserDefaults.standard
            
            if defaults.bool(forKey: email) == false {
                defaults.set(true, forKey: "\(email)")
                let welcomeAlert = UIAlertController(title: "Welcome!", message: "You're logging in for the first time. Welcome to our app!", preferredStyle: .alert)
                welcomeAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(welcomeAlert, animated: true, completion: nil)
            }
            
            _ = KeychainManager.saveUsernamePassword(username: email, password: password)
            
            if let savedPassword = KeychainManager.retrievePasswordForUsername(username: email) {
                if savedPassword == password {
                    let noteListViewController = NoteListViewController()
                    navigationController?.pushViewController(noteListViewController, animated: true)
                } else {
                    let alert = UIAlertController(title: "Error", message: "Email or Password is incorrect", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "User not found", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - Setup UI
    func setupPresentImage() {
        view.addSubview(presentImage)
        
        NSLayoutConstraint.activate([
            presentImage.topAnchor.constraint(equalTo: view.topAnchor),
            presentImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            presentImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            presentImage.heightAnchor.constraint(equalTo: presentImage.widthAnchor, multiplier: 1.0)
        ])
    }
    
    func setUpStackView() {
        presentStackView.axis = .vertical
        presentStackView.alignment = .center
        presentStackView.distribution = .equalSpacing
        presentStackView.spacing = 8
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "note")
        imageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        let label = UILabel()
        label.text = "Sign In"
        label.textColor = UIColor(hexString: "#5F5F5F")
        presentStackView.addArrangedSubview(imageView)
        presentStackView.addArrangedSubview(label)
        
        view.addSubview(presentStackView)
        
        presentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            presentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
        ])
    }
    
    func setUpSecondStackView() {
        presentSecondStackView.axis = .vertical
        presentSecondStackView.alignment = .center
        presentSecondStackView.distribution = .equalSpacing
        presentSecondStackView.spacing = 15
        
        let emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.backgroundColor = UIColor(hexString: "#F8F8F8")
        emailTextField.layer.cornerRadius = 16
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.emailTextField = emailTextField
        
        let emailLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: emailTextField.frame.size.height))
        let emailLabel = UILabel()
        emailLabel.text = "Email"
        emailLabel.frame = CGRect(x: 0, y: 0, width: 16, height: emailTextField.frame.size.height)
        emailLeftView.addSubview(emailLabel)
        emailTextField.leftView = emailLeftView
        emailTextField.leftViewMode = .always
        
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = UIColor(hexString: "#F8F8F8")
        passwordTextField.layer.cornerRadius = 16
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let passwordLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: passwordTextField.frame.size.height))
        let passwordLabel = UILabel()
        passwordLabel.text = "Password"
        passwordLabel.frame = CGRect(x: 0, y: 0, width: 16, height: passwordTextField.frame.size.height)
        passwordLeftView.addSubview(passwordLabel)
        passwordTextField.leftView = passwordLeftView
        passwordTextField.leftViewMode = .always
        self.passwordTextField = passwordTextField
        
        let forgotPasswordLabel = UILabel()
        forgotPasswordLabel.text = "Forgot Your Password?"
        forgotPasswordLabel.textColor = UIColor(hexString: "#5F5F5F")
        forgotPasswordLabel.font = UIFont.systemFont(ofSize: 14)
        forgotPasswordLabel.textAlignment = NSTextAlignment(.right)
        
        presentSecondStackView.addArrangedSubview(emailTextField)
        presentSecondStackView.addArrangedSubview(passwordTextField)
        presentSecondStackView.addArrangedSubview(forgotPasswordLabel)
        
        view.addSubview(presentSecondStackView)
        
        presentSecondStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            presentSecondStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentSecondStackView.topAnchor.constraint(equalTo: presentStackView.bottomAnchor, constant: 32),
            presentSecondStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 52),
            presentSecondStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -52),
            emailTextField.widthAnchor.constraint(equalToConstant: 289),
            emailTextField.heightAnchor.constraint(equalToConstant: 53),
            passwordTextField.widthAnchor.constraint(equalToConstant: 289),
            passwordTextField.heightAnchor.constraint(equalToConstant: 53)
        ])
    }
    
    func setupSignInhBtn() {
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.backgroundColor = UIColor(hexString: "#22577A")
        signInButton.layer.cornerRadius = 23
        view.addSubview(signInButton)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: presentSecondStackView.bottomAnchor, constant: 32),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.5),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50.5),
            signInButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
