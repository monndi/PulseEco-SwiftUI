import SwiftUI
import Combine

struct ExpandableView: View {
    @State var isExpanded = false
    @State var width: CGFloat = 140
    var averageVM: AverageVM
    @State var value: Float
    @State var geometry: GeometryProxy
    var body: some View {
        HStack {
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    RoundedCorners(tl: 8, tr: 8, bl: 0, br: 0)
                        .fill(Color(UIColor(white: 0, alpha: 0.3)))
                        .frame(height:  25)
                        .overlay( Text("Average")
                            .foregroundColor(Color.white)
                            .padding(.leading, 10), alignment: .leading
                    )
                    HStack(alignment: .top) {
                        VStack {
                            HStack {
                                Text("\(Int(self.averageVM.value))").font(.system(size: 35)).foregroundColor(Color.white)
                                Text(self.averageVM.unit).foregroundColor(Color.white).padding(.top, 15)
                            }.padding(.leading, 10)
                            Spacer().frame(height: 10) }
                        if self.isExpanded {
                            VStack {
                                Text(self.averageVM.message).font(.system(size: 17)).foregroundColor(Color.white).padding(.leading, 10)
                                Spacer().frame(height: 10)
                            }
                        }
                    }
                    if self.isExpanded {
                        HStack(alignment: .bottom, spacing: 0) {
                            if self.averageVM.bands.count != 0 {
                                ForEach(0...self.averageVM.bands.count - 1, id: \.self) { indx in
                                    ZStack {
                                        RoundedCorners(tl: 0, tr: 0, bl: indx == 0 ? 8 : 0, br: indx == self.averageVM.bands.count - 1 ? 8 : 0).fill(Color(self.averageVM.bands[indx].legendColor)).frame(width: CGFloat((self.averageVM.bands[indx].width) * Double(self.width) / 100), height: 6, alignment: .bottom)
                                        if self.averageVM.currBand === self.averageVM.bands[indx] {
                                            Slider(value: self.$value).frame(height:4).accentColor(Color.clear)
                                        }
                                    }
                                }
                            }
                        }.frame(height: 6)
                    }
                }.frame(width: self.width)
                    .background(RoundedCorners(tl: 8, tr: 8, bl: 8, br: 8)
                        .fill(Color(self.averageVM.colorForValue())))
                    .onTapGesture {
                        self.isExpanded.toggle()
                        self.width = self.isExpanded ? self.geometry.frame(in: .local).midX * 1.8 : 140
                }.padding(.top, 20)
                    .animation(.easeIn)
                Spacer()
            }
            Spacer()
        }.padding(.leading, 20)
    }
}

struct SliderCircle: View {
    @State var color: Color
    var body: some View {
        Circle().fill(color).frame(width: 15, height: 15)
    }
}
