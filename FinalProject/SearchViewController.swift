//
//  SearchViewController.swift
//  FinalProject
//
//  Created by nagato on 12/15/20.
//  Copyright © 2020 nagato. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class SearchViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource  {
    var books = [Item]()
    @IBOutlet weak var seacrhTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(BookTableViewCell.nib(), forCellReuseIdentifier: BookTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        seacrhTextField.delegate = self
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        self.tableView.tableFooterView = UIView()
        seacrhTextField.layer.cornerRadius = 10.0
        seacrhTextField.layer.masksToBounds = true
        seacrhTextField.layer.shadowRadius = 10.0
        seacrhTextField.layer.shadowOpacity = 0.3
        seacrhTextField.layer.shadowOffset = CGSize(width: 5, height: 8)
        seacrhTextField.clipsToBounds = false

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBooks()
        return true
    }
    
    func searchBooks(){
        seacrhTextField.resignFirstResponder()
        guard let text = seacrhTextField.text, !text.isEmpty else {
            return
        }
        
        let query = text.replacingOccurrences(of: " ", with: "%20")
        
        books.removeAll()
        
        Alamofire.request("https://www.googleapis.com/books/v1/volumes?q=\(query)&maxResults=40", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject {(response:
            DataResponse<UserResponse>) in
            if let result = response.result.value{
                self.books = result.items ?? []
                DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier, for: indexPath) as! BookTableViewCell
        cell.bookTitleLbl.text = books[indexPath.row].volumeInfo?.title
        let url = String((books[indexPath.row].volumeInfo?.imageLinks!.thumbnail)!)
        if let data = try? Data(contentsOf: URL(string: url)!){
                    cell.posterImageView.image = UIImage(data: data)
        }
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "BookDetailsViewController") as? BookDetailsViewController
        vc?.bookId = books[indexPath.row].id
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
