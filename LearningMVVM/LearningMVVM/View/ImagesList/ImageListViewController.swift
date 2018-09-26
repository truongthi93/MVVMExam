//
//  ImageListViewController.swift
//  LearningMVVM
//
//  Created by Thi Vo on 2018/9/25.
//  Copyright © 2018 UIT. All rights reserved.
//

import UIKit

class ImageListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var imageList : [SplashbaseImage] = []
    var imageListViewModel = ImageListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.setUpNavigationBar()
        
        collectionView.register(UINib.init(nibName: Constants.nameImageCollectionViewCell , bundle: nil), forCellWithReuseIdentifier: Constants.nameImageCollectionViewCell)
        self.imageListViewModel.delegate = self
        self.imageListViewModel.getImagesFromLocal()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpNavigationBar() {
        self.navigationItem.title = Constants.titleImageListView
        let logout = UIBarButtonItem(title: Constants.titleUIRightBarButtonItem, style: .plain, target: self, action: #selector(ImageListViewController.logout))
        self.navigationItem.rightBarButtonItem  = logout
        
        self.navigationItem.title = Constants.titleImageListView
        let delete = UIBarButtonItem(title: Constants.titleUILeftBarButtonItem, style: .plain, target: self, action: #selector(ImageListViewController.deleteAllLocal))
        self.navigationItem.leftBarButtonItem  = delete
    }
    
    @objc func logout() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func deleteAllLocal() {
        // Declare Alert message
        let dialogMessage = UIAlertController(title: Constants.titleShowAletMessage, message: Constants.showAlertDeleteImage, preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: Constants.buttonShowAletOK, style: .default, handler: { (action) -> Void in
            CoreDataImage.shared.deleteData()
            self.imageList.removeAll()
            self.collectionView.reloadData()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: Constants.buttonShowAlertCancel, style: .cancel) { (action) -> Void in
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

// MARK:- UICollectionView DataSource
extension ImageListViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.nameImageCollectionViewCell,for:indexPath as IndexPath) as! ImageCollectionViewCell
        if let image = imageList[indexPath.row].url {
            cell.imageView.imageFromUrl(urlString: image)
        } else {
            cell.imageView.image = UIImage(named: Constants.nameImageGoogle)
        }
        
        return cell
    }
}

// MARK:- UICollectionViewDelegate Methods
extension ImageListViewController : UICollectionViewDelegate {
    private func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
    }
    
    private func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: IndexPath) {
    }
}

extension ImageListViewController : ImageListViewModelDelegate {
    func getFieldListLocalSuccessful(list: [SplashbaseImage]){
        self.imageList = list
        self.collectionView.reloadData()
    }
    
    func getFieldListLocalFail(){
        self.imageListViewModel.getImagesFromAPI()
    }

    func getFieldListSuccessful(list: [SplashbaseImage]){
        self.imageList = list
        self.collectionView.reloadData()
    }

    func getFieldListFail(){
        Utility.showAlert(message: Constants.showAletAPIFail, context: self)
    }
}
