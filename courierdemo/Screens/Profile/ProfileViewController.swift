//
//  ProfileViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import UIKit
import RxSwift
import Helpers

final class ProfileViewController: UIViewController {
    fileprivate let viewModel: ProfileViewModel
    fileprivate lazy var viewSource = with(ProfileView()) {
        $0.tableView.dataSource = self
        $0.tableView.delegate = self
    }
    private let (viewWillAppearObserver, viewWillAppearEvent) = Observable<Void>.pipe()
    
    fileprivate var datasource: [ProfileSectionType] = []
    
    private let bag = DisposeBag()
    
    override func loadView() {
        view = viewSource
    }
    
    init(viewModel: @escaping ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = "Profile"
        bindViewModelOutputs()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewWillAppearObserver.onNext(())
    }

}

extension ProfileViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let headerView = UIView()
        print(111,datasource[section])
        return headerView
    }

    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return datasource[section].sectionHeaderHeight
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        datasource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datasource[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowType = getRowType(indexPath: indexPath) else { return UITableViewCell() }
        switch rowType {
        case .liveHelp:
            let cell: LiveHelpCell = tableView.dequeue(at: indexPath)
            return cell
        case .logout:
            let cell: LogoutCell = tableView.dequeue(at: indexPath)
            return cell
        default:
            let cell: ProfileItemCell = tableView.dequeue(at: indexPath)
            print(111,rowType.title)
            cell.rx.populate.onNext((rowType, nil))
            return cell
        }
    }
}

private extension ProfileViewController {
    func bindViewModelOutputs() {
        let output = viewModel(inputs)
        bag.insert(
            output.datasourceOutput.drive(rx.setDatasource)
        )
    }
    
    var inputs: ProfileViewModelInput {
        let indexSelected = viewSource.tableView.rx.itemSelected
            .do(onNext: { [weak viewSource] in
                viewSource?.tableView.deselectRow(at: $0, animated: true)
            })
        return ProfileViewModelInput(viewWillAppear: viewWillAppearEvent, indexSelected: indexSelected)
    }
    
    func getSectionType(at section: Int) -> ProfileSectionType? {
        guard section < datasource.count else { return nil }
        return datasource[section]
    }
    
    func getRowType(indexPath: IndexPath) -> ProfileSectionItem? {
        guard let sectionType = getSectionType(at: indexPath.section) else { return nil }
        return sectionType.rows[indexPath.row]
    }
}

private extension Reactive where Base == ProfileViewController {
    var setDatasource: Binder<[ProfileSectionType]> {
        Binder(base) { target, datasource in
            target.datasource = datasource
            print(555,datasource)
            target.viewSource.tableView.reloadData()
        }
    }
}
