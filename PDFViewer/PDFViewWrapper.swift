import SwiftUI
import PDFKit

#if os(iOS)
    struct PDFViewWrapper: UIViewRepresentable {
        var pdfDocument: PDFKit.PDFDocument?
        var hash: Int?
        
        func makeUIView(context: Context) -> PDFView {
            let pdfView = PDFView()
            pdfView.autoScales = true
            
            pdfView.document = pdfDocument
            
            if hash != nil {
                NotificationCenter.default.addObserver(forName: .PDFViewPageChanged, object: pdfView, queue: .main) { notification in
                    if let pdfView = notification.object as? PDFView,
                       let currentPage = pdfView.currentPage,
                       let pdocument = pdfView.document {
                        UserDefaults.standard.set(pdocument.index(for: currentPage), forKey: String(hash!))
                    }
                }
                
                
                if let pdocument = pdfView.document {
                    let value = UserDefaults.standard.integer(forKey: String(hash!))
                    
                    if value > 0, let page = pdocument.page(at:value) {
                        // PDFView defaults to page index 0, delaying until after it appears
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            pdfView.go(to: page)
                        }
                    }
                }
            }
            
            return pdfView
        }

        func updateUIView(_ uiView: PDFView, context: Context) {}
    }

#elseif os(macOS)
    struct PDFViewWrapper: NSViewRepresentable {
        var pdfDocument: PDFKit.PDFDocument?
        var hash: Int?
        
        func makeNSView(context: Context) -> PDFView {
            let pdfView = PDFView()
            pdfView.autoScales = true
            
            pdfView.document = pdfDocument
            
            if hash != nil {
                NotificationCenter.default.addObserver(forName: .PDFViewPageChanged, object: pdfView, queue: .main) { notification in
                    if let pdfView = notification.object as? PDFView,
                       let currentPage = pdfView.currentPage,
                       let pdocument = pdfView.document {
                        UserDefaults.standard.set(pdocument.index(for: currentPage), forKey: String(hash!))
                    }
                }
                
                
                if let pdocument = pdfView.document {
                    let value = UserDefaults.standard.integer(forKey: String(hash!))
                    
                    if value > 0, let page = pdocument.page(at:value) {
                        // PDFView defaults to page index 0, delaying until after it appears
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            pdfView.go(to: page)
                        }
                    }
                }
            }
            
            return pdfView
        }

        func updateNSView(_ uiView: PDFView, context: Context) {}
    }

#endif
