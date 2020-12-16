//
//  ProfileViewController.swift
//  FinalProject
//
//  Created by nagato on 12/15/20.
//  Copyright © 2020 nagato. All rights reserved.
//

import UIKit
import RealmSwift
class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var id: Int!
    var bookUrlId: String!
    var bookIdInRealm: Int!
    
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        booksList = realm.objects(Books.self)
        self.tableView1.delegate = self
        self.tableView2.delegate = self
        self.tableView1.dataSource = self
        self.tableView2.dataSource = self
        self.tableView2.tableFooterView = UIView()
        tableView1.layoutMargins = UIEdgeInsets.zero
        tableView1.separatorInset = UIEdgeInsets.zero
        self.reload()
        if (tableView1.contentSize.height < tableView1.frame.size.height) {
            tableView1.isScrollEnabled = false;
        }
        else {
            tableView1.isScrollEnabled = true;
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        reload()
        reload2()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        switch tableView{
        case tableView1:
            numberOfRow = 1
        case tableView2:
            numberOfRow = booksList.count
        default:
            print("Something wrong")
        }
        return numberOfRow
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? ProfileUITableViewCell
        let user = realm.object(ofType: User.self, forPrimaryKey: 0)
        cell?.usersEmailLbl.text = user!.userEmail
        cell?.usersPhoneNumber.text = user!.userContact
        cell?.usersFullNameLbl.text = user!.fullName
        if(user?.userImg != nil){
            let image : UIImage = UIImage(data: user!.userImg! as Data)!
            cell?.profileImageView.image = image
        }
        cell?.profileImageView.layer.cornerRadius = 10.0
        cell?.profileImageView.layer.masksToBounds = true
        if (tableView == tableView2) {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2") as? ListUITableViewCell
            let books = booksList[indexPath.row]
            cell2?.bookTitleLbl.text = books.bookTitle
            let url = String(books.imgUrl!)
            if let data = try? Data(contentsOf: URL(string: url)!){
                cell2?.imageView!.image = UIImage(data: data)
            }
            return cell2!
        }
        return cell!
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (tableView == tableView1) {
            return 163.0
        } else {
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView2.beginUpdates()
            id = booksList[indexPath.row].id
            let specificBook = realm.object(ofType: Books.self, forPrimaryKey: id)
            try! realm.write {
                realm.delete(specificBook!)
            }
            tableView2.deleteRows(at: [indexPath], with: .fade)
            tableView2.endUpdates()
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView2.deselectRow(at: indexPath, animated: true)
           // Show book details
        if tableView == tableView2{
            bookUrlId = booksList[indexPath.row].urlId
            id = booksList[indexPath.row].id
               performSegue(withIdentifier: "detailsViewProfile", sender: self)
        }
        
       }
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let dest = segue.destination as? BookDetailsViewController{
            dest.bookIdInRealm = id
               dest.bookId = bookUrlId
           }
           
       }
    func reload(){
        tableView1.reloadData()
        
    }
    func reload2(){
        tableView2.reloadData()
    }

    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
        realm.beginWrite()
        realm.delete(realm.objects(User.self))
        try! realm.commitWrite()
        self.performSegue(withIdentifier: "closeApp", sender: self)
    }
    
}
class ProfileUITableViewCell: UITableViewCell{
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usersEmailLbl: UILabel!
    @IBOutlet weak var usersFullNameLbl: UILabel!
    @IBOutlet weak var usersPhoneNumber: UILabel!
}
class ListUITableViewCell: UITableViewCell{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var bookTitleLbl: UILabel!
}
