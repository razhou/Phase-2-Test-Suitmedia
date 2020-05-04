//
//  ScreenThreeController.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 03/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit
import MapKit
class ScreenThreeController: BaseViewController,ThreeTableDelegate,ThreeCollectionDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewMap: UIView!
    @IBOutlet weak var mapsView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var mapModel : [MapModel] = []
    
    var isList :Bool = true
    var indexRow:Int = 0
    
    private lazy var threeTV = {
        ThreeTableViewAdapter.init(delegate: self)
    }()
    
    private lazy var threeCol = {
        ThreeCollectionViewAdapter.init(delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setInitView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarType(.backbuttonMap(title: "EVENTS"))
    }
    
    func setInitView() {
        self.tableView.estimatedRowHeight = 200
        self.tableView.delegate = threeTV
        self.tableView.dataSource = threeTV
        self.tableView.registerNib(ThreeCell.stringRepresentation)
        self.tableView.reloadData()
        
        self.collectionView.delegate = threeCol
        self.collectionView.dataSource = threeCol
        self.collectionView.registerNib(ThreeColCell.stringRepresentation)
        self.collectionView.reloadData()
        
        self.refreshMapsAnnotation()
        
    }
    
    
    func refreshMapsAnnotation() {
        mapsView.removeAnnotations(mapsView.annotations)
        mapModel.removeAll()
        
        for i in 0 ..< ModelScreenThree.longitude.count {
            let lat = ModelScreenThree.latitude[i]
            let lon = ModelScreenThree.longitude[i]
            let name = ModelScreenThree.name[i]
            
            let coor = CLLocationCoordinate2D(latitude: lat ,longitude: lon )
            let pin = MapModel(coordinate: coor)
            pin.title = name
            
            mapModel.append(pin)
        }
        
        self.mapsView.addAnnotations(mapModel)
        let span = MKCoordinateSpan.init(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let location = CLLocationCoordinate2DMake(-6.215840,106.806574)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapsView.region = region
      }

    func onClickItem(index: Int) {
        let name = ModelScreenThree.name[index]
        Prefs.setData(Keys.three, value: name)
        self.popController(animated: true)
        
    }
    
    func onClickScrollCollection(index: Int) {
        self.indexRow = index
        self.refreshMapsAnnotation()
    }
    
    override func mapList() {
        if isList {
            self.indexRow = 0
            self.refreshMapsAnnotation()
            self.collectionView.scrollToItem(at: NSIndexPath.init(row: 0, section: 1) as IndexPath, at: .centeredHorizontally, animated: true)
            self.view.addSubview(viewMap)
            isList = false
            self.setNavigationBarType(.backbuttonList(title: "EVENTS"))
            self.view.layoutIfNeeded()
        }else{
            self.setNavigationBarType(.backbuttonMap(title: "EVENTS"))
            self.viewMap.removeFromSuperview()
            self.view.layoutIfNeeded()
            isList = true
        }
    }
}

extension ScreenThreeController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let name = ModelScreenThree.name[self.indexRow]
        if let pin = annotation as? MapModel {
            if pin.title ==  name {
                
                var annotSelected = mapView.dequeueReusableAnnotationView(withIdentifier: "pinSelected")
                
                if annotSelected == nil {
                    
                    annotSelected = MKAnnotationView(annotation: annotation, reuseIdentifier: "pinSelected")
                    annotSelected?.image = UIImage(named: "ic_marker_selected")
                    annotSelected?.canShowCallout = true
                    annotSelected?.isUserInteractionEnabled = true
                    annotSelected?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                    
                }
                
                annotSelected?.annotation = annotation
                
                return annotSelected
            }else {
                
                var annotUnSelected = mapView.dequeueReusableAnnotationView(withIdentifier: "pinUnSelected")
                
                if annotUnSelected == nil {
                    
                    annotUnSelected = MKAnnotationView(annotation: annotation, reuseIdentifier: "pinUnSelected")
                    annotUnSelected?.image = UIImage(named: "ic_marker_unselected")
                    annotUnSelected?.canShowCallout = true
                    annotUnSelected?.isUserInteractionEnabled = true
                    annotUnSelected?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                    
                }
                
                annotUnSelected?.annotation = annotation
                
                return annotUnSelected
            }
        }
        
        
        return nil
    }
}
