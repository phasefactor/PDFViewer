# SwiftUI PDF Viewer
This works under macOS 15 / iOS 18 / Swift 6's concurrency requirements.

## Features
- Displays PDFs
- Remembers the current page based on the (hash of the) PDF's filename and path.


## TODO
- Add some logic to make macOS window sizes base themselves off the document's page size.


## Notes
- Implementation uses the viewer initializer for `DocumentGroup` and `ReferenceFileDocument` instead of the defaults from the editor style document app template.
- Still throws `Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.`, but this is being thrown from inside `DocumentGroup(viewing:viewer:)` so there is nothing I can do about it.
- Using `OSAllocatedUnfairLock` is probably overkill for a viewer app that will never write back to the file, but using Apple's example code was the low risk / low effort solution.
