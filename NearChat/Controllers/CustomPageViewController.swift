//
//  CustomPageViewController.swift
//  NearChat
//
//  Created by Pau Enrech on 12/07/2019.
//  Copyright © 2019 Pau Enrech. All rights reserved.
//

import UIKit

//Esta clase es la encargada de gestionar los diferentes page controller de 2 elementos que permiten cambiar entre la vista mapa
//O la vista listada, ya sea lista o chat
//Implementa todos los delegados necesarios para detectar todos los cambios del page controller
class CustomPageViewController: UIPageViewController, UIPageViewControllerDelegate ,UIPageViewControllerDataSource, UIScrollViewDelegate, PageChangedPageControllerProtrocol {
    
    //MARK: - variables
    
    //Aquí se definen cuales son los dos viewcontrollers anidados en este page controller
    @IBInspectable var mapViewControllerID: String = ""
    @IBInspectable var listViewControllerID: String = ""

    var viewControllerList: [UIViewController] = []
    
    var scrollView: UIScrollView? = nil
    
    var currentPage: Int = 0 {
        didSet{
            print("Current Page: \(currentPage)")
        }
    }
    
    weak var scrollViewDelegate: ScrollFromPageChange? = nil
    
    //MARK: - métodos vista
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPager()
        
        view.subviews.forEach { (subView) in
            if let scrollView = subView as? UIScrollView {
                self.scrollView = scrollView
            }
        }
        
        self.dataSource = self
        self.delegate = self
        
        for subview in self.view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.delegate = self
                break
            }
        }
        
        let bgView = UIView(frame: UIScreen.main.bounds)
        bgView.backgroundColor = UIColor.defaultLightBlue
        view.insertSubview(bgView, at: 0)
    }
    
    //MARK: -  métodos cambio de página
    
    //Este método permite cambiar de una página a la otro del pager
    func changePageTo(){
        
        if currentPage == 0 {
            guard let secondViewController = viewControllerList.last else { return }
            self.setViewControllers([secondViewController], direction: .forward, animated: true) { (completado) in
                if completado{
                    
                }
            }
        } else {
            guard let firstViewController = viewControllerList.first else { return }
            self.setViewControllers([firstViewController], direction: .reverse, animated: true) { (completado) in
                if completado {
                    
                }
            }
        }
    }
    
    //Este métodos se asegura que se mantenga la página actual su interfaz del toolbar correspondiente de forma
    //Correcta en caso de un cambio de tab mientras se está realizando una animación de cambio de página
    func setPageAfterTabChange(){
        if currentPage == 0 && viewControllers?.first != viewControllerList.first {
            guard let secondViewController = viewControllerList.last else { return }
            self.setViewControllers([secondViewController], direction: .forward, animated: false, completion: nil)
            DispatchQueue.global().async {
                self.scrollViewDelegate?.scrollChangeToPercentage(percentage: 1.0)
            }
        } else if currentPage == 1 && viewControllers?.last != viewControllerList.last {
            guard let firstViewController = viewControllerList.first else { return }
            self.setViewControllers([firstViewController], direction: .reverse, animated: false, completion: nil)
            DispatchQueue.global().async {
                self.scrollViewDelegate?.scrollChangeToPercentage(percentage: 0.0)
            }
        }
    }
    
    //Este método le permite determinar al pager cual es el siguiente controller a mostrar si se mueve en direccion izquierda a derecha
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        
        guard viewControllerList.count > previousIndex else {return nil}
        
        return viewControllerList[previousIndex]
    }
    
    //Este método le permite determinar al pager cual es el siguiente controller a mostrar si se mueve en direccion derecha a izquierda
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        guard viewControllerList.count != nextIndex else {return nil}
        
        guard viewControllerList.count > nextIndex else { return nil }
        
        return viewControllerList[nextIndex]
    }
    
    //MARK: - métodos de inicialización del pager
    
    //Este método inicializa los diferentes controlladores del pager y el pager
    func setUpPager() {
        let mapVc = self.storyboard?.instantiateViewController(withIdentifier: mapViewControllerID)
        let listVc = self.storyboard?.instantiateViewController(withIdentifier: listViewControllerID)
        
        setPositionAndDelegate(rawViewController: mapVc)
        setPositionAndDelegate(rawViewController: listVc)
        
        if let firstViewController = viewControllerList.first{
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    //Este método inicializa los delegados de cambio de página y la posición de los diferentes controlles del pager.
    //Ya que se trata de una clase "genérica" usado por diferentes pager, se incluyen todas las posibilidades
    //de cada uno de estos pager
    func setPositionAndDelegate(rawViewController: UIViewController?) {
        guard let Vc = rawViewController else { return }
        
        if let Vc = Vc as? HomeMapViewController {
            Vc.position = 0
            Vc.pageChangeDelegate = self
            viewControllerList.append(Vc)
        }
        if let Vc = Vc as? HomeListViewController {
            Vc.position = 1
            Vc.pageChangeDelegate = self
            viewControllerList.append(Vc)
        }
        if let Vc = Vc as? EventMapViewController {
            Vc.position = 0
            Vc.pageChangeDelegate = self
            viewControllerList.append(Vc)
        }
        if let Vc = Vc as? EventChatViewController {
            Vc.position = 1
            Vc.pageChangeDelegate = self
            viewControllerList.append(Vc)
        }
    }
    
    //MARK: - métodos del scrollview del page controller
    
    //Esta método realiza dos funciones principales
    //Por un lado, se realiza un calculo para determinar cual es la posición relativa del offset del scroll
    //en función al ancho de la pantalla.
    //Esta posición se envia a la función que anima los diferentes elementos del custom toolbar
    //Por otro lado, es uno de los 2 métodos que impide el page controller realice su bounce scroll por defecto
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let screenWidth = view.bounds.width
        var percentage: CGFloat = 0
        
        if (currentPage == 0) {
            percentage = (scrollView.contentOffset.x - screenWidth) / screenWidth
        } else {
            percentage = scrollView.contentOffset.x / screenWidth
        }
        
        percentage = max(min(percentage, 1.0), 0.0)
        
        DispatchQueue.global().async {
            self.scrollViewDelegate?.scrollChangeToPercentage(percentage: percentage)
        }
        
        if (currentPage == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width) {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0);
        } else if (currentPage == viewControllerList.count - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width) {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0);
        }
        
    }
    
    //Este método es una de los 2 métodos que impide que el page controller realice su bounce scroll por defecto
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
 
        if (currentPage == 0 && scrollView.contentOffset.x <= scrollView.bounds.size.width) {
            targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0);
        } else if (currentPage == viewControllerList.count - 1 && scrollView.contentOffset.x >= scrollView.bounds.size.width) {
            targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0);
        }
    }
    
    //MARK: - métodos delegados
    
    //Este método delegado cambia la variable de página actual siempre que se carga un controller nuevo anidado en el page controller
    func pageChangedTo(page: Int) {
        currentPage = page
   
    }

    
}

