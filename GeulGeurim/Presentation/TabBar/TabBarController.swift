//
//  TabBarController.swift
//  GeulGeurim
//
//  Created by HUNHEE LEE on 27.05.2024.
//

import UIKit

final class TabBarController: UITabBarController {
  private let tabBarControllers: [TabBarItemType: UINavigationController]
  
  init(tabBarControllers: [TabBarItemType : UINavigationController]) {
    self.tabBarControllers = tabBarControllers
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print("해제됨: TabBarController")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpTabBar()
  }
  
  /// 탭바 설정 메소드
  private func setUpTabBar() {
    self.tabBar.tintColor = UIColor.primary
    
    let navigationControllers = TabBarItemType.allCases.map { item -> UINavigationController in
      guard let tab = tabBarControllers[item] else {
        fatalError()
      }
      
      if let defaultImage = item.tabIconImage {
        tab.tabBarItem.image = defaultImage
      }
      tab.tabBarItem.title = item.title
      return tab
    }
    
    viewControllers = navigationControllers
  }
}