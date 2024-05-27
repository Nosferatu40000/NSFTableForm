//
//  ParentViewController.swift
//  FormGame
//
//  Created by Alex Orlov on 09.05.2022.
//

import UIKit

open class ParentViewController: UIViewController {

    public typealias VoidClosure = () -> ()

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public lazy var reloadDataClosure: VoidClosure = { [weak self] in
        self?.tableView.reloadData()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }

    public var tableView: UITableView = UITableView()
    public var dataList: [SectionData] = [] {
        didSet {
            registerAll()
            reloadDataClosure()
        }
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        tableView.delegate = self
        tableView.dataSource = self
    }

    private func registerAll() {
        for section in dataList {
            for cellData in section.cells {
                if Bundle.main.path(forResource: cellData.identifier(), ofType: "nib") != nil {
                    let nib = UINib(nibName: cellData.identifier(), bundle: Bundle.main)
                    tableView.register(nib, forCellReuseIdentifier: cellData.identifier())
                } else {
                    tableView.register(cellData.cellClass(), forCellReuseIdentifier: cellData.identifier())
                }
            }
        }
    }
}

extension ParentViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataList[indexPath.section].cells[indexPath.row].selectionClosure?()
    }
}

extension ParentViewController: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList[section].cells.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = dataList[indexPath.section].cells[indexPath.row]
        let cell = cellData.updatedCell(table: tableView)
        return cell
    }
}
