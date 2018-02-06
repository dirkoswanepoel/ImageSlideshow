//
//  AFURLSource.swift
//  ImageSlideshow
//
//  Created by Petr Zvoníček on 30.07.15.
//

import AFNetworking

/// Input Source to image using AFNetworking
@objcMembers
public class AFURLSource: NSObject, InputSource {
    /// the caption for the image
    public private(set) var caption: String?
    /// url to load
    public var url: URL

    /// placeholder used before image is loaded
    public var placeholder: UIImage?

    /// Initializes a new source with URL and placeholder
    /// - parameter url: a url to load
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
        self.placeholder = placeholder
        self.url = validUrl
        self.caption = caption
        super.init()
    }

    public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        imageView.setImageWith(URLRequest(url: url), placeholderImage: self.placeholder, success: { (_, _, image: UIImage) in
            callback(image)
        }, failure: { _, _, _ in
            callback(self.placeholder)
        })
    }
    
    public func cancelLoad(on imageView: UIImageView) {
        imageView.cancelImageDownloadTask()
    }
}
