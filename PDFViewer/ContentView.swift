import SwiftUI
import PDFKit

struct ContentView: View {
    var document: PDFViewer.PDFDocument
    var fileURL: URL?

    var body: some View {
        VStack {
            if let pdfDocument = PDFKit.PDFDocument(data: document.storage.withLock { $0.contents }) {
                PDFViewWrapper(pdfDocument: pdfDocument,
                               hash: fileURL != nil ? fileURL!.absoluteString.hashValue : nil)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("Unable to load PDF")
                    .foregroundColor(.red)
            }
        }
    }
}

/*
#Preview {
    ContentView(document: .constant(PDFViewerDocument()))
}
*/
