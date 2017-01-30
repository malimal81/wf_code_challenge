//
//  ShopVC.swift
//  WF_Code_Challenge
//
//  Created by Jamal Jones on 9/23/16.
//  Copyright © 2016 Jamal Jones. All rights reserved.
//

import UIKit
import MIBadgeButton_Swift

class ShopVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var navigation: UINavigationItem!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var cartButton: UIBarButtonItem!
    
    var cartBarbuttonItem:MIBadgeButton!
    
    var cart:[Product] = [Product]()
    
    var productArray:[[Product]] = [[Product]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Make navigation bar white
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset = UIEdgeInsets.zero
        
        //touch status bar to scroll to top
        self.collectionView.scrollsToTop = true
        
        self.configureCart()
        
        self.loadProducts()
        
        self.collectionView.reloadData()
        
    }
    
    func addProductToCart(sender: AnyObject) {
        
        if cart.isEmpty {
            cart.append(productArray[sender.indexPath.section][sender.indexPath.row])
            return
        } else {
            let productID = productArray[sender.indexPath.section][sender.indexPath.row].id
            
            for item in cart {
                if productID == item.id {
                    return
                }
            }
        }
        
        cart.append(productArray[sender.indexPath.section][sender.indexPath.row])
        
        updateCartCount()
        
    }
    
    func configureCart() {
        
        let icon = UIImage(named: "cart")
        
        self.cartBarbuttonItem = MIBadgeButton(frame: CGRect(x:0, y: 0, width: 30, height: 30))
        self.cartBarbuttonItem.setImage(icon, for: .normal)
        
        let barButton : UIBarButtonItem = UIBarButtonItem(customView: self.cartBarbuttonItem)
        self.navigationItem.rightBarButtonItem = barButton
        
    
    }
    
    func updateCartCount() {
    
        if cart.count > 0 {
            //
            self.cartBarbuttonItem.badgeString = String(cart.count)
        }
    }
    
    func loadProducts() {
        
        let featuredProduct = Product(id: 0, title: "Featured Item: Magician Hat", price: 39.00, image: UIImage(named: "Big_Sale")!)
        
        let product1 = Product(id: 1, title: "Sneakers A", price: 49.95, image: UIImage(named: "Sneakers_A")!)
        let product2 = Product(id: 2, title: "Shoes B", price: 79.95, image: UIImage(named: "Shoes_B")!)
        let product3 = Product(id: 3, title: "Dress A", price: 99.00, image: UIImage(named: "Dress_A")!)
        let product4 = Product(id: 4, title: "Dress B", price: 89.00, image: UIImage(named: "Dress_B")!)
        
        var featuredArray = [Product]()
        var prodArray = [Product]()
        
        featuredArray.append(featuredProduct)
        
        prodArray.append(product1)
        prodArray.append(product2)
        prodArray.append(product3)
        prodArray.append(product4)
        
        self.productArray.append(featuredArray)
        self.productArray.append(prodArray)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath) as! FeaturedCell
            cell.configureCell(product: self.productArray[indexPath.section][indexPath.row])
        
            cell.addToCart.indexPath = indexPath
            cell.addToCart.addTarget(self, action: #selector(ShopVC.addProductToCart), for: .touchUpInside)
            
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            
            cell.configureCell(product: self.productArray[indexPath.section][indexPath.row])
            
            cell.addToCart.indexPath = indexPath
            cell.addToCart.addTarget(self, action: #selector(ShopVC.addProductToCart), for: .touchUpInside)
            
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.productArray[0].count
        } else {
            return self.productArray[1].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            //device screen size
            let width = UIScreen.main.bounds.size.width
            //calculation of cell size
            return CGSize(width: (width - 32)   , height: 186)
        } else {
            //device screen size
            let width = UIScreen.main.bounds.size.width
            //calculation of cell size
            return CGSize(width: ((width / 2) - 12)   , height: 192)
        
        }
        
        
    }
    
    @IBAction func back(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
