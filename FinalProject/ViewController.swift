//
//  ViewController.swift
//  FinalProject
//
//  Created by nagato on 12/14/20.
//  Copyright © 2020 nagato. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import AlamofireObjectMapper

var booksList: Results<Books>!
var realm = try! Realm()
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    var books = [Item]()
    var bookId: String!
    @IBOutlet weak var collectionView: UICollectionView!
    let cellScale: CGFloat = 0.6
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserPreferredBooks()
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        let cellHeight = floor(screenSize.height * cellScale)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(!isUserLoggedIn){
        self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }
    func getUserPreferredBooks(){
        Alamofire.request("https://www.googleapis.com/books/v1/volumes?q=programming&maxResults=40", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject {(response:
            DataResponse<UserResponse>) in
            if let result = response.result.value{
                self.books = result.items ?? []
                DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
            }
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        cell.bookTitle.text = books[indexPath.row].volumeInfo?.title
        let url = String((books[indexPath.row].volumeInfo?.imageLinks!.thumbnail)!)
        if let data = try? Data(contentsOf: URL(string: url)!){
                    cell.posterImageView.image = UIImage(data: data)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "BookDetailsViewController") as? BookDetailsViewController
        vc?.bookId = books[indexPath.row].id
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }

}

