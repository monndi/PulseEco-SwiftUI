import SwiftUI

struct DisabledView: View {
    var body: some View {
        HStack {
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    ZStack {
                        VStack {
                            RoundedCorners(tl: 8, tr: 8, bl: 0, br: 0)
                                .fill(Color(#colorLiteral(red: 0.4441046119, green: 0.4441156983, blue: 0.4441097379, alpha: 1)))
                                .frame(height:  23)
                            Spacer()
                        }
                        VStack(alignment: .center, spacing: 3) {
                            Image(uiImage: UIImage(named: "exclamation")!)
                            Text("No readings").foregroundColor(Color.white).padding(.bottom, 3)
                        }.padding(.top, 3)
                    }
                }.frame(width: 125, height: 75)
                    .background(RoundedCorners(tl: 8, tr: 8, bl: 8, br: 8)
                        .fill(Color(#colorLiteral(red: 0.4441046119, green: 0.4441156983, blue: 0.4441097379, alpha: 1)))) //#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                    .padding(.top, 20)
                Spacer()
            }
            Spacer()
        }.padding(.leading, 20)
    }
}

