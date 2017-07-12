//
//  MainVC.swift
//  Tailored
//
//  Created by Daniel Lee on 8/2/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UIScrollViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)

        
        let splash = LaunchVC()
        splash.modalPresentationStyle = .overCurrentContext
        splash.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.present(splash, animated: false, completion: nil)
        
        logoView = LogoView(frame: tailorLogoSz)
        logoView.setUpImg()
        self.navigationItem.titleView = logoView
        
        productSV.delegate = self
        manuallyAddData()
        addScrollView(productArray: jewelryOptions)
        createButtons()
        setupNavBtn()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        jewelryOptionsFav = self.jewelryOptions.filter{$0.favorite == true}

    }


    
    //----------------------------------------------------------
    // VARIABLES
    //----------------------------------------------------------
    
    //MARK:  Variables Data
    var jewelryOptions = [Product]()
    var jewelryOptionsFav: [Product]?
    
    
    //MARK:  Variables NavigationBar Logo
    var logoView: LogoView!
    let tailorLogoSz = CGRect(x: 0,
                              y: 0,
                              width: 100,
                              height: 42)
    let navBtn = NavButton()
    let social = SocialMediaButtons()
    
    //MARK:  ScrollView Variables
    var productSVView: UIView?
    var productSV = ProductScrollView()
    var productSVFrame: CGRect?
    var svWidth = UIScreen.main.bounds.width
    var svHeight = UIScreen.main.bounds.height
    var svSizer: CGFloat = 0.85
    let scrollTapGesture = UITapGestureRecognizer()
    var isFullSelection = true
    
    //MARK:  Selected Product View Controller
    let productDetail = ProductVC()
    
    //----------------------------------------------------------
    // FUNCTIONS
    //----------------------------------------------------------
    
    //MARK:  Social Media Buttons
    func createButtons(){
        
        social.generateButtons()
        
        for x in 0..<social.socialButtons.count{
            let createdButton = social.socialButtons[x]
            let distance = (social.buttonSize.width + social.buttonSpacingX) * CGFloat(x)
            let positionX = (self.view.frame.width - ((social.buttonSize.width * 5) + (social.buttonSpacingX * (5 - 1))))/2
            let positionY = self.view.frame.height-social.buttonSize.height - 20 - 44 - social.buttonSpacingY
            
            createdButton.frame = CGRect(origin:CGPoint(
                                        x: positionX + distance,
                                        y: positionY),
                                        size: social.buttonSize)
            
            self.view.addSubview(createdButton)
            
        }
    }
    
    //MARK:  ScrollView
    func addScrollView(productArray: [Product]){
        
        productSVView = UIView()
        productSVFrame = CGRect(x: -(UIScreen.main.bounds.width * svSizer),
                                y: 0,
                                width: (UIScreen.main.bounds.width * svSizer),
                                height: UIScreen.main.bounds.height-44-20-30)
        
        productSVView?.frame = productSVFrame!
        productSVView?.backgroundColor = .clear
        
        
        productSVView?.addSubview(productSV)
        productSV.manuallyAddViews(productSeries: productArray)
        productSV.setUpScrollView(productSV.productImages)
        
        //Add segue action
        scrollTapGesture.addTarget(self, action: #selector(MainVC.productSelected))
        productSV.addGestureRecognizer(scrollTapGesture)
        
        self.view.addSubview(productSVView!)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.productSVView?.frame = CGRect(x: (UIScreen.main.bounds.width * (1-self.svSizer))/2,
                                               y: 0,
                                               width: (self.productSVView?.frame.width)!,
                                               height: (self.productSVView?.frame.height)!)
        }, completion: nil)
    }
    
    func refreshScrollView(productSVView: UIView, productSV: ProductScrollView, productArray: [Product]){
        
        UIView.animate(withDuration: 0.2, animations: {
            
            productSVView.alpha = 0
            
        }) { _ in
            productSVView.removeFromSuperview()
            productSV.removeFromSuperview()
            productSV.subviews.forEach({$0.removeFromSuperview()})
            self.addScrollView(productArray: productArray)
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        productSV.pageCurrentPage()
        productSV.viewCurrentView(pageNum: productSV.currentPage)
    }
    
    //MARK:  Set Up Menu Buttons
    func setupNavBtn(){
        
        var emptyBtn: UIBarButtonItem?
        
        emptyBtn = navBtn.setUpBarBtn(item: navBtn.bag2, currentVC: self)
        self.navigationItem.rightBarButtonItem = emptyBtn
        
        emptyBtn = navBtn.setUpBarBtn(item: navBtn.menu2, currentVC: self)
        self.navigationItem.leftBarButtonItem = emptyBtn
    }
    
    //MARK:  Action for selecting Product
    func productSelected(){
        if isFullSelection {
            productDetail.selectedProduct = jewelryOptions[productSV.currentPage]
        } else {
            productDetail.selectedProduct = jewelryOptionsFav?[productSV.currentPage]
        }
        
        productDetail.jewelryOptions = self.jewelryOptions
        
        self.navigationController?.pushViewController(productDetail, animated: true)
        productDetail.tempImg = jewelryOptions.count - 1

        navBtn.menuClass.dismissMenu()
    }
    
    //MARK:  Manually Populate Date
    func manuallyAddData(){
        let product1 = Product(name: "Jewelry Piece Number 1",
                               designer: "Product Designer",
                               photoName: "sample",
                               photoName1: "feature",
                               photoName2: "feature",
                               photoName3: "feature",
                               photoName4: "feature",
                               photoName5: "feature",
                               price: 10000,
                               quantity: 1,
                               carat: "1",
                               cut: "brilliant",
                               color: "D",
                               clarity: "VVS1",
                               stone: "Diamond",
                               metal: "Gold",
                               size: "N/A",
                               description: "Description of piece goes here",
                               favorite: false,
                               addedToCart: false)
        
        let product2 = Product(name: "Jewelry Piece Number 2",
                               designer: "Product Designer",
                               photoName: "sample",
                               photoName1: "feature",
                               photoName2: "feature",
                               photoName3: "feature",
                               photoName4: "feature",
                               photoName5: "feature",
                               price: 10000,
                               quantity: 1,
                               carat: "1",
                               cut: "brilliant",
                               color: "D",
                               clarity: "VVS1",
                               stone: "Diamond",
                               metal: "Gold",
                               size: "N/A",
                               description: "Description of piece goes here",
                               favorite: false,
                               addedToCart: false)
        
        let product3 = Product(name: "Jewelry Piece Number 3",
                               designer: "Product Designer",
                               photoName: "sample",
                               photoName1: "feature",
                               photoName2: "feature",
                               photoName3: "feature",
                               photoName4: "feature",
                               photoName5: "feature",
                               price: 10000,
                               quantity: 1,
                               carat: "1",
                               cut: "brilliant",
                               color: "D",
                               clarity: "VVS1",
                               stone: "Diamond",
                               metal: "Gold",
                               size: "N/A",
                               description: "Description of piece goes here",
                               favorite: false,
                               addedToCart: false)
        
        let product4 = Product(name: "Jewelry Piece Number 4",
                               designer: "Product Designer",
                               photoName: "sample",
                               photoName1: "feature",
                               photoName2: "feature",
                               photoName3: "feature",
                               photoName4: "feature",
                               photoName5: "feature",
                               price: 10000,
                               quantity: 1,
                               carat: "1",
                               cut: "brilliant",
                               color: "D",
                               clarity: "VVS1",
                               stone: "Diamond",
                               metal: "Gold",
                               size: "N/A",
                               description: "Description of piece goes here",
                               favorite: false,
                               addedToCart: false)
        
        let product5 = Product(name: "Jewelry Piece Number 5",
                               designer: "Product Designer",
                               photoName: "sample",
                               photoName1: "sample1",
                               photoName2: "sample2",
                               photoName3: "sample3",
                               photoName4: "feature",
                               photoName5: "feature",
                               price: 10000,
                               quantity: 1,
                               carat: "1",
                               cut: "brilliant",
                               color: "D",
                               clarity: "VVS1",
                               stone: "Diamond",
                               metal: "Gold",
                               size: "N/A",
                               description: "Description of piece goes here",
                               favorite: false,
                               addedToCart: false)
        
        jewelryOptions += [product1, product2, product3, product4, product5]
    }
}

