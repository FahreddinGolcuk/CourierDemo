//
//  LogoutCell.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 27.01.2022.
//

import UIKit
import Helpers
import Extensions

final class LogoutCell: UITableViewCell {
    // MARK: - Properties
    private let title = with(UILabel()) {
        $0.font = .boldSystemFont(ofSize: 16.0)
        $0.text = Constants.logOutTitle
        $0.textColor = UIColor.Theme.primary
    }
    
    private let iconView = with(UIImageView()) {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "power.circle.fill")
    }
    
    lazy var innerStackView = hStack(
        distribution: .fill, space: 4.0
    )(
        iconView,
        title
    )
    
    private let view = with(UIView()) {
        $0.backgroundColor = UIColor.Theme.inactive
    }
    
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
        view.addSubview(innerStackView)
        addSubview(view)
        [
            view.alignEdges(leading: 0, trailing: 0, top: 0, bottom: 0),
            iconView.alignSize(width: 25, height: 25),
            innerStackView.center(in: view)
        ]
        .flatMap { $0 }
        .activate()
        
        innerStackView.alignTop(to: view, offset: 16).activate()
        innerStackView.alignBottom(to: view, offset: -16).activate()
        view.alignHeight(Constants.height).activate()
        
        self.selectionStyle = .none
        backgroundColor = .clear
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
}

private enum Constants {
    static let logOutTitle = "Log out"
    static let height: CGFloat = 64
}
