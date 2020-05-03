//
//  ScreenFourController.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 03/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit

class ScreenFourController: BaseViewController, FourViewModelDelegate,FourCollectionViewDelegate {
    

    @IBOutlet weak var collectionView: UICollectionView!
    var listFour : [DataUser] = []
    var controller = ScreenTwoController()
    private lazy var fourCV = {
        FourCollectionViewAdapter.init(delegate: self)
    }()
    private lazy var getDataFour = {
        FourViewModel.init(delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setInitView()
        self.getDataFour.fetchApi()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setNavigationBarType(.hideBackButton(title: "GUESTS"))
    }
    
    private func setInitView(){
        self.collectionView.delegate = fourCV
        self.collectionView.dataSource = fourCV
        self.collectionView.registerNib(FourCell.stringRepresentation)

    }


    func success(response: [DataUser]) {
        if response.count > 0 {
            
            self.fourCV.listFour = response
            self.collectionView.reloadData()
        }
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
           
            self.controller.user = data
            self.controller.guestNameClick = data.firstName
        self.popController(animated: true)
        
    }
   

}
