//
//  BagProductView.swift
//  Tailored
//
//  Created by Daniel Lee on 3/6/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class BagProductView: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    override init(){
        super.init()
        
        productView.delegate = self
        productView.dataSource = self
        productView.register(BagCell.self, forCellWithReuseIdentifier: "productCell")

    }
    
    var bagViewController: BagVC!
    var selectedProducts: [Product]? {
        didSet {
            productView.reloadData()
        }
    }
    let mainViewFactor: CGFloat = 0.98
    let bagScrollView = UIScrollView()
    var offsetHeight: CGFloat?
    
    let informationContainerView: UIView = {
        let xInformationContainerView = UIView()
        xInformationContainerView.backgroundColor = .black
        xInformationContainerView.layer.cornerRadius = 5
        return xInformationContainerView
    }()
    
    func setUpMainView(viewController: BagVC){
        bagViewController = viewController
        selectedProducts = viewController.selectedProducts
        informationContainerView.frame = CGRect(x: viewController.view.frame.width * ((1 - mainViewFactor)/2),
                                                y: (viewController.view.frame.height - 44 - 20) * ((1 - mainViewFactor)/2),
                                                width: viewController.view.frame.width * mainViewFactor,
                                                height: (viewController.view.frame.height - 44 - 20) * mainViewFactor)

        bagScrollView.frame = viewController.view.frame
        
        viewController.view.addSubview(bagScrollView)
        bagScrollView.addSubview(informationContainerView)
        
        productInBagView()
        customerInfo()
    }

    //--------------------------------------------------------
    // PRODUCT COLLECTION VIEW
    //--------------------------------------------------------
    
    let prodViewFactor: CGFloat = 0.97
    
    let productView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let productViewX = UICollectionView(frame: .zero, collectionViewLayout: flow)
        productViewX.backgroundColor = UIColor(white: 1, alpha: 0.1)
        return productViewX
    }()
    
    func productInBagView(){
        
        informationContainerView.addSubview(productView)
        productView.frame = CGRect(x: informationContainerView.frame.width * ((1 - prodViewFactor)/2), y: informationContainerView.frame.width * ((1 - prodViewFactor)/2), width: informationContainerView.frame.width * prodViewFactor, height: informationContainerView.frame.height * 0.35)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = selectedProducts?.count{
            return count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = CGSize(width: productView.bounds.width, height: productView.bounds.height/2.7)
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? BagCell {
            cell.productImage.image = UIImage(named: "\(selectedProducts![indexPath.item].photoName)")
            cell.label1.text = selectedProducts?[indexPath.item].name
            cell.label2.text = selectedProducts?[indexPath.item].designer
            cell.label3.text = String("\(selectedProducts![indexPath.item].price)")
            cell.setUpCartCell()
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //--------------------------------------------------------
    // INFORMATION INSERT
    //--------------------------------------------------------
    let lastNameField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "LAST NAME"
        textField.text = textField.placeholder
        textField.keyboardType = .default
        textField.returnKeyType = .done
        return textField
    }()
    let firstNameField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "FIRST NAME"
        textField.text = textField.placeholder
        textField.keyboardType = .default
        textField.returnKeyType = .done
        return textField
    }()
    let phoneField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "PHONE NUMBER"
        textField.text = textField.placeholder
        textField.keyboardType = .numberPad
        textField.returnKeyType = .continue
        return textField
    }()
    let emailField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "EMAIL ADDRESS"
        textField.text = textField.placeholder
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .done
        return textField
    }()
    
    let submitBtn: UIButton = {
        let button = UIButton()
        button.setTitle("SUBMIT INQUIRY", for: .normal)
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.yellow.cgColor
        button.setTitleColor(.yellow, for: .normal)
        button.titleLabel?.font = UIFont(name: "futura", size: 20)
        button.layer.cornerRadius = 8
        return button
    }()
    
    func customerInfo(){
        
        informationContainerView.addSubview(lastNameField)
        informationContainerView.addSubview(firstNameField)
        informationContainerView.addSubview(phoneField)
        informationContainerView.addSubview(emailField)
        informationContainerView.addSubview(submitBtn)
        submitBtn.addTarget(bagViewController, action: #selector(bagViewController.userSubmitted), for: .touchUpInside)
        
        let edgeSpace = informationContainerView.frame.width * ((1 - prodViewFactor)/2)
        let heightFactor: CGFloat = 0.125
        
        lastNameField.frame = CGRect(x: edgeSpace, y: productView.frame.origin.y + (edgeSpace * 2) + productView.frame.height, width: informationContainerView.frame.width * prodViewFactor, height: informationContainerView.frame.width * heightFactor)
        
        var frames = [CGRect]()
        
        for x in 1...3 {
            
            let frame = CGRect(x: edgeSpace, y: (lastNameField.frame.origin.y + (edgeSpace + edgeSpace + lastNameField.frame.height) * CGFloat(x)), width: lastNameField.frame.width, height: lastNameField.frame.height)
            frames.append(frame)
        }

        firstNameField.frame = frames[0]
        phoneField.frame = frames[1]
        emailField.frame = frames[2]
        
        submitBtn.centerXAnchor.constraint(equalTo: informationContainerView.centerXAnchor).isActive = true
        submitBtn.widthAnchor.constraint(equalToConstant: informationContainerView.frame.width * 0.75).isActive = true
        submitBtn.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 25).isActive = true
        submitBtn.bottomAnchor.constraint(equalTo: informationContainerView.bottomAnchor, constant: -25).isActive = true
        submitBtn.translatesAutoresizingMaskIntoConstraints = false
        
        offsetHeight = informationContainerView.frame.height - (emailField.frame.origin.y + emailField.frame.height)
    }
}

class CustomTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.borderStyle = .line
        self.layer.borderColor = UIColor(white: 0.4, alpha: 1).cgColor
        self.layer.borderWidth = 1
        self.font = UIFont(name: "futura", size: 13)
        self.textColor = UIColor(white: 0.4, alpha: 1)
        self.tintColor = .white
        self.layer.cornerRadius = 5
        self.autocorrectionType = .no
        self.keyboardAppearance = .dark
        self.clearButtonMode = .whileEditing
        self.textAlignment = .center
    }
    
}
