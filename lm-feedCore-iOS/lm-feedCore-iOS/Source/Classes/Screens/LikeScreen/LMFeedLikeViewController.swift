//
//  LMFeedLikeViewController.swift
//  Pods
//
//  Created by Devansh Mohata on 21/01/24.
//

import LikeMindsFeedUI
import UIKit

@IBDesignable
open class LMFeedLikeViewController: LMViewController {
    // MARK: UI Elements
    open private(set) lazy var memberListView: LMTableView = {
        let table = LMTableView().translatesAutoresizingMaskIntoConstraints()
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = Appearance.shared.colors.clear
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.bounces = false
        table.register(LMUIComponents.shared.likedUserTableCell)
        table.separatorStyle = .none
        return table
    }()
    
    // MARK: Data Variables
    public var viewModel: LMFeedLikeViewModel?
    public var userData: [LMFeedMemberItem.ViewModel] = []
    public var cellHeight: CGFloat = 72
    public var totalLikes: Int = 0
    
    
    // MARK: setupViews
    open override func setupViews() {
        super.setupViews()
        view.addSubview(memberListView)
    }
    
    
    // MARK: setupLayouts
    open override func setupLayouts() {
        super.setupLayouts()
        view.pinSubView(subView: memberListView)
    }
    
    
    // MARK: viewDidLoad
    open override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getLikes()
        setNavigationTitleAndSubtitle(with: "Likes", subtitle: "0 Likes", alignment: .center)
        
        view.backgroundColor = Appearance.shared.colors.white
        
        // Analytics
        LMFeedCore.analytics?.trackEvent(for: .postLikeListOpened, eventProperties: ["post_id": viewModel?.postID ?? ""])
    }
    
    open func didTapUser(uuid: String) {
        print(#function)
    }
}


// MARK: UITableView
extension LMFeedLikeViewController: UITableViewDataSource, UITableViewDelegate {
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userData.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let data = userData[safe: indexPath.row],
           let cell = tableView.dequeueReusableCell(LMUIComponents.shared.likedUserTableCell.self) {
            cell.configure(with: data) { [weak self] in
                self?.didTapUser(uuid: data.uuid)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == userData.count - 1 {
            viewModel?.getLikes()
        }
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { cellHeight }
}


// MARK: LMFeedLikeViewModelProtocol
extension LMFeedLikeViewController: LMFeedLikeViewModelProtocol {
    public func reloadTableView(with data: [LMFeedMemberItem.ViewModel], totalCount: Int) {
        userData = data
        memberListView.reloadData()
        totalLikes = totalCount
        setNavigationTitleAndSubtitle(with: "Likes",
                                      subtitle: "\(totalLikes) Like\(totalLikes == 1 ? "" : "s")",
                                      alignment: .center)
    }
    
    public func showHideTableLoader(isShow: Bool) {
        memberListView.showHideFooterLoader(isShow: isShow)
    }
}
