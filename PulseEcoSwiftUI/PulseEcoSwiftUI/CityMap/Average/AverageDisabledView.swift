import SwiftUI

struct DisabledView: View {
    var body: some View {
        HStack {
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    ZStack {
                        VStack {
                            RoundedCorners(tl: 8, tr: 8, bl: 0, br: 0)
                                .fill(Color(AppColors.gray))
                                .frame(height:  25)
                            Spacer()
                        }
                        VStack(alignment: .center, spacing: 0) {
                            Image(uiImage: UIImage(named: "exclamation")!)
                            Text("No readings").foregroundColor(Color.white).padding(.bottom, 3)
                        }.padding(.top, 10)
                    }
                }.frame(width: 125, height: 75)
                    .background(RoundedCorners(tl: 8, tr: 8, bl: 8, br: 8)
                        .fill(Color(AppColors.blue)))
                    .padding(.top, 20)
                Spacer()
            }
            Spacer()
        }.padding(.leading, 20)
    }
}

