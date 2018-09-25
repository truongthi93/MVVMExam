
//
//  ImageListViewModel.swift
//  LearningMVVM
//
//  Created by Thi Vo on 2018/9/25.
//  Copyright © 2018 UIT. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

@objc protocol ImageListViewModelDelegate {
    @objc optional func getFieldListLocalSuccessful(list: [SplashbaseImage])
    @objc optional func getFieldListLocalFail()
    
    @objc optional func getFieldListSuccessful(list: [SplashbaseImage])
    @objc optional func getFieldListFail()
}

class ImageListViewModel: NSObject {
    var imageList : [SplashbaseImage] = []
    weak var delegate: ImageListViewModelDelegate? = nil
    
    func getImagesFromAPI() {
        let URL = Constants.linkImage
        Alamofire.request(URL).responseArray(keyPath: Constants.keyPathAlamofire) { (response: DataResponse<[SplashbaseImage]>) in
            let forecastArray = response.result.value
            if let forecastArray = forecastArray {
                self.imageList = forecastArray
                // Save to database
                CoreDataImage.shared.saveData(list: forecastArray)
                self.delegate?.getFieldListSuccessful!(list: forecastArray)
            } else {
                self.imageList.removeAll()
                self.delegate?.getFieldListFail!()
            }
        }
    }
    
    func getImagesFromLocal() {
        if let fetchData = CoreDataImage.shared.fetchData(),
            fetchData.count > 0{
            self.imageList = fetchData
            self.delegate?.getFieldListLocalSuccessful!(list: fetchData)
        } else {
            self.imageList.removeAll()
            self.delegate?.getFieldListLocalFail!()
        }
    }
}
