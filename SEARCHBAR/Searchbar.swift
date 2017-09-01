//
//  Searchbar.swift
//  SEARCHBAR
//
//  Created by appinventiv on 01/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit
// SearchBar
class Searchbar: UIViewController {

    @IBOutlet var SearchbarCollectionView: UICollectionView!
    var mybutton = false
    
    @IBOutlet weak var icecreamSearchBar: UISearchBar!
    //var icecream = ["6", "7", "8", "9", "10"]
    var icecreamNames = ["vanilla", "butterscotch", "chocolate", "rasberry", "blueberry"]
    
    var filteredData = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.SearchbarCollectionView.dataSource = self
        self.SearchbarCollectionView.delegate = self
        self.icecreamSearchBar.delegate = self
        filteredData = icecreamNames
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func likeButtonTapped(_ sender : UIButton) {
      
        sender.isSelected = !sender.isSelected
        
    }
   
}
extension Searchbar: UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Customcell", for: indexPath) as? Customcell
            else{
                fatalError()
            }
        cell.icecreamUILabel.text = self.filteredData[indexPath.row]
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        cell.icecreamImageView.image = UIImage(named:filteredData[indexPath.row])
        return cell

}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)  {
        
        filteredData = searchText.isEmpty ? icecreamNames : icecreamNames.filter { (temp: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return temp.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil

    }
        SearchbarCollectionView.reloadData()
    
    }
}


class Customcell: UICollectionViewCell {
        
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var icecreamImageView: UIImageView!
        @IBOutlet weak var icecreamUILabel: UILabel!
}
