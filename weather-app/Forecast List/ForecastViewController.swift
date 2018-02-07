//
//  ForecastViewController.swift
//  finalProject
//
//  Created by Ksenia Zhizhimontova on 11/24/17.
//  Copyright © 2017 ksenia. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    var locations16: [Location16] = []
    
    var collectionView: UICollectionView!
    var emptyLabel: UILabel!
    var searchActive : Bool = false
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation title
        title = "Forecast"
        
        // Set background color
        view.backgroundColor = .white
        
        // Call setup methods
        setupCollectionView()
        
        // Request locations from the network
        getLocations16()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update the frame any time the view's frame changes
        collectionView.frame = view.bounds
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController)
    {
        let searchString = searchController.searchBar.text
        if searchString == ""{
            getLocations16()
        }
        else{
            NetworkManager.getUpdatedLocations16(searchString: searchString){locations16 in
                self.locations16 = locations16
                
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
        collectionView.register(Location16Cell.self, forCellWithReuseIdentifier: "Location16Cell")
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        
        
        // Create pull to refresh view and set it to the collection view's pull to refresh view
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getLocations16), for: .valueChanged)
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
        searchController.searchBar.placeholder = "Ithaca"
        searchController.searchBar.sizeToFit()
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.black
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.black
        
        searchController.searchBar.becomeFirstResponder()
        
        
        self.navigationItem.titleView = searchController.searchBar
    }
    
    @objc func getLocations16() {
        
        // TODO: Get locations from network manager
        NetworkManager.getLocations16{locations16 in
            self.locations16 = locations16
            
            self.updateCollectionView()
        }
        
    }
    
    func updateCollectionView() {
        
        // Reload collection view with fade animation (equivalent to collectionView.reloadData()
        collectionView.reloadSections(IndexSet(integer: 0))
        
        // Set empty label to hidden if there are no locations
        emptyLabel.isHidden = !locations16.isEmpty
        
        // Stop refreshing animation
        collectionView.refreshControl?.endRefreshing()
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations16.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Location16Cell", for: indexPath) as! Location16Cell
        
        // Get proper location
        let location16 = locations16[indexPath.item]
        
        // Configure cell for the given location
        cell.handle(location16: location16)
        
        return cell
    }
}


