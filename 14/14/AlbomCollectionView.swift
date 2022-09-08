//
//  AlbomCollectionView.swift
//  14
//
//

import UIKit

class AlbomCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate {

    private var cells = InfoAlbom.moveAlbom()
     var tableAdd = UITableView()

     private lazy var collectionView: UICollectionView = {
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayoutDiffSection())
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.register(AlbomCollectionViewCell.self, forCellWithReuseIdentifier: AlbomCollectionViewCell.refisterCell)
         return collectionView
     }()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         title = "Альбомы"
         navigationController?.navigationBar.prefersLargeTitles = true
         view.addSubview(collectionView)
         self.tableAdd.delegate = self
         setupLayout()
         view.addSubview(tableAdd)
         setupLayoutTable()
     }
     
    private func setupLayoutTable() {
        NSLayoutConstraint.activate([
            tableAdd.topAnchor.constraint(equalTo: tableAdd.topAnchor, constant: 0),
            tableAdd.leadingAnchor.constraint(equalTo: tableAdd.leadingAnchor, constant: 0),
            tableAdd.trailingAnchor.constraint(equalTo: tableAdd.trailingAnchor, constant: 0),
            tableAdd.rightAnchor.constraint(equalTo: tableAdd.rightAnchor, constant: 0)
        ])
        }
    
     private func setupLayout() {
         NSLayoutConstraint.activate([
             collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
             collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
             collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
             collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
         ])
     }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return cells.count
     }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbomCollectionViewCell.refisterCell, for: indexPath) as! AlbomCollectionViewCell
         cell.albomImageView.image = cells[indexPath.row].image
         cell.nubmerPhoto.text = cells[indexPath.row].name
         return cell
     }

     func set(cells: [InfoAlbom]) {
         self.cells = cells
     }
}
   
extension AlbomCollectionViewController: UICollectionViewDelegateFlowLayout {
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let itemWidth = collectionView.bounds.width
                 let itemHeight = collectionView.bounds.height
                 return CGSize(width: itemWidth, height: itemHeight)     }
 }

 struct Constrain {
     static let leftDistance: CGFloat = 15
     static let rightDistance: CGFloat = 15
     static let albomLine: CGFloat = 15
 }

func createLayoutDiffSection() -> UICollectionViewLayout {
    
    let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
        
        enum Section: Int, CaseIterable {
                case grid2
                case grid3
                case list

                var columnCount: Int {
                    switch self {
                    case .grid2:
                        return 2
                    case .grid3:
                        return 2
                    case .list:
                        return 2
                    }
                }
            }
        
        guard let sectionKind = Section(rawValue: sectionIndex) else {
            return nil
        }
        let columns = sectionKind.columnCount
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.trailing = 10
        item.contentInsets.bottom = 20
        
        let groupHeight = columns == 1 ?
        NSCollectionLayoutDimension.absolute(20) :
        NSCollectionLayoutDimension.fractionalWidth(1.0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                               heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: columns)
        group.contentInsets.trailing = 5
        group.contentInsets.top = 5
        group.contentInsets.leading = 1
        group.contentInsets.bottom = 5
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 15, trailing: 5)
        section.orthogonalScrollingBehavior = .paging
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(10)), elementKind: headerAlbomName, alignment: .topLeading)]
        return section
    }
    return layout
}

let headerAlbomName = "Альбомы"

class HeaderAlbom: UICollectionReusableView {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = "Альбомы"
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
