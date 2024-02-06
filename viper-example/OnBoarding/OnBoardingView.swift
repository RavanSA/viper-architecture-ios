//
//  ViewController.swift
//  viper-example
//
//  Created by Revan Sadigli on 29.08.2023.
//

import UIKit

class OnBoardingView: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    var scrollOffset: CGFloat?
    var currentPage: Int = 0
    var scrollWidth: CGFloat! = 0.0

    typealias ScrollViewType = UIScrollView
    var lastContentOffset: CGPoint = .zero
    var scrollDirection: ScrollDirection = .none
    var scrollHeight: CGFloat! = 0.0

    var titles = ["Purchase Online", "Add to Basket", "Get your Order"]
    var descs = ["Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi", "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi", "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi"]
    var imgs = ["onboarding_2", "onboarding_2", "onboarding_3"]

    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()

        forwardBtn.backgroundColor = UIColor.black
        backBtn.backgroundColor = UIColor.black
        backBtn.layer.cornerRadius = 20
        forwardBtn.layer.cornerRadius = 20
        self.navigationController?.navigationBar.isHidden = true

        forwardBtn.addTarget(self, action: #selector(increasePage(_:)), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(decreasePage(_:)), for: .touchUpInside)

        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.insetsLayoutMarginsFromSafeArea = true
        scrollOffset = scrollWidth

        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

        for index in 0..<titles.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)

            let slide = UIView(frame: frame)

            let txt1 = UILabel.init(frame: CGRect(x: 30, y: 80, width: scrollWidth-64, height: 30))
            txt1.textAlignment = .left
            txt1.font = UIFont.boldSystemFont(ofSize: 20.0)
            txt1.text = titles[index]

            let txt2 = UILabel.init(frame: CGRect(x: 30, y: 120, width: scrollWidth-64, height: 70))
            txt2.textAlignment = .left
            txt2.numberOfLines = 4
            txt2.font = UIFont.systemFont(ofSize: 18.0)
            txt2.text = descs[index]

            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
            imageView.frame = CGRect(x: 30, y: 400, width: scrollWidth-64, height: scrollHeight-64)
            imageView.contentMode = .scaleAspectFit
            imageView.center = CGPoint(x: scrollWidth/2, y: scrollHeight/1.5)

            slide.addSubview(imageView)
            slide.addSubview(txt1)
            slide.addSubview(txt2)
            scrollView.addSubview(slide)
        }

        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)

        self.scrollView.contentSize.height = 1.0

        pageControl.numberOfPages = titles.count
        pageControl.currentPage = 0
    }

    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        if scrollDirection == .left && currentPage > 0 {
            currentPage -= 1
            scrollOffset = (currentPage == 1 ? 0 : (scrollOffset ?? 1) / 2)
        } else if scrollDirection == .right && currentPage < 2 {
            currentPage += 1
            scrollOffset = (scrollOffset ?? 1) * (currentPage <= 1 ? 2 : 1)
        }

        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage() {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }

    @objc func increasePage(_ sender: UIButton) {
        if currentPage <= 2 {
            setIndiactorForCurrentPage()
            if currentPage == 2 {
                performSegue(withIdentifier: "toAuthVC", sender: self)
            }

            let desiredOffset = CGPoint(x: scrollOffset ?? scrollWidth, y: 0)
            currentPage += 1
            scrollView.setContentOffset(desiredOffset, animated: true)
            scrollOffset = (scrollOffset ?? 1) * (currentPage <= 1 ? 2 : 1)
        }
    }

    @objc func decreasePage(_ sender: UIButton) {
        if currentPage >= 0 {

            setIndiactorForCurrentPage()
            scrollOffset = (currentPage == 1 ? 0 : (scrollOffset ?? 1) / 2)

            let desiredOffset = CGPoint(x: scrollOffset ?? scrollWidth, y: 0)
            scrollView.setContentOffset(desiredOffset, animated: true)
            currentPage -= 1
            if currentPage == 0 { scrollOffset = scrollWidth; return}
        }
    }

}

// https://stackoverflow.com/questions/31857333/how-to-get-uiscrollview-vertical-direction-in-swift
extension OnBoardingView {
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         if self.lastContentOffset.x > scrollView.contentOffset.x {
             scrollDirection = .left
         } else if self.lastContentOffset.x < scrollView.contentOffset.x {
             scrollDirection = .right
         }

         if self.lastContentOffset.y > scrollView.contentOffset.y {
             scrollDirection = .up
         } else if self.lastContentOffset.y < scrollView.contentOffset.y {
             scrollDirection = .down
         }
         self.lastContentOffset.x = scrollView.contentOffset.x
         self.lastContentOffset.y = scrollView.contentOffset.y
     }
 }
