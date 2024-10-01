import SwiftUI
import UniformTypeIdentifiers
import PDFKit


@main
struct PDFViewerApp: App {
    
    // Taken from:
    // https://developer.apple.com/documentation/swiftui/documentgroup
    
    var body: some Scene {
        DocumentGroup(viewing: PDFViewer.PDFDocument.self) {
            ContentView(document: $0.document,
                        fileURL:  $0.fileURL)
        }
    }
}
