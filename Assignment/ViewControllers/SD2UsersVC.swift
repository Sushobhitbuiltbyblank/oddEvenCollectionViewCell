//
//  SD2UsersVC.swift
//  Assignment
//
//  Created by Sushobhit Jain on 24/09/17.
//  Copyright © 2017 Sushobhit Jain. All rights reserved.
//

import UIKit
import SVProgressHUD
import AlamofireImage

class SD2UsersVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    let usersCellIdentifier = "userCell"
    var users:[User]?
    var hasMore:Bool?
    var offset = 0
    var limit = 15
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableData(offset: self.offset, limit: self.limit)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Call Web Services
    func loadTableData(offset:Int,limit:Int)
    {
        let parameter = ["offset":offset,"limit":limit]
        if Reachable.isConnectedToNetwork(){
            SVProgressHUD.show()
            SD2LabClient.sharedInstance().getUsers(parameter as [String : AnyObject]) { (response, error) in
                SVProgressHUD.dismiss()
                if self.users == nil
                {
                    guard let users = response?.1 else{
                        return
                    }
                    self.users = users
                }
                else{
                    guard let users = response?.1 else{
                        return
                    }
                    self.users? += users
                }
                self.hasMore = response?.0
                self.tableView.reloadData()
            }
        }
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

extension SD2UsersVC: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = users?.count {
            return count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: usersCellIdentifier, for: indexPath) as! UserTVCell
        guard let user = self.users?[indexPath.row] else{
            return cell
        }
        cell.nameL.text = user.name
        guard  let imageUrl =  URL(string: user.image!) else {
            return cell
        }
        cell.imageV.af_setImage(withURL:imageUrl, placeholderImage: UIImage(named: "placeholder"), filter: nil, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion:{ response in
            cell.imageV.image = response.result.value
            response.result.ifSuccess {
                // Stop the UIActivityIndicatorView animating
                if let spinner = cell.activityIndV{
                    spinner.startAnimating()
                    spinner.removeFromSuperview()
                }
            }
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard  let users = self.users else {
            return
        }
        if users.count-5 <=  indexPath.row
        {
            if self.hasMore == true {
                self.offset += limit
                self.loadTableData(offset: self.offset, limit: self.limit)
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = users?[indexPath.row] else {
            return
        }
        let next = self.storyboard?.instantiateViewController(withIdentifier: "SD2UserDetailVC") as! SD2UserDetailVC
        next.user = user
        self.navigationController?.pushViewController(next, animated: true)
    }
}
