//
//  KingfisherSource.swift
//  ImageSlideshow
//
//  Created by feiin
//
//

import Kingfisher

/// Input Source to image using Kingfisher
public class KingfisherSource: NSObject, InputSource {
    /// the caption for the image
    public private(set) var caption: String?
    /// url to load
    public var url: URL

    /// placeholder used before image is loaded
    public var placeholder: UIImage?
    
    /// options for displaying, ie. [.transition(.fade(0.2))]
    public var options: KingfisherOptionsInfo?

    /// Initializes a new source with a URL
    /// - parameter url: a url to be loaded
    /// - parameter placeholder: a placeholder used before image is loaded
    /// - parameter options: options for displaying
    /// - parameter caption: Caption for the image
    public init(url: URL, placeholder: UIImage? = nil, options: KingfisherOptionsInfo? = nil, caption: String? = nil) {
        self.url = url
        self.placeholder = placeholder
        self.options = options
        self.caption = caption
        super.init()
    }

    /// Initializes a new source with a URL string
    /// - parameter urlString: a string url to load
    /// - parameter placeholder: a placeholder used before image is loaded
    /// - parameter options: options for displaying
    /// - parameter caption: Caption for the image
    public init?(urlString: String, placeholder: UIImage? = nil, options: KingfisherOptionsInfo? = nil, caption: String? = nil) {
        guard let validUrl = URL(string: urlString) else {
            return nil
        }
        self.url = validUrl
        self.placeholder = placeholder
        self.options = options
        self.caption = caption
        super.init()
    }

    @objc public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        imageView.kf.setImage(with: self.url, placeholder: self.placeholder, options: self.options, progressBlock: nil) { (image, _, _, _) in
            callback(image)
        }
    }
    
    public func cancelLoad(on imageView: UIImageView) {
        imageView.kf.cancelDownloadTask()
    }
}
