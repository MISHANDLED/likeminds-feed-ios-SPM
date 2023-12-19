//
//  LMFeedPostImageCollectionCell.swift
//  LMFramework
//
//  Created by Devansh Mohata on 01/12/23.
//

import UIKit

@IBDesignable
open class LMFeedPostImageCollectionCell: LMCollectionViewCell {
    public struct ViewModel: LMFeedMediaProtocol {
        let image: String
        let bundle: Bundle?
        
        public init(image: String, bundle: Bundle? = nil) {
            self.image = image
            self.bundle = bundle
        }
    }
    
    open private(set) var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    // MARK: View Hierachy
    public override func setupViews() {
        contentView.addSubview(imageView)
    }
    
    // MARK: Constraints
    public override func setupLayouts() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    open func configure(with data: ViewModel) {
        imageView.image = UIImage(named: data.image, in: data.bundle, with: nil)
    }
}
