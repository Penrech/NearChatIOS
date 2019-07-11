//
//  HomePageViewController.swift
//  NearChat
//
//  Created by Pau Enrech on 10/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

class HomePageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    let mapViewControllerID = "homeMapViewController"
    let listViewControllerID = "homeListViewController"
    
    var viewControllerList: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpPager()
    }
    
    func setUpPager() {
        let mapVc = self.storyboard?.instantiateViewController(withIdentifier: mapViewControllerID)
        let listVc = self.storyboard?.instantiateViewController(withIdentifier: listViewControllerID)
        
        viewControllerList = [mapVc!, listVc!]
        
        if let firstViewController = viewControllerList.first{
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        
        guard viewControllerList.count > previousIndex else {return nil}
        
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        guard viewControllerList.count != nextIndex else {return nil}
        
        guard viewControllerList.count > nextIndex else { return nil }
        
        return viewControllerList[nextIndex]
    }

    
}
