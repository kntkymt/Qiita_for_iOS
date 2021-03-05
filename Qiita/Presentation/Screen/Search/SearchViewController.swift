//
//  SearchViewController.swift
//  Qiita
//
//  Created by kntk on 2019/09/28.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import ReusableKit

enum SearchType {
    case word(String)
    case tag(ItemTag)
}

final class SearchViewController: UIViewController {

    enum Reusable {
        static let titleCell = ReusableCell<TitleCell>(nibName: "TitleCell")
        static let searchWordCell = ReusableCell<SearchWordCell>(nibName: "SearchWordCell")
        static let searchTagCell = ReusableCell<SearchTagCell>(nibName: "SearchTagCell")
    }

    // MARK: - Outlet

    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = collectionViewLayout
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(Reusable.titleCell)
            collectionView.register(Reusable.searchWordCell)
            collectionView.register(Reusable.searchTagCell)
        }
    }

    // MARK: - Property

    lazy var sections: [CollectionSection] = [
        TitleSection(title: "キーワード検索"),
        SearchWordsSection(words: [
            "Firebase", "ARKit", "GitHub", "iPadOS", "ライブラリ", "iOS13", "SwiftUI", "MacOS"
        ]),
        TitleSection(title: "タグ検索"),
        SearchTagListSection()
    ]

    lazy var collectionViewLayout: UICollectionViewLayout = {
        var sections = self.sections
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return sections[sectionIndex].layoutSection(based: self.view)
        }
        return layout
    }()

    private var searchTagList: [ItemTag] = [] {
        didSet {
            collectionView.reloadSections(IndexSet(integer: 3))
        }
    }

    private var tagService: TagService!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true
        setInitialTags()
    }

    // MARK: - Private

    private func setInitialTags() {
        tagService.getTags(page: 1, perPage: 30, sort: "count")
            .done { tags in
                self.searchTagList = tags
            }.catch { error in
                Logger.error(error)
            }
    }

    private func search(with type: SearchType) {
        let viewController = SearchResultViewController(with: type)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Property

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let word = searchBar.text else { return }
        search(with: .word(word))
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

// MARK: - Storyboardable

extension SearchViewController: Storyboardable {

    func inject(_ dependency: ()) {
        self.tagService = TagService()
    }
}

// MARK: - UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 2:
            return sections[section].numberOfItems

        case 3:
            return searchTagList.count

        default:
            fatalError()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0, 1, 2:
            return sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath)

        case 3:
            let cell = collectionView.dequeue(Reusable.searchTagCell, for: indexPath, with: searchTagList[indexPath.row])
            return cell

        default:
            fatalError()
        }
    }
}

// MARK: - UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            if let section = sections[indexPath.section] as? SearchWordsSection {
                search(with: SearchType.word(section.words[indexPath.row]))
            }

        case 3:
            if let section = sections[indexPath.section] as? SearchTagListSection {
                search(with: SearchType.tag(searchTagList[indexPath.row]))
            }

        default:
            return
        }
    }
}
