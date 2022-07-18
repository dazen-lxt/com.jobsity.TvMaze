//
//  LoginViewController.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import UIKit
import LocalAuthentication
import AlertToast

class LoginViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var fingerButton: UIButton!
    
    private var textFields: [UITextField] = []
    private var totalDigits: Int = 4
    private let codeSavedKey = "codeSavedKey"
    private var codeSaved: String {
        return UserDefaults.standard.string(forKey: codeSavedKey) ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createInputs()
    }

    private func createInputs() {
        for _ in 0..<totalDigits {
            let textField = UITextField(
                frame: CGRect(x: 0, y: 0, width: 100, height: stackView.frame.height)
            )
            textField.borderStyle = .roundedRect
            textField.font = UIFont(name: codeTextField.font!.fontName, size: 36.0)
            textField.textAlignment = .center
            stackView.addArrangedSubview(textField)
            let constraint = NSLayoutConstraint(item: stackView ?? UIView(), attribute: .height, relatedBy: .equal, toItem: textField, attribute: .height, multiplier: 1, constant: 0)
            stackView.addConstraint(constraint)
            textFields.append(textField)
        }
        codeTextField.delegate = self
        if codeSaved.isEmpty {
            startButton.setTitle("Register Code", for: .normal)
        }
    }
    
    private func getCodeString() -> String {
        let code = textFields.reduce("", {$0 + $1.text!})
        return code
    }
    
    private func setupBiometric() {
        var requestBiometric = true
        if #available(iOS 11.0, *) {
            var error: NSError?
            BiometricIDAuth().context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
            if error?.code == LAError.biometryNotAvailable.rawValue {
                requestBiometric = false
            }
        } else {
            requestBiometric = BiometricIDAuth().canEvaluatePolicy()
        }
        fingerButton.isHidden = requestBiometric
        if UIDevice().faceID {
            fingerButton.setTitle("Start with FaceID", for: .normal)
        } else {
            fingerButton.setTitle("Start with TouchID", for: .normal)
        }
        
    }
    
    private func continueToMain() {
        let mainTabViewController = MainTabViewController()
        mainTabViewController.setupViewControllers()
        let window = view.window
        window?.rootViewController = mainTabViewController
        window?.makeKeyAndVisible()
    }
    
    private func showError(error: String) {
        let alertContoller = UIAlertController (
            title: "Error",
            message: error,
            preferredStyle: .alert
        )
        alertContoller.addAction(
            UIAlertAction(
                title: "Ok",
                style: .default,
                handler: nil
            )
        )
        present(alertContoller, animated: true)
    }

    @IBAction func startCodeTyping(_ sender: Any) {
        codeTextField.becomeFirstResponder()
    }
    
    @IBAction func checkDigits(_ sender: Any) {
        if codeSaved.isEmpty {
            UserDefaults.standard.set(getCodeString(), forKey: codeSavedKey)
        } else {
            if codeSaved != getCodeString() {
                showError(error: "The code is not correct")
                return
            }
        }
        continueToMain()
    }
    
    @IBAction func checkBiometric(_ sender: Any) {
        let hasBiometric = BiometricIDAuth().canEvaluatePolicy()
        if #available(iOS 11.0, *) {
            var error: NSError?
            BiometricIDAuth().context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
            if error?.code == LAError.biometryLockout.rawValue {
                showError(error: "Biometric locked")
                return
            }
            if error?.code == LAError.biometryNotEnrolled.rawValue {
                showError(error: "Biometric not enrolled")
                return
            }
        }
        if hasBiometric {
            BiometricIDAuth().evaluatePolicy { [weak self] in
                DispatchQueue.main.sync {
                    self?.continueToMain()
                }
            }
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location < totalDigits {
            textFields[range.location].text = string
            let isCompleted = getCodeString().count == 4
            startButton.isEnabled = isCompleted
            startButton.alpha = isCompleted ? 1.0 : 0.5
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
