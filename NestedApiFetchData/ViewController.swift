//
//  ViewController.swift
//  NestedApiFetchData
//
//  Created by Mac on 29/12/23.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    var productDetailViewController : ProductDetailViewController?
    let productTableViewCellIdentifier = "ProductTableViewCell"
    
    @IBOutlet weak var productTableView: UITableView!
    var product : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilizeTableView()
        registerXibWithTableView()
        apiDataFetch()
        
    }
    func initilizeTableView(){
        productTableView.delegate = self
        productTableView.dataSource = self
    }
    
    func registerXibWithTableView(){
        let uinib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        self.productTableView.register(uinib, forCellReuseIdentifier: productTableViewCellIdentifier)
    }
    
    func apiDataFetch(){
        let url = URL(string: "https://fakestoreapi.com/products")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "GET"
        
        let urlSession = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: urlRequest){
            data, response, error in
            print(data)
            
            let urlResponse = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            
            for eachResponse in urlResponse {
                let productDictionary = eachResponse as! [String:Any]
                let productId = productDictionary["id"] as! Int
                let producttitle = productDictionary["title"] as! String
                let productPrice = productDictionary["price"] as! Double
                let productDescription = productDictionary["description"] as! String
                let productCatagory = productDictionary["category"] as! String
                let productImage = productDictionary["image"] as! String
                
                let ProductRating = productDictionary["rating"] as! [String:Any]
                let productRate = ProductRating["rate"] as! Double
                let productCount = ProductRating["count"] as! Int
                let newRating = Rating(rate: productRate, count: productCount)
                
                let object = Product(id: productId, title: producttitle, price: productPrice, desciption: productDescription, category: productCatagory, image: productImage, rating: newRating)
                
                self.product.append(object)
            }
            DispatchQueue.main.async {
                self.productTableView.reloadData()
            }
        }
        dataTask.resume()
    }


}

extension ViewController : UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        product.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        self.navigationController?.pushViewController(productDetailViewController!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150.0
    }
}

extension ViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ProductTableViewCell = self.productTableView.dequeueReusableCell(withIdentifier: productTableViewCellIdentifier, for: indexPath) as! ProductTableViewCell
        
        ProductTableViewCell.catagoryLabel.text = (product[indexPath.row].category)
        ProductTableViewCell.countLabel.text = String(product[indexPath.row].rating.count)
        ProductTableViewCell.rateLabel.text = String(product[indexPath.row].rating.rate)
        ProductTableViewCell.imageViewLabel.kf.setImage(with: URL(string: product[indexPath.row].image))
        return ProductTableViewCell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        product.count
    }
   
}

