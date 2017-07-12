//
//  BagVC.swift
//  Tailored
//
//  Created by Daniel Lee on 2/27/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit
import SwiftMailgun

class BagVC: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "ITEMS IN BAG"
        
        self.view.backgroundColor = UIColor.white
        mainView.setUpMainView(viewController: self)
        
        mainView.lastNameField.delegate = self
        mainView.firstNameField.delegate = self
        mainView.phoneField.delegate = self
        mainView.emailField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor(red: 0, green: 27/255, blue: 44/255, alpha: 1),
            NSFontAttributeName: UIFont(name: "futura", size: 20)!
        ]

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor(red: 0, green: 27/255, blue: 44/255, alpha: 1),
            NSFontAttributeName: UIFont(name: "futura", size: 15)!
        ]
    }
    
    let mainView = BagProductView()
    
    var selectedProducts = [Product](){
        didSet{
            mainView.selectedProducts = self.selectedProducts
        }
    }

    func userSubmitted(){
        let alert = UIAlertController(title: "Submitted!", message: "Thank you for your inquiry!  A representative will be in touch.", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Continue", style: .default, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
        
        sendCustomerInfo2()
    }
    
    //--------------------------------------------------------
    // TEXT FIELD DELEGATES, HANDLING OF KEYBOARD
    //--------------------------------------------------------

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == textField.placeholder {
            textField.text = nil
            textField.textColor = UIColor(white: 0.9, alpha: 1)
        }
        
        if textField.keyboardType == .numberPad {
            addDoneButton(textField: textField)
        }
        
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.isEmpty)! {
            textField.text = textField.placeholder
            textField.textColor = UIColor(white: 0.4, alpha: 1)
        }
        
        textField.text = textField.text?.uppercased()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        mainView.bagScrollView.contentOffset = CGPoint(x: 0, y: 0)
        return true
    }
    
    var keyboardHeight: CGFloat?
    
    func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height - mainView.offsetHeight!
            mainView.bagScrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight!)
        }
    }
    
    func addDoneButton(textField: UITextField){
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.hideKeyboard))
        
        let items = [flexSpace, doneBtn]
        toolBar.items = items
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar

    }
    
    func hideKeyboard(){
        self.view.endEditing(true)
        mainView.bagScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    //--------------------------------------------------------
    // MAIL GUN EXECUTION
    //--------------------------------------------------------
    
    func sendCustomerInfo2(){
        
        let message = "\(mainView.firstNameField.text!) || \(mainView.lastNameField.text!) || \(mainView.emailField.text!) || \(mainView.phoneField.text!)"
        
        let mailgun = MailgunAPI(apiKey: "key-43e144ef969f73cc4a00684a8f98e509", clientDomain: "sandbox231d142f61bd4b139239a5856c84f029.mailgun.org")
        mailgun.sendEmail(to: "dlee923@gmail.com", from: "test@test.com", subject: "Customer Inquiry", bodyHTML: message) { MailgunResult in
            
            if MailgunResult.success {
                print("success")
            }
            
        }
    }
    
//    func sendCustomerInfo(){
//        
//        let session = URLSession.shared
//        let request = NSMutableURLRequest(url: NSURL(string: "https://api.mailgun.net/v3/sandbox231d142f61bd4b139239a5856c84f029.mailgun.org")! as URL)
//        
//        request.httpMethod = "POST"
//        let credentials = "api:key-43e144ef969f73cc4a00684a8f98e509"
//        request.setValue("Basic \(credentials.toBase64())", forHTTPHeaderField: "Authorization")
//        
//        let data = "from: Swift Email <(dlee923@gmail.com)>&to: [dlee923@gmail.com,(dlee923@gmail.com)]&subject:Hello&text:Testing_some_Mailgun_awesomness"
//        request.httpBody = data.data(using: String.Encoding.ascii)
//        
//        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
//            if let error = error {
//                print(error)
//            }
//            if let response = response {
//                print("url = \(response.url!)")
//                print("response = \(response)")
//                let httpResponse = response as! HTTPURLResponse
//                print("response code = \(httpResponse.statusCode)")
//            }
//        })
//        task.resume()
//    }
    
}

//extension String {
//    
//    func fromBase64() -> String? {
//        guard let data = Data(base64Encoded: self) else {
//            return nil
//        }
//        
//        return String(data: data, encoding: .utf8)
//    }
//    
//    func toBase64() -> String {
//        return Data(self.utf8).base64EncodedString()
//    }
//}
