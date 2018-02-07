//
//  ViewController.swift
//  finalProject
//
//  Created by Ksenia Zhizhimontova on 11/24/17.
//  Copyright © 2017 ksenia. All rights reserved.
//

import UIKit
import Floaty
import BulletinBoard

class LocationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    var locations: [Location] = []
    
    var collectionView: UICollectionView!
    var emptyLabel: UILabel!
    var allLocations: Array = ["4997346","5128581","5809844","5368361","4560349","5391959","4099974","4650946","2643743","6453366"]
    var searchActive : Bool = false
    let searchController = UISearchController(searchResultsController: nil)
    
    var floaty: Floaty!
    var units: String!
    
    lazy var bulletinManager: BulletinManager = {
        
        // Create root item and customize it
        print(self.units)
        let rootItem = PageBulletinItem(title: "Change Units")
        rootItem.actionButtonTitle = "Fahrenheit/Imperial"
        rootItem.alternativeButtonTitle = "Celsius/Metric"
        
        // set action handler to a closure (a function that will be called when the action is taken)
        rootItem.actionHandler = { (item: PageBulletinItem) in
            self.units = "imperial"

            self.dismissBulletin()
            self.collectionView.reloadData()
            self.getLocations()
        }
        
        // set alternative handler to a closure (a function that will be called when the alternative
        // action is taken)
        rootItem.alternativeHandler = { (item: PageBulletinItem) in
            self.units = "metric"

            self.collectionView.reloadData()
            self.dismissBulletin()
            self.getLocations()

        }
        
        return BulletinManager(rootItem: rootItem)
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation title
        title = "Current Weather"
        
        // Set background color
        view.backgroundColor = .white
        
        // Call setup method
        setupCollectionView()
        
        // Request locations from the network
        getLocations()
        setupView()
    }
    
    func setupView() {
        
        // Create our floaty object and add items to it
        floaty = Floaty()
        floaty.addItem("Switch Units", icon: #imageLiteral(resourceName: "thermometer")) { (button) in
            self.bulletinManager.backgroundViewStyle = .dimmed
            self.bulletinManager.prepare()
            self.bulletinManager.presentBulletin(above: self)
        }
        floaty.addItem("Weather.com", icon: #imageLiteral(resourceName: "satellite")){ (button) in
            self.openUrl(urlStr: "http://weather.com")
        
        }
        view.addSubview(floaty)
    }
    
    @objc func openUrl(urlStr:String!){
        if let url = NSURL(string:urlStr) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    // Create a function to dismiss the bulletin
    func dismissBulletin() {
        bulletinManager.dismissBulletin(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update the frame any time the view's frame changes
        collectionView.frame = view.bounds
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.dismiss(animated: true, completion: nil)
        self.getLocations()
    }
    
    func updateSearchResults(for searchController: UISearchController)
    {
        let searchString = searchController.searchBar.text
        if searchString == ""{
            getLocations()
        }
        else{
            NetworkManager.getUpdatedLocations(units: self.units ?? "imperial", searchString: searchString){locations in
                self.locations = locations
                
                self.updateCollectionView()
            }
            
            collectionView.reloadData()
        }
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        collectionView.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        collectionView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !searchActive {
            searchActive = true
            collectionView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    // MARK: Setup Views
    
    func setupCollectionView() {
        
        // Create and customize collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: cellHeight)
        layout.minimumLineSpacing = 2.0
        
        // Create collection view with the view's frame and the layout we created
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .collectionViewBackground
        collectionView.register(LocationCell.self, forCellWithReuseIdentifier: "LocationCell")
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        
        // Create pull to refresh view and set it to the collection view's pull to refresh view
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getLocations), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        // Create empty label and put it in the center of the view
        emptyLabel = UILabel()
        emptyLabel.font = UIFont(name: "Avenir-Medium", size: 24.0)
        emptyLabel.textColor = .lightGray
        emptyLabel.text = "No Locations Found"
        emptyLabel.sizeToFit()
        emptyLabel.center = CGPoint(x: view.center.x, y: view.center.y - (navigationController?.navigationBar.frame.maxY ?? 0.0))
        view.addSubview(emptyLabel)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for cities"
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.becomeFirstResponder()

        
        self.navigationItem.titleView = searchController.searchBar
    }


    @objc func getLocations() {
        
        // TODO: Get locations from network manager
        //print(self.units)
        let allString = allLocations.joined(separator: ",")
        NetworkManager.getLocations(units: self.units ?? "imperial", allString: allString){locations in
            self.locations = locations
            
            self.updateCollectionView()
        }
        //setupView()
    }
    
    func updateCollectionView() {

        // Reload collection view with fade animation (equivalent to collectionView.reloadData()
        collectionView.reloadSections(IndexSet(integer: 0))

        // Set empty label to hidden if there are no locations
        emptyLabel.isHidden = !locations.isEmpty

        // Stop refreshing animation
        collectionView.refreshControl?.endRefreshing()
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationCell", for: indexPath) as! LocationCell
        
        // Get proper location
        let location = locations[indexPath.item]
        
        // Configure cell for the given location
        cell.handle(location: location)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // Push location detail view controller
        let detailViewController = DetailViewController(location: locations[indexPath.item])
        navigationController?.pushViewController(detailViewController, animated: true)
    }

}

