//
//  BookDetailsViewController.swift
//  FinalProject
//
//  Created by nagato on 12/15/20.
//  Copyright © 2020 nagato. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SafariServices
class BookDetailsViewController: UIViewController, UIScrollViewDelegate  {
    var bookId: String?
    var webUrl: String!
    var bookIdInRealm: Int?
    var posterUrl: String?

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var authorsLbl: UILabel!
    @IBOutlet weak var publishedDate: UILabel!
    @IBOutlet weak var publisherLbl: UILabel!
    @IBOutlet weak var pageLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var uiScrollView: UIScrollView!
    @IBOutlet weak var readBtn: UIButton!
    @IBOutlet weak var addDeleteButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBookDetail()
        uiScrollView.delegate = self
        self.scrollViewDidScroll(uiScrollView)
        if bookIdInRealm != nil{
            addDeleteButton.title = "Delete from List"
            addDeleteButton.tintColor = .systemRed
        }
        readBtn.layer.cornerRadius = 10.0
        readBtn.layer.masksToBounds = true
        readBtn.layer.shadowOffset = CGSize(width: 5, height: 8)
        readBtn.layer.shadowOpacity = 3.0
        readBtn.layer.shadowRadius = 10.0
        readBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    func getBookDetail(){
        Alamofire.request("https://www.googleapis.com/books/v1/volumes/\(bookId!)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject {(response:
            DataResponse<UserResponse2>) in
            if let result = response.result.value{
                self.title = result.volumeInfo?.title
                self.authorsLbl.text = result.volumeInfo!.authors![0]
                self.publishedDate.text = result.volumeInfo?.publishedDate
                self.publisherLbl.text = result.volumeInfo?.publisher
                self.pageLbl.text = String(result.volumeInfo!.pageCount!)
                if result.volumeInfo?.categories! != nil {
                    self.categoryLbl.text = result.volumeInfo?.categories![0]
                }
                self.webUrl = String(result.volumeInfo!.previewLink!)
                self.languageLbl.text = result.volumeInfo?.language
                self.descriptionTextView.text = result.volumeInfo?.descriptionField
                self.posterUrl = String((result.volumeInfo?.imageLinks!.thumbnail)!)
                let url = String((result.volumeInfo?.imageLinks!.thumbnail)!)
                if let data = try? Data(contentsOf: URL(string: url)!){
                    self.posterImageView.image = UIImage(data: data)}
            }
        }
    }

    @IBAction func readButtonTapped(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: webUrl)!)
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        present(vc, animated: true, completion: nil)
    }
    @IBAction func addToListTapped(_ sender: Any) {
        if bookIdInRealm != nil{
                let specificBook = realm.object(ofType: Books.self, forPrimaryKey: bookIdInRealm)
                try! realm.write {
                    realm.delete(specificBook!)
                }
            } else{
                let bookToList = Books()
                bookToList.bookTitle = self.title
                bookToList.imgUrl = self.posterUrl
                bookToList.urlId = self.bookId!
                bookToList.id = self.incrementID()
                try! realm.write{
                    realm.add(bookToList)
                }
            }
            
            
            navigationController?.popViewController(animated: true)
            
        }
        func incrementID() -> Int {
            return (realm.objects(Books.self).max(ofProperty: "id") as Int? ?? 0) + 1
        }
    
}

