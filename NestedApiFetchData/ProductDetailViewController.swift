//
//  ProductDetailViewController.swift
//  NestedApiFetchData
//
//  Created by Mac on 29/12/23.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var imageViewLabel: UIImageView!
    @IBOutlet weak var catagoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var countlLabel: UILabel!
    var productDetailsContainer : Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagebinding()
        bindData()

      
    }
    
    func imagebinding(){
        if let image = productDetailsContainer?.image,
           let imageUrl = URL(string: image)
        {
            imageViewLabel.kf.setImage(with: imageUrl)
        }
    }
    
    func bindData(){
        self.catagoryLabel.text = productDetailsContainer?.category
        self.titleLabel.text = productDetailsContainer?.title
        self.descriptionLabel.text = productDetailsContainer?.desciption
        self.priceLabel.text = productDetailsContainer?.price.description.codingKey.stringValue
        self.rateLabel.text = productDetailsContainer?.rating.rate.description.codingKey.stringValue
        self.countlLabel.text = productDetailsContainer?.rating.count.description.codingKey.stringValue
    }
    
}
