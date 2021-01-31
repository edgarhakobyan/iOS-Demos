//
//  TableViewCell.swift
//  MVVM-1
//
//  Created by Edgar on 30.01.21.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    weak var veiwModel: TableViewCellViewModelType? {
        willSet(viewModel) {
            nameLabel.text = viewModel?.fullName
            ageLabel.text = viewModel?.age
        }
    }
}
