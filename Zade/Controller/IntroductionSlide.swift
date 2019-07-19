//
//  ViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 08/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit

class IntroductionSlide: UIViewController,UIScrollViewDelegate{
    

  var slides:[Slide] = [];
    
    
    @IBOutlet weak var scrollViewSlide: UIScrollView!{
        didSet{
    scrollViewSlide.delegate = self
    }
}
    
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
       self.scrollViewSlide.contentSize.height = 1.0
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    @IBAction func skipPressed(_ sender: UIButton) {
        

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let LoginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(LoginViewController, animated:true, completion:nil)
        
//        let login = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//
//        self.navigationController?.pushViewController(login, animated: true)
        
//        let login = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
//        self.navigationController?.pushViewController(login, animated: true)
      
    }
    
func createSlides() -> [Slide] {
    
    let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
    slide1.slideImages.image = UIImage(named: "Walkthrough #1")
    slide1.detailLabel.text = "The Skinny on Lcd Monitors"
    slide1.descriptionLabel.text = "Addication When Gambling Becomes a Problem "
    
    let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
    slide2.slideImages.image = UIImage(named: "fashion")
    slide2.detailLabel.text = "Fashions Of all Time"
     slide2.descriptionLabel.text = "In this world of fashion You must Follow the Trend"
    
    
    let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
    slide3.slideImages.image = UIImage(named: "lifestyle")
  
    slide3.detailLabel.text = "live Your Life Enjoyable"
     slide3.descriptionLabel.text = "Checkout Lifestyle hack From our App"
    
    
    let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
    slide4.slideImages.image = UIImage(named: "travel")

    slide4.detailLabel.text = "Travel the Beautiful Place"
    
     slide4.descriptionLabel.text = "Travel the world and Post your Favourite Place Here "
    
    
    let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
    slide5.slideImages.image = UIImage(named: "friends")
    slide5.detailLabel.text = "Make a Friend on Our App"
     slide5.descriptionLabel.text = "Making a Friend is now easy with our App"
    
    return [slide1, slide2, slide3, slide4, slide5]
}


func setupSlideScrollView(slides : [Slide]) {
    scrollViewSlide.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    scrollViewSlide.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
    scrollViewSlide.isPagingEnabled = true
    
    for i in 0 ..< slides.count {
        slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
        scrollViewSlide.addSubview(slides[i])
    }
}


/*
 * default function called when view is scolled. In order to enable callback
 * when scrollview is scrolled, the below code needs to be called:
 * slideScrollView.delegate = self or
 */
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
    pageControl.currentPage = Int(pageIndex)
    
    let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
    let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
    
    // vertical
    let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
    let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
    
    let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
    let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
    
    
    /*
     * below code changes the background color of view on paging the scrollview
     */
    //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
    
    
    /*
     * below code scales the imageview on paging the scrollview
     */
    let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
    
    if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
        
        slides[0].slideImages.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
        slides[1].slideImages.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
        
    } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
        slides[1].slideImages.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
        slides[2].slideImages.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
        
    } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
        slides[2].slideImages.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
        slides[3].slideImages.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
        
    } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
        slides[3].slideImages.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
        slides[4].slideImages.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
    }
}




func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
    if(pageControl.currentPage == 0) {
        //Change background color to toRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1
        //Change pageControl selected color to toRed: 103/255, toGreen: 58/255, toBlue: 183/255, fromAlpha: 0.2
        //Change pageControl unselected color to toRed: 255/255, toGreen: 255/255, toBlue: 255/255, fromAlpha: 1
        
        let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
        pageControl.pageIndicatorTintColor = pageUnselectedColor
        
        
        let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
        slides[pageControl.currentPage].backgroundColor = bgColor
        
        let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
        pageControl.currentPageIndicatorTintColor = pageSelectedColor
    }
}


func fade(fromRed: CGFloat,
          fromGreen: CGFloat,
          fromBlue: CGFloat,
          fromAlpha: CGFloat,
          toRed: CGFloat,
          toGreen: CGFloat,
          toBlue: CGFloat,
          toAlpha: CGFloat,
          withPercentage percentage: CGFloat) -> UIColor {
    
    let red: CGFloat = (toRed - fromRed) * percentage + fromRed
    let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
    let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
    let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
    
    // return the fade colour
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}

}

