//
//  SDWebImageSource.swift
//  ImageSlideshow
//
//  Created by Nik Kov on 06.07.16.
//
//

import SDWebImage

/// Input Source to image using SDWebImage
@objcMembers
public class SDWebImageSource: NSObject, InputSource {
    /// the caption for the image
    public private(set) var caption: String?
    /// url to load
    public var url: URL

    /// placeholder used before image is loaded
    public var placeholder: UIImage?

    /// Initializes a new source with a URL
    /// - parameter url: a url to be loaded
    /// - parameter placeholder: a placeholder used before image is loaded
    /// - parameter caption: Caption for the image
    public init(url: URL, placeholder: UIImage? = nil, caption: String? = nil) {
        self.url = url
        self.placeholder = placeholder
        self.caption = caption
        super.init()
    }

    /// Initializes a new source with a URL string
    /// - parameter urlString: a string url to load
    /// - parameter placeholder: a placeholder used before image is loaded
    /// - parameter caption: Caption for the image
    public init?(urlString: String, placeholder: UIImage? = nil, caption: String? = nil) {
        guard let validUrl = URL(string: urlString) else {
            return nil
        }
        self.url = validUrl
        self.placeholder = placeholder
        self.caption = caption
        super.init()
    }

    public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        imageView.sd_setImage(with: self.url, placeholderImage: self.placeholder, options: [], completed: { (image, _, _, _) in
            callback(image)
        })
    }
    
    public func cancelLoad(on imageView: UIImageView) {
        imageView.sd_cancelCurrentImageLoad()
    }
}
