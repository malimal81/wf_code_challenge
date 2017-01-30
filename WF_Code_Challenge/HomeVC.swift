//
//  HomeVC.swift
//  WF_Code_Challenge
//
//  Created by Jamal Jones on 9/22/16.
//  Copyright © 2016 Jamal Jones. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var dot1: UIImageView!
    
    @IBOutlet weak var dot2: UIImageView!
    
    @IBOutlet weak var dot3: UIImageView!
    
    @IBOutlet weak var dot4: UIImageView!
    
    @IBOutlet weak var shopView: UIView!
    
    @IBOutlet weak var loyaltyLabel: UILabel!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var navigation: UINavigationItem!
    
    @IBOutlet var navicon: UIView!
    
    var imageArray = [UIImage]()
    
    var counter = 0
    
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //load rewards points
        rewardPointsManager.loadPoints {
            
            print("Points: \(rewardPointsManager.points)")
            //get main que
            DispatchQueue.main.sync {
                //convert points to NSNumber
                let pts = rewardPointsManager.points as NSNumber
                
                //format number with commas
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                //add points to label
                self.loyaltyLabel.text = numberFormatter.string(from: pts)
            }
            
            
        }
        
        //add logo to navigation bar
        let logo = UIImage(named: "Vogue_Store_Logo.png")
        let imageView = UIImageView(image:logo)
        imageView.frame = CGRect(x: 0, y: 0, width: 65, height: 30)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        //Make navigation bar white
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        

        //add shadow to circles
        self.dot1.layer.shadowColor = UIColor.gray.cgColor
        self.dot1.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.dot1.layer.shadowOpacity = 0.5
        self.dot1.layer.shadowRadius = 3
        
        self.dot2.layer.shadowColor = UIColor.gray.cgColor
        self.dot2.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.dot2.layer.shadowOpacity = 0.5
        self.dot2.layer.shadowRadius = 3
        
        self.dot3.layer.shadowColor = UIColor.gray.cgColor
        self.dot3.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.dot3.layer.shadowOpacity = 0.5
        self.dot3.layer.shadowRadius = 3
        
        self.dot4.layer.shadowColor = UIColor.gray.cgColor
        self.dot4.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.dot4.layer.shadowOpacity = 0.5
        self.dot4.layer.shadowRadius = 3
        
        //add images to array
        imageArray.append(UIImage(named: "Converse.png")!)
        imageArray.append(UIImage(named: "Heels.png")!)
        imageArray.append(UIImage(named: "Fashion_Show.png")!)
        imageArray.append(UIImage(named: "Personal_Shopper.png")!)
        
        //setup timer for animation
        timer = Timer.scheduledTimer(timeInterval: 4.5, target: self, selector: #selector(startAnimation), userInfo: nil, repeats: true)
        
        //gesture recognizer for shop view
        let shopTap = UITapGestureRecognizer(target: self, action: #selector(HomeVC.goToShop))
        shopTap.numberOfTapsRequired = 1
        self.shopView.isUserInteractionEnabled = true
        self.shopView.addGestureRecognizer(shopTap)
        
        
    }
    
    func goToShop() {
        self.performSegue(withIdentifier: "shop", sender: nil)
    }

    func startAnimation() {
        
        if counter < 3 {
            counter = counter + 1
        } else {
            counter = 0
        }
        
        self.mainImageView.image = self.imageArray[counter]
        self.switchDots()
    
    }
    
    func switchDots() {
    
        switch counter {
        case 0:
            self.dot1.image = UIImage(named: "ios7-circle-filled.png")
            self.dot2.image = UIImage(named: "ios7-circle-outline.png")
            self.dot3.image = UIImage(named: "ios7-circle-outline.png")
            self.dot4.image = UIImage(named: "ios7-circle-outline.png")
        case 1:
            self.dot1.image = UIImage(named: "ios7-circle-outline.png")
            self.dot2.image = UIImage(named: "ios7-circle-filled.png")
            self.dot3.image = UIImage(named: "ios7-circle-outline.png")
            self.dot4.image = UIImage(named: "ios7-circle-outline.png")
        case 2:
            self.dot1.image = UIImage(named: "ios7-circle-outline.png")
            self.dot2.image = UIImage(named: "ios7-circle-outline.png")
            self.dot3.image = UIImage(named: "ios7-circle-filled.png")
            self.dot4.image = UIImage(named: "ios7-circle-outline.png")
        case 3:
            self.dot1.image = UIImage(named: "ios7-circle-outline.png")
            self.dot2.image = UIImage(named: "ios7-circle-outline.png")
            self.dot3.image = UIImage(named: "ios7-circle-outline.png")
            self.dot4.image = UIImage(named: "ios7-circle-filled.png")
        default:
            break
        }
    }

}
