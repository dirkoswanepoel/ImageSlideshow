//
//  InputSource.swift
//  ImageSlideshow
//
//  Created by Petr Zvoníček on 14.01.16.
//
//

import UIKit

/// A protocol that can be adapted by different Input Source providers
@objc public protocol InputSource {
    /**
     Load image from the source to image view.
     - parameter imageView: Image view to load the image into.
     - parameter callback: Callback called after image was set to the image view.
     - parameter image: Image that was set to the image view.
     */
    func load(to imageView: UIImageView, with callback: @escaping (_ image: UIImage?) -> Void)
    
    /**
     Cancel image load on the image view
     - parameter imageView: Image view that is loading the image
     */
    @objc optional func cancelLoad(on imageView: UIImageView)

    var caption: String? { get }
}

/// Input Source to load plain UIImage
@objcMembers
open class ImageSource: NSObject, InputSource {
    var image: UIImage!
    /// the caption for the image
    public private(set) var caption: String?

    /// Initializes a new Image Source with UIImage
    /// - parameter image: Image to be loaded
    /// - parameter caption: Caption for the image
    public init(image: UIImage, caption: String? = nil) {
        self.image = image
        self.caption = caption
    }

    /// Initializes a new Image Source with an image name from the main bundle
    /// - parameter imageString: name of the file in the application's main bundle
    /// - parameter caption: Caption for the image
    public init?(imageString: String, caption: String? = nil) {
        guard let image = UIImage(named: imageString) else {
            return nil
        }
        self.image = image
        self.caption = caption
        super.init()
    }

    public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        imageView.image = image
        callback(image)
    }
}
