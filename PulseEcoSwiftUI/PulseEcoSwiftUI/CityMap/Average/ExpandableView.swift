import SwiftUI

struct ExpandableView: View {
    @State var isExpanded = false
    @State var width: CGFloat = 125
    var averageVM: AverageVM
    @State var geometry: GeometryProxy
    var body: some View {
        HStack {
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    RoundedCorners(tl: 6, tr: 6, bl: 0, br: 0)
                        .fill(Color(red: 0.00, green: 0.39, blue: 0.00))
                        .frame(height:  25)
                        .overlay( Text("Average")
                            .foregroundColor(Color.white)
                            .padding(.leading, 10), alignment: .leading
                    )
                    HStack(alignment: .top) {
                        VStack {
                            HStack {
                                Text(self.averageVM.value!).font(.system(size: 35)).foregroundColor(Color.white)
                                Text(self.averageVM.unit).foregroundColor(Color.white).padding(.top, 15)
                            }.padding(.leading, 10)
                            Spacer().frame(height: 10) }
                        if self.isExpanded == true {
                            VStack {
                                Text(self.averageVM.message).font(.system(size: 17)).foregroundColor(Color.white).padding(.leading, 10)
                                Spacer().frame(height: 10)
                            }
                        }
                    }
                }.frame(width: self.width)
                .background(RoundedCorners(tl: 6, tr: 6, bl: 8, br: 8)
                .fill(self.averageVM.color))
                .onTapGesture {
                        self.isExpanded.toggle()
                        self.width = self.isExpanded ? self.geometry.frame(in: .local).midX * 1.8 : 140
                }.padding(.top, 20)
                    .animation(.default)
                Spacer()
            }
            Spacer()
        }.padding(.leading, 20)
    }
}
