//
//  TableViewController.swift
//  14
//
//

import UIKit

class TableViewController: UIViewController {
    
    let idCell = "cell"
    var tableAlbom = UITableView()
    var cells = InfoAlbom.moveAlbom()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: idCell)
        return cell
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableAlbom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            tableAlbom.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableAlbom.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            tableAlbom.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
