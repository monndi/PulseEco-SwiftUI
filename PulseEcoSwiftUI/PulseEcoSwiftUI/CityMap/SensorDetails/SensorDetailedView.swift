import SwiftUI

struct SensorDetailedView: View {
    @State var isExpanded: Bool = false
    @EnvironmentObject var appVM: AppVM
    @State var collapsedViewSize: CGSize = .zero
    @State var expandedViewSize: CGSize = .zero
    
    var body: some View {
        
        VStack {
            ChildSizeReader(size: self.$collapsedViewSize) {
                CollapsedView(sensorDetailsVM: SensorDetailsVM(sensorID: self.appVM.sensorSelected!.sensorID)).padding(.top, 5)
            }
            if self.isExpanded {
                ChildSizeReader(size: self.$expandedViewSize) {
                    ExpandedView()
                }
            }
        }.background(RoundedCorners(tl: 40, tr: 40, bl: 0, br: 0).fill(Color(UIColor.white)))
            .offset(y: self.isExpanded ? UIHeight/2 - (self.expandedViewSize.height) + self.collapsedViewSize.height/2 : UIHeight/2 - (self.collapsedViewSize.height))
            .animation(.easeOut)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.height < 0 {
                            self.isExpanded = true
                        } else {
                            self.isExpanded = false
                        }
                }
        )
    }
}


struct LineGraph: Shape {
    var dataPoints: [CGFloat]
    
    func path(in rect: CGRect) -> Path {
        func point(at ix: Int) -> CGPoint {
            let point = dataPoints[ix]
            let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
            let y = (1-point) * rect.height
            return CGPoint(x: x, y: y)
        }
        
        return Path { p in
            guard dataPoints.count > 1 else { return }
            let start = dataPoints[0]
            p.move(to: CGPoint(x: 0, y: (1-start) * rect.height))
            for idx in dataPoints.indices {
                p.addLine(to: point(at: idx))
            }
        }
    }
}

struct ChildSizeReader<Content: View>: View {
    @Binding var size: CGSize
    let content: () -> Content
    var body: some View {
        ZStack {
            content()
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: SizePreferenceKey.self, value: proxy.size)
                    }
            )
        }
        .onPreferenceChange(SizePreferenceKey.self) { preferences in
            self.size = preferences
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero
    
    static func reduce(value _: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}
