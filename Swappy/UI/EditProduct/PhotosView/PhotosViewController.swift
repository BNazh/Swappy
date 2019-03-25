//
//  PhotosView.swift
//  Swappy
//
//  Created by Mihail on 23/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

class ImageModel {
    enum State {
        case
        empty,
        loading,
        loaded,
        fail
    }
    
    let id: String = UUID().uuidString
    var url: String?
    var image: UIImage? = UIImage(named: "camera")
    var state: State = .empty
}

final class PhotosViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cells = [
        ImageModel(),
        ImageModel(),
        ImageModel(),
        ImageModel(),
        ImageModel(),
        ImageModel()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell
        cell = collectionView.dequeueReusableCell(indexPath: indexPath)
        
        cell.model = cells[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
}

extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard cells[indexPath.row].state == .empty else {
            return
        }
        
        let emptyCells = cells.filter { $0.state == .empty }
        
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = emptyCells.count
        
        bs_presentImagePickerController(vc, animated: true, select: nil, deselect: nil, cancel: nil, finish: { [weak self] assets in
            DispatchQueue.main.async {
                let images = assets.compactMap { $0.image }
                self?.didSelectPhotos(images)
            }
        }, completion: nil)
    }
}

extension PhotosViewController: PhotoCellDelegate {
    
    func removeCell(_ cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        
        cells.remove(at: indexPath.row)
        cells.append(ImageModel())
        
        let insertIndexPath = IndexPath(item: cells.count - 1, section: 0)
        
        self.collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [indexPath])
            self.collectionView.insertItems(at: [insertIndexPath])
        }, completion:nil)
    }
}

private extension PhotosViewController {
    
    func didSelectPhotos(_ photos: [UIImage]) {
        let startIndex = cells.firstIndex { $0.state == .empty }
        guard var cellIndex = startIndex else {
            return
        }
        
        for photo in photos {
            let indexPath = IndexPath(row: cellIndex, section: 0)
            let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell
            
            cell?.uploadImage(image: photo)
            
            cellIndex = cellIndex + 1
        }
    }
    
    // Collection View
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    
        setupFlowLayoutDelegate()
        
        collectionView.reloadData()
    }
    
    func setupFlowLayoutDelegate() {
        guard let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        let numberOfCellsPerRow: CGFloat = 3
        
        let cellHorizontalSpacing = flowLayout.minimumInteritemSpacing * numberOfCellsPerRow
        let sectionSpacing = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let totalHorizontalSpacing = cellHorizontalSpacing + sectionSpacing
        
        let cellWidth = (view.frame.width - totalHorizontalSpacing) / numberOfCellsPerRow
        let cellHeight = (cellWidth * 60) / 110
        
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
    }
}
