//
//  AppAboutCell.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 26.01.2022.
//

import UIKit
import Helpers

class AppAboutCell: UITableViewCell {
    
    // MARK: - Properties
    fileprivate let label = with(UILabel()) {
        $0.font = .systemFont(ofSize: 14.0, weight: .bold)
        $0.textColor = .yellow
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
