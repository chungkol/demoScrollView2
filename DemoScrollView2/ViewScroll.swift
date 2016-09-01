

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate {
    var photo: [UIImageView] = []
    
    var frontScrollViews: [UIScrollView] = []
    
    @IBOutlet weak var btnPre: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var first = false
    var currentPage = 0
    var pageImages: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        pageImages = ["shop1","shop2","shop3","shop4"]
        pageController.currentPage = currentPage
        pageController.numberOfPages = pageImages.count
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 2
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (!first) {
            first = true
            let pagesScrollViewSize = scrollView.frame.size
            
            scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), 0)
            scrollView.contentOffset = CGPointMake(CGFloat(currentPage) * scrollView.frame.size.width, 0)
            
            for (var i = 0; i < pageImages.count; i++){
                let imgView = UIImageView(image: UIImage(named: pageImages[i]+".jpg"))
                imgView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)
                imgView.contentMode = .ScaleAspectFill
                
                photo.append(imgView)
                
                imgView.userInteractionEnabled = true
                imgView.multipleTouchEnabled = true
                
                //su kien tap
                let tap = UITapGestureRecognizer(target: self, action: #selector(ViewScroll.tapImg(_:)))
                tap.numberOfTapsRequired = 1
                imgView.addGestureRecognizer(tap)
                
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(ViewScroll.doubleTab(_:)))
                doubleTap.numberOfTapsRequired = 2
                tap.requireGestureRecognizerToFail(doubleTap)
                imgView.addGestureRecognizer(doubleTap)
                //
                
                let frontScrollView = UIScrollView(frame: CGRectMake( CGFloat(i) * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height))
                frontScrollView.minimumZoomScale = 1
                frontScrollView.maximumZoomScale = 2
                frontScrollView.delegate = self
                frontScrollView.addSubview(imgView)
                frontScrollViews.append(frontScrollView)
                scrollView.backgroundColor = UIColor.brownColor()
                self.scrollView.addSubview(frontScrollView)
                
            }
            
        }
        //
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        print( pageController.currentPage)
        return photo[pageController.currentPage]
    }
    func tapImg(gesture: UITapGestureRecognizer){
        let position = gesture.locationInView(photo[pageController.currentPage])
        zoomRectForScale(frontScrollViews[pageController.currentPage].zoomScale * 1.5, center: position)
        
    }
    func doubleTab(gesture: UITapGestureRecognizer){
        let position = gesture.locationInView(photo[pageController.currentPage])
        zoomRectForScale(frontScrollViews[pageController.currentPage].zoomScale * 0.5, center: position)
    }
    
    func zoomRectForScale(scale: CGFloat , center: CGPoint){
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        
        print(zoomRect)
        frontScrollViews[pageController.currentPage].zoomToRect(zoomRect, animated: true)
    }
    
    
    @IBAction func pageChange(sender: UIPageControl) {
        scrollView.contentOffset = CGPointMake(CGFloat(pageController.currentPage) * scrollView.frame.size.width, 0)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageController.currentPage = Int(pageNumber)
        //        print(pageNumber)
    }

    @IBAction func next(sender: UIButton) {
        var current = pageController.currentPage
        if (current < pageImages.count - 1) {
            current = current + 1
            scrollView.contentOffset = CGPointMake(CGFloat(current) * scrollView.frame.size.width, 0)
            pageController.currentPage = current
        }
        print(current)
    }
    @IBAction func previous(sender: UIButton) {
        var current = pageController.currentPage
        if current == 0 {
            btnPre.hidden = true
        }
        if (current > 0) {
            current = current - 1
            scrollView.contentOffset = CGPointMake(CGFloat(current) * scrollView.frame.size.width, 0)
            pageController.currentPage = current
        }
        print(current)
    }
    
}
