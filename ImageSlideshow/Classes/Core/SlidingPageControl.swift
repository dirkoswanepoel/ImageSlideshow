//
//  SlidingPageControl.swift
//  ImageSlideshow
//
//  Created by Dirko Swanepoel on 2018/02/06.
//

import UIKit

@IBDesignable class SlidingPageControl: UIControl {

    private var _pageControl: UIPageControl = UIPageControl()
    private var _configured = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        update()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        update()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        update()
    }

    @IBInspectable open var currentPage: Int = 0 {
        didSet {
            _pageControl.numberOfPages = numberOfPages
            _pageControl.currentPage = currentPage
            update()
        }
    }
    @IBInspectable open var numberOfPages: Int = 3 {
        didSet {
            _pageControl.numberOfPages = numberOfPages
            _pageControl.currentPage = currentPage
            update()
        }
    }

    @IBInspectable open var pageIndicatorTintColor: UIColor? {
        didSet {
            _pageControl.pageIndicatorTintColor = pageIndicatorTintColor
        }
    }

    @IBInspectable open var currentPageIndicatorTintColor: UIColor? {
        didSet {
            _pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        }
    }

    override var clipsToBounds: Bool {
        didSet {
            _pageControl.clipsToBounds = false
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        update()
    }

    private func configure() {
        if !_configured {
            addSubview(_pageControl)
            _configured = true
            update()
        }
    }

    private func update() {
        if _configured {
            let superviewWidth = frame.width
            let requiredWidth = _pageControl.size(forNumberOfPages: numberOfPages).width
            if (superviewWidth - 16) < requiredWidth {
                let xRange = Double((superviewWidth - 16) - requiredWidth)
                let x = (Double(currentPage) / Double(numberOfPages - 1) * xRange) + 8
                UIView.animate(withDuration: 0.125) {
                    self._pageControl.frame = CGRect(x: CGFloat(x), y: self._pageControl.frame.origin.y, width: requiredWidth, height: self.frame.height)
                }
            }
            else {
                let x = (superviewWidth - requiredWidth) / 2
                _pageControl.frame = CGRect(x: CGFloat(x), y: _pageControl.frame.origin.y, width: requiredWidth, height: frame.height)
            }
        }
    }
}

