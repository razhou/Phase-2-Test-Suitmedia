//
//  ScreenThreeController.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 03/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit

class ScreenThreeController: BaseViewController,ThreeTableDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var threeTV = {
        ThreeTableViewAdapter.init(delegate: self)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setInitView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarType(.hideBackButton(title: "EVENTS"))
    }
    
    func setInitView() {
        self.tableView.delegate = threeTV
        self.tableView.dataSource = threeTV
        self.tableView.registerNib(ThreeCell.stringRepresentation)
        self.tableView.reloadData()
        
    }

    func onClickItem(index: Int) {
        let name = ModelScreenThree.name[index]
        Prefs.setData(Keys.three, value: name)
        self.popController(animated: true)
        
    }
    

}
