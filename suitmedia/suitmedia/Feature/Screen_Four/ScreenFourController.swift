//
//  ScreenFourController.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 03/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit
import Refreshable
import DZNEmptyDataSet

class ScreenFourController: BaseViewController, FourViewModelDelegate,FourCollectionViewDelegate {
    

    @IBOutlet weak var collectionView: UICollectionView!
    var controller = ScreenTwoController()
    var page: Int = 1
    private lazy var fourCV = {
        FourCollectionViewAdapter.init(delegate: self)
    }()
    private lazy var getDataFour = {
        FourViewModel.init(delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let dataUser = QueryData.getDataUser()
        
        
        if dataUser.count == 0 {
             self.getDataFour.fetchApi(page: page)
        }else{
            self.getCache()
        }
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setNavigationBarType(.backbuttontitle(title: "GUESTS"))
        self.setInitView()
    }
    
    private func setInitView(){
        self.collectionView.delegate = fourCV
        self.collectionView.dataSource = fourCV
        self.collectionView.registerNib(FourCell.stringRepresentation)
        self.collectionView.addPullToRefresh(action: { [weak self] in
            self?.handleRefresh()
        })
        self.collectionView.addLoadMore(action: {[weak self] in
            self?.page += 1
            self?.getDataFour.fetchApi(page: self?.page ?? 1)
        })

    }
    
    private func isPrime(idUser:Int) -> Bool {
        var isPrime : Bool = true
        
        if idUser == 2 {
            isPrime = true
        }else if idUser < 2 {
            isPrime = false
        }else {
            for i in 2...idUser-1{
                if((idUser%i) == 0){
                    isPrime = false
                    break;
                }
            }
        }
        
        return isPrime
    }

    private func handleRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            let delete = QueryData.deleteData()
            
            if delete {
                self.getDataFour.fetchApi(page: 1)
                self.collectionView.stopPullToRefresh()
                self.collectionView.setLoadMoreEnable(true)
                self.collectionView.reloadData()
            }

        }
    }

    private func updateLoadMoreEnable(dataUser: [DataUser]) {
        if dataUser.count < 9 {
            self.collectionView.setLoadMoreEnable(false)
            self.collectionView.stopLoadMore()
            self.collectionView.stopPullToRefresh()
        }else{
            self.collectionView.setLoadMoreEnable(true)
        }
    }
    
    private func getCache() {
        let data = QueryData.getDataUser()
        let view = EmptyPage.create()
        view.height = collectionView.frame.height
        view.retryButtonHandler = { [weak self] in
            self?.page = 1
            self?.getDataFour.fetchApi(page: self?.page ?? 1)
        }
        
        if data.count > 0 {
            view.removeFromSuperview()
            self.page = data.last?.page ?? 1
            self.fourCV.listFour = data
            self.collectionView.reloadData()
            
            
        }else{
            
            self.collectionView.addSubview(view)
            self.view.layoutIfNeeded()
        }
        
    }



    func success(response: [DataUser]) {
        self.updateLoadMoreEnable(dataUser: response)
        if response.count > 0 {
            for datauser in response {
                QueryData.saveDatauser(dataUser: datauser, page: self.page)
            }
        }
        self.getCache()
        
    }
    
    func error(error: ApiError) {
        showAlertMessage(vc: self, withTitle: "Information", message: error.localizedDescription, isOk: {
            
        }, isCancel: nil)
        
    }
    
    func load(isLoad: Bool) {
        
        isLoad ? self.showHud("") : self.hideHUD()
        
    }
    
    func onItemClick(modelFour: DataUser) {
        let data = modelFour
        
        if isPrime(idUser: data.id) {
            
            self.showAlertMessage(vc: self, withTitle: "Prime", message: "Data is prime", isOk: {
                self.controller.user = data
                self.controller.guestNameClick = data.firstName
                self.popController(animated: true)
            }, isCancel: nil)
        }else{
            self.showAlertMessage(vc: self, withTitle: "Prime", message: "Data is not prime", isOk: {
                self.controller.user = data
                self.controller.guestNameClick = data.firstName
                self.popController(animated: true)
            }, isCancel: nil)}
        
        
        
    }
    

}




