//
//  LMPostWidgetTableViewCell.swift
//  LMFramework
//
//  Created by Devansh Mohata on 17/12/23.
//

import UIKit

@IBDesignable
open class LMPostWidgetTableViewCell: LMTableViewCell {
    // MARK: UI Elements
    open private(set) lazy var headerView: LMFeedPostHeaderView = {
        let view = Components.shared.headerCell.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    open private(set) lazy var footerView: LMFeedPostFooterView = {
        let view = Components.shared.footerCell.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    open private(set) lazy var postText: LMTextView = {
        let label = LMTextView().translatesAutoresizingMaskIntoConstraints()
        label.textContainer.maximumNumberOfLines = 0
        label.isScrollEnabled = false
        label.isUserInteractionEnabled = true
        label.isEditable = false
        label.isSelectable = false
        label.font = Appearance.shared.fonts.textFont1
        label.textColor = Appearance.shared.colors.textColor
        label.backgroundColor = .clear
        return label
    }()
    
    
    // MARK: Data Variables
    weak var actionDelegate: LMFeedTableCellToViewControllerProtocol?
    var userUUID: String?
    var postID: String?
    
    // MARK: setupActions
    open override func setupActions() {
        super.setupActions()
        headerView.delegate = self
        footerView.delegate = self
        postText.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedTextView)))
    }
    
    @objc
    open func tappedTextView(tapGesture: UITapGestureRecognizer) {
        guard let textView = tapGesture.view as? LMTextView,
              let position = textView.closestPosition(to: tapGesture.location(in: textView)),
              let text = textView.textStyling(at: position, in: .forward) else { return }
        if let url = text[.link] as? URL {
            didTapURL(url: url)
        } else if let hashtag = text[.hashtags] as? String {
            didTapHashTag(hashtag: hashtag)
        } else if let route = text[.route] as? String {
            didTapRoute(route: route)
        } else {
            didTapPostText()
        }
    }
    
    open func didTapURL(url: URL) {
        UIApplication.shared.open(url)
    }
    
    open func didTapHashTag(hashtag: String) { }
    
    open func didTapRoute(route: String) { }
    
    open func didTapPostText() { }
}


// MARK: LMFeedPostHeaderViewProtocol
@objc
extension LMPostWidgetTableViewCell: LMFeedPostHeaderViewProtocol {
    open func didTapProfilePicture() { 
        guard let userUUID else { return }
        actionDelegate?.didTapProfilePicture(for: userUUID)
    }
    
    open func didTapMenuButton() {
        guard let postID else { return }
        actionDelegate?.didTapMenuButton(for: postID)
    }
}


// MARK: LMFeedPostFooterViewProtocol
@objc
extension LMPostWidgetTableViewCell: LMFeedPostFooterViewProtocol {
    open func didTapLikeButton() {
        guard let postID else { return }
        actionDelegate?.didTapLikeButton(for: postID)
    }
    
    open func didTapLikeTextButton() {
        guard let postID else { return }
        actionDelegate?.didTapLikeTextButton(for: postID)
    }
    
    open func didTapCommentButton() { 
        guard let postID else { return }
        actionDelegate?.didTapCommentButton(for: postID)
    }
    
    open func didTapShareButton() {
        guard let postID else { return }
        actionDelegate?.didTapShareButton(for: postID)
    }
    
    open func didTapSaveButton() { 
        guard let postID else { return }
        actionDelegate?.didTapSaveButton(for: postID)
    }
}


// MARK: LMTappableLabelDelegate
@objc
extension LMPostWidgetTableViewCell: LMTappableLabelDelegate {
    func didTapOnLink(_ link: String, linkType: NSAttributedString.Key) { }
}


// MARK: LMTableCellToViewController
public protocol LMFeedTableCellToViewControllerProtocol: AnyObject {
    func didTapProfilePicture(for uuid: String)
    func didTapMenuButton(for postID: String)
    func didTapLikeButton(for postID: String)
    func didTapLikeTextButton(for postID: String)
    func didTapCommentButton(for postID: String)
    func didTapShareButton(for postID: String)
    func didTapSaveButton(for postID: String)
}
