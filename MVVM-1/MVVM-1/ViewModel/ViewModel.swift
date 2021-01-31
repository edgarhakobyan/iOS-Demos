//
//  ViewModel.swift
//  MVVM-1
//
//  Created by Edgar on 30.01.21.
//

import Foundation

class ViewModel: TableViewViewModelType {
    private var selectedIndexPath: IndexPath?
    
    private var profiles = [
        Profile(name: "Tom", surname: "Hanks", age: 40),
        Profile(name: "John", surname: "Bush", age: 30),
        Profile(name: "Sam", surname: "Lenon", age: 20)
    ]
    
    func numberOfRows() -> Int {
        profiles.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let profile = profiles[indexPath.row]
        return CellViewModel(profile: profile)
    }
    
    func viewModelForSelectedRow() -> DetailViewModelType? {
        guard let selectedRow = selectedIndexPath else { return nil }
        return DetailViewModel(profile: profiles[selectedRow.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
}
