//
//  AppImageSlider.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 10/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import ImageSlideshow

class ImageSlider: ImageSlideshow {
    
    @IBOutlet weak var parentViewController: UIViewController?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    // MARK: Functions
    
    func commonInit() {
        contentScaleMode = .scaleAspectFit
        
        addPageIndicator()
        addTapGestureRecognizer()
    }
    
    func addPageIndicator() {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .lightGray
        
        pageIndicator = pageControl
    }
    
    func addTapGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ImageSlider.didTap))
        addGestureRecognizer(recognizer)
    }
    
    @objc
    func didTap() {
        guard let parent = parentViewController else {
            return
        }
        
        presentFullScreenController(from: parent)
    }
    
    func setImageUrls(_ imageUrls: [String]) {
        let source = imageUrls.compactMap { SDWebImageSource(urlString: $0) }
        setImageInputs(source)
    }
}
