//
//  SD2UserDetailVC.swift
//  Assignment
//
//  Created by Sushobhit_BuiltByBlank on 9/25/17.
//  Copyright © 2017 Sushobhit Jain. All rights reserved.
//

import UIKit
import AlamofireImage

class SD2UserDetailVC: UIViewController {

    @IBOutlet weak var userImgV: UIImageView!
    @IBOutlet weak var userNameL: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    let itemCellIdentifier = "itemCell"
    var user:User?
    var items:Array<String>?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = self.user else {
            return
        }
        self.items = user.items
        guard let imageUrl =  URL(string: user.image!) else
        {
            return
        }
        self.userImgV.af_setImage(withURL:imageUrl, placeholderImage: UIImage(named: "placeholderImage"), filter: nil, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion:nil)
        self.userNameL.text = user.name
        self.userImgV.layer.cornerRadius = self.userImgV.bounds.height/2
        self.userImgV.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SD2UserDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    // MARK: - COLLECTION VIEW DATASOURCE METHODS
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = self.items else {
            return 1
        }
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.itemCellIdentifier, for: indexPath) as! ItemsColletctionVCell
        
        guard let urlString = self.items?[indexPath.row] else{
            return cell
        }
        guard  let imageUrl = URL(string: urlString) else {
            return cell
        }
        
        // Start the UIActivityIndicatorView animating
        cell.ai.startAnimating()
        cell.imageV.af_setImage(withURL:imageUrl, placeholderImage: UIImage(named: "placeholderImage"), filter: nil, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion: { response in
            cell.imageV.image = response.result.value
            // Stop the UIActivityIndicatorView animating
            cell.ai.stopAnimating()
            cell.ai.removeFromSuperview()
        })
        return cell
    }
    
    //MARK: - COLLECTION VIEW FlowLayout MEHTODS
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Compute the dimension of a cell for an NxN layout with space S between
        // cells.  Take the collection view's width, subtract (N-1)*S points for
        // the spaces between the cells, and then divide by N to find the final
        // dimension for the cell's width and height.
        var dim:CGFloat = 0
        guard let itemslist = self.items else{
            return CGSize(width: dim, height:dim)
        }
        let count:Int = itemslist.count
        if count % 2 == 0
        {
            dim = collectionView.bounds.width/2 - 4
        }
        else{
            dim = indexPath.row == 0 ? collectionView.bounds.width : collectionView.bounds.width/2 - 4
        }
        return CGSize(width: dim, height: dim)
    }
}
