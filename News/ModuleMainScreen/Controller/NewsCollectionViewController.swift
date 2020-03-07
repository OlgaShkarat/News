//
//  ViewController.swift
//  News
//
//  Created by Ольга on 03.03.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import UIKit
import MaterialComponents
import SafariServices

class NewsCollectionViewController: UICollectionViewController {
    
    var mainHeaderView = HeaderView()
    var appBar = MDCAppBar()
    let tabBar = MDCTabBar()
    var viewModel: NewsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NewsViewModel()
        configureAppBar()
        configureTabBar()
        updateView()
        
        let cellNib = UINib(nibName: "NewsCell", bundle: .main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: NewsCell.cellID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    
    //MARK: - Custom methods
    
    func updateView() {
        guard let selectedItem = tabBar.selectedItem else { return }
        let source = NewsSource.allValues[selectedItem.tag]
        viewModel?.fetchData(source: source, completion: { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        })
    }
    
    func configureTabBar() {
        tabBar.itemAppearance = .titles
        tabBar.items = NewsSource.allValues.enumerated().map { index, source in
            return UITabBarItem(title: source.title, image: nil, tag: index)
        }
        tabBar.selectedItem = tabBar.items[0]
        tabBar.alignment = .justified
        tabBar.selectedItemTitleFont = UIFont.boldSystemFont(ofSize: 18)
        tabBar.unselectedItemTitleFont = UIFont.boldSystemFont(ofSize: 18)
        tabBar.delegate = self
        appBar.headerStackView.bottomBar = tabBar
    }
    
    
    func configureAppBar() {
        addChild(appBar.headerViewController)
        appBar.navigationBar.backgroundColor = .clear
        appBar.navigationBar.title = nil
        
        let headerView = appBar.headerViewController.headerView
        headerView.backgroundColor = .clear
        headerView.maximumHeight = 100
        headerView.minimumHeight = 100
        mainHeaderView.frame = headerView.bounds
        headerView.insertSubview(mainHeaderView, at: 0)
        
        headerView.trackingScrollView = collectionView
        appBar.addSubviewsToParent()
        
    }
    
    //MARK: - CollectionViewDelegate&UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.cellID, for: indexPath) as! NewsCell
        
        cell.newsViewModel = viewModel?.cellForItemAtIndexPath(atIndexPath: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = viewModel?.didSelectRow(atIndexPath: indexPath) else { return  }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let safariVC = SFSafariViewController(url: url, configuration: config)
        present(safariVC, animated: true, completion: nil)
        safariVC.dismissButtonStyle = .close
    }
}

//MARK: - UIScrollViewDelegate
extension NewsCollectionViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = appBar.headerViewController.headerView
        if scrollView == headerView.trackingScrollView {
            headerView.trackingScrollDidScroll()
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let headerView = appBar.headerViewController.headerView
        if scrollView == headerView.trackingScrollView {
            headerView.trackingScrollDidEndDecelerating()
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let headerView = appBar.headerViewController.headerView
        if scrollView == headerView.trackingScrollView {
            headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                            targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let headerView = appBar.headerViewController.headerView
        if scrollView == headerView.trackingScrollView {
            headerView.trackingScrollWillEndDragging(withVelocity: velocity,
                                                     targetContentOffset: targetContentOffset)
        }
    }
}
//MARK: - MDCTabBar
extension NewsCollectionViewController: MDCTabBarDelegate {
    
    func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
        updateView()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension NewsCollectionViewController: UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - (NewsCell.cellPadding * 2), height: NewsCell.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: NewsCell.cellPadding, left: NewsCell.cellPadding, bottom: NewsCell.cellPadding, right: NewsCell.cellPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return NewsCell.cellPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
