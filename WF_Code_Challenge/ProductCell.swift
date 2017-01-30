//
//  ProductCell.swift
//  WF_Code_Challenge
//
//  Created by Jamal Jones on 9/23/16.
//  Copyright © 2016 Jamal Jones. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var addToCart: ProductButton!
    
    var product:Product!
    
    func configureCell(product:Product) {
        self.product = product
        self.productLabel.text = product.title
        
        //format price as currency
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let price = product.price as NSNumber
        self.priceLabel.text = formatter.string(from: price)
        
        self.productImageView.image = product.image
        
        //add border to image
        self.productImageView.layer.borderWidth = 0.4
        self.productImageView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
}
