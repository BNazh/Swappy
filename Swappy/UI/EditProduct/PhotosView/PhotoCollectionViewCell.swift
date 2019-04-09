//
//  PhotoCollectionViewCell.swift
//  Swappy
//
//  Created by Mihail on 23/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit
import SwinjectStoryboard

// TODO: тоже рефакторинг вместе с PhotosViewController

protocol PhotoCellDelegate: class {
    func removeCell(_ cell: UICollectionViewCell)
}

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    var model: ImageModel? {
        didSet {
            didChangeModel()
        }
    }
    
    var delegate: PhotoCellDelegate?
    
    private let imageService = SwinjectStoryboard.defaultContainer.resolve(ImageService.self)!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressContainer: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        setState(.empty)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        setState(.empty)
    }
    
    func uploadImage(image: UIImage) {
        model?.image = image
        imageView.image = image
        setState(.loading)
        
        imageService.uploadImage(image, progressBlock: { [weak self] progress in
            self?.progressView.progress = Float(progress)
        }) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            if let url = result.value {
                strongSelf.model?.url = url
                strongSelf.setState(.loaded)
            } else {
                strongSelf.delegate?.removeCell(strongSelf)
            }
        }
    }
    
    
    
    @IBAction func closeTapped(_ sender: UIButton) {
        imageService.cancelCurrentOperation()
        
        delegate?.removeCell(self)
    }
}

private extension PhotoCollectionViewCell {
    
    func didChangeModel() {
        
        if let urlString = model?.url, model?.state == .loaded {
            imageView.sd_setImage(with: URL(string: urlString))
            setState(.loaded)
        }
    }
    
    func setState(_ state: ImageModel.State) {
        model?.state = state
        
        switch state {
        case .empty:
            model?.image = UIImage(named: "camera")
            imageView.image = UIImage(named: "camera")
            progressContainer.isHidden = true
            closeButton.isHidden = true
            
        case .fail:
            model?.image = UIImage(named: "camera")
            imageView.image = UIImage(named: "camera")
            progressContainer.isHidden = true
            closeButton.isHidden = true
            
        case .loaded:
            progressContainer.isHidden = true
            closeButton.isHidden = false
            
        case .loading:
            progressContainer.isHidden = false
            closeButton.isHidden = false
        }
    }
}
