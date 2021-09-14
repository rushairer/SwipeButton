import SwiftUI

struct SwipeButtonView<Content:View> : View {
    
    @Binding var offsetX : CGFloat
    @Binding var willAuto : Bool
    
    var leftButtonLabel: (() -> Content)?
    var leftButtonColor: Color = .green
    var leftButtonAction: (() -> Void)?
    
    var rightButtonLabel: (() -> Content)?
    var rightButtonColor: Color = .red
    var rightButtonAction: (() -> Void)?
    
    var style: SwipeButtonStyle = .wave
    
    var body: some View {
        ZStack {
            if leftButtonLabel != nil {
                HStack {
                    ZStack {
                        if style == .wave {
                            WaveShape(offsetX: offsetX > 0 ? offsetX : 0, position: .left)
                                .fill(leftButtonColor)
                                .frame(width: 60)
                                .animation(willAuto ? .easeOut(duration: 0.2) : .easeIn(duration: 0.2))
                                .opacity(offsetX == 0 ? 0 : 1)
                        } else {
                            RectangleShape(offsetX: offsetX > 0 ? offsetX : 0, position: .left)
                                .fill(leftButtonColor)
                                .frame(width: 60)
                                .animation(willAuto ? .easeOut(duration: 0.2) : .easeIn(duration: 0.2))
                                .opacity(offsetX == 0 ? 0 : 1)
                        }
                        leftButtonLabel!()
                            .animation(willAuto ? .easeOut(duration: 0.2) : .easeIn(duration: 0.2))
                            .offset(x: willAuto ? offsetX - 75 : min(offsetX, 75) - 75)
                            .opacity(offsetX == 0 ? 0 : 1)
                    }
                    .onTapGesture {
                        if leftButtonAction != nil {
                            leftButtonAction!()
                        }
                        withAnimation {
                            offsetX = 0
                        }
                        #if os(iOS)
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                        #endif
                    }
                    Spacer()
                }
            }
            if rightButtonLabel != nil {
                HStack {
                    Spacer()
                    ZStack {
                        if style == .wave {
                            WaveShape(offsetX: offsetX < 0 ? offsetX : 0, position: .right)
                                .fill(rightButtonColor)
                                .frame(width: 60)
                                .animation(willAuto ? .easeOut(duration: 0.2) : .easeIn(duration: 0.2))
                                .opacity(offsetX == 0 ? 0 : 1)
                        } else {
                            RectangleShape(offsetX: offsetX < 0 ? offsetX : 0, position: .right)
                                .fill(rightButtonColor)
                                .frame(width: 60)
                                .animation(willAuto ? .easeOut(duration: 0.2) : .easeIn(duration: 0.2))
                                .opacity(offsetX == 0 ? 0 : 1)
                        }
                        
                        rightButtonLabel!()
                            .animation(willAuto ? .easeOut(duration: 0.2) : .easeIn(duration: 0.2))
                            .offset(x: willAuto ? offsetX + 75 : max(offsetX, -75) + 75)
                            .opacity(offsetX == 0 ? 0 : 1)
                        
                    }
                    .onTapGesture {
                        if rightButtonAction != nil {
                            rightButtonAction!()
                        }
                        withAnimation {
                            offsetX = 0
                        }
                        #if os(iOS)
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                        #endif
                    }
                }
            }
        }
    }
}
