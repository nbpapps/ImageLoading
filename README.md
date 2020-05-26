# ImageLoading
A Swift Package for loading remote images.
Image loading and canceling is handled by extentions on ImageViews.
Includes caches for storing the key-value pairs of the images, the running tasks and the IDs assigned for each image view.


## Using it in your project.
```
- In Xcode navigate to File -> Swift Packages -> Add Package Dependency…
Enter this URL - https://github.com/nbpapps/ImageLoading 
```

**Setting an image in an ImageView:**
```swift
import UIKit
import ImageLoading

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell, let url = URL(string: "https://www.images.com/myImage") else {
            preconditionFailure()
        }
        cell.imageView?.loadImage(at: url)
    }
```

**Cancel  image loading:**
```swift
import UIKit
import ImageLoading

class MyCollectionViewCell: UICollectionViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.cancelImageLoad()
        myImageView.image = nil
    }
}
```

