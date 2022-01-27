//
//  ProfileItemCell.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 26.01.2022.
//

import UIKit
import Helpers
import RxSwift
import Extensions

class ProfileItemCell: UITableViewCell {
    // MARK: - Properties
    fileprivate let label = with(UILabel()) {
        $0.font = .systemFont(ofSize: 14.0, weight: .bold)
        $0.textColor = UIColor.Theme.title
    }
    
    private let disclosureIcon = with(UIImageView()) {
        $0.image = UIImage(systemName: "arrow.forward")
        $0.contentMode = .right
    }
    
    fileprivate let itemImage = with(UIImageView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
    }
    
    fileprivate let badgeLabel = with(UILabel()) {
        $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
        $0.textColor = UIColor.Theme.title
        $0.textAlignment = .center
        $0.backgroundColor = .brown
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 11.0
    }
    
    private lazy var stackView = hStack(
        distribution: .fill,
        space: 16.0
    )(
        itemImage,
        label,
        badgeLabel,
        disclosureIcon
    )
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(stackView)
        [
            stackView.alignEdges(leading: 15, trailing: -15, top: 12, bottom: -12),
            badgeLabel.alignSize(width: 22, height: 22),
            itemImage.alignSize(width: 20, height: 20),
            [
                disclosureIcon.alighWidth(6)
            ]
        ]
        .flatMap { $0 }
        .activate()
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
}

extension Reactive where Base == ProfileItemCell {
    var populate: Binder<(ProfileSectionItem, UInt?)> {
        Binder(base) { target, datasource in
            let item = datasource.0
            let count = datasource.1
            target.label.text = item.title
            target.itemImage.image = item.icon
            target.badgeLabel.text = count?.description
            target.badgeLabel.isHidden = count == 0 || count == nil
        }
    }
}
