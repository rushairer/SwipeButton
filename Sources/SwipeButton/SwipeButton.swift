import SwiftUI

public enum SwipeButtonStyle {
    case wave
    case rectangle
}

public struct SwipeButtonModifier<SwipeActionContent: View> : AnimatableModifier {
    var leftButtonLabel: (() -> SwipeActionContent)?
    var leftButtonColor: Color = .green
    var leftButtonAction: (() -> Void)?
    
    var rightButtonLabel: (() -> SwipeActionContent)?
    var rightButtonColor: Color = .red
    var rightButtonAction: (() -> Void)?
    
    var style: SwipeButtonStyle = .wave
    
    /// 半程，滑动过半程固定出现按钮。
    private let halfDistance: CGFloat = 75.0
    
    /// 全程，滑动过全程，并松开手势，自动触发动作。
    private let fullDistance: CGFloat = 150.0
    
    /// 滑动手势信息。
    @GestureState private var translation: CGPoint = .zero
    
    /// 是否正在滑动。
    @State private var isDragging: Bool = false
    
    /// 区域位移。
    @State private var offsetX : CGFloat = 0.0
    
    /// 缓存半程位移。当固定出现按钮后，再继续触发手势会补充缓存量。
    @State private var cacheOffsetX : CGFloat = 0.0
    
    /// 是否自动触发动作
    @State private var willAuto: Bool = false
    
    /// 是否不可以自动触发动作
    @State private var disableAuto: Bool = true
    
    public init(leftButtonLabel: (() -> SwipeActionContent)? = nil,
                leftButtonColor: Color = .green,
                leftButtonAction: (() -> Void)? = nil,
                rightButtonLabel: (() -> SwipeActionContent)? = nil,
                rightButtonColor: Color = .red,
                rightButtonAction: (() -> Void)? = nil,
                style: SwipeButtonStyle = .wave) {
        
        self.leftButtonLabel = leftButtonLabel
        self.leftButtonColor = leftButtonColor
        self.leftButtonAction = leftButtonAction
        self.rightButtonLabel = rightButtonLabel
        self.rightButtonColor = rightButtonColor
        self.rightButtonAction = rightButtonAction
        self.style = style
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            SwipeButtonView(
                offsetX: $offsetX,
                willAuto: $willAuto,
                leftButtonLabel: leftButtonLabel,
                leftButtonColor: leftButtonColor,
                leftButtonAction: leftButtonAction,
                rightButtonLabel: rightButtonLabel,
                rightButtonColor: rightButtonColor,
                rightButtonAction: rightButtonAction,
                style: style)
            content
                .highPriorityGesture(
                    DragGesture(minimumDistance: 10, coordinateSpace: .global)
                        .updating($translation) { current, state, _ in
                            state.x = current.translation.width
                            DispatchQueue.main.async {
                                isDragging = true
                            }
                        }
                        .onEnded({ value in
                            DispatchQueue.main.async {
                                isDragging = false
                            }
                        })
                )
                .offset(x: offsetX)
                .onChange(of: translation, perform: { newValue in
                    if newValue.x != 0 {
                        if (leftButtonLabel != nil && cacheOffsetX + newValue.x > 0) || (rightButtonLabel != nil && cacheOffsetX + newValue.x < 0) {
                            offsetX = cacheOffsetX + newValue.x
                        }
                    }
                })
                .onChange(of: isDragging, perform: { isDragging in
                    if !isDragging {
                        withAnimation {
                            if offsetX <= -halfDistance {
                                if willAuto {
                                    if rightButtonAction != nil {
                                        rightButtonAction!()
                                    }
                                    offsetX = 0
                                    willAuto = false
                                    disableAuto = true
                                    #if os(iOS)
                                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                                    #endif
                                } else {
                                    offsetX = -halfDistance
                                }
                            } else if offsetX >= halfDistance {
                                if willAuto {
                                    if leftButtonAction != nil {
                                        leftButtonAction!()
                                    }
                                    offsetX = 0
                                    willAuto = false
                                    disableAuto = true
                                    #if os(iOS)
                                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                                    #endif
                                } else {
                                    offsetX = halfDistance
                                }
                            } else {
                                offsetX = 0
                            }
                        }
                    }
                })
                .onChange(of: offsetX, perform: { offsetX in
                    withAnimation {
                        if offsetX == 0 || offsetX == halfDistance || offsetX == -halfDistance {
                            cacheOffsetX = offsetX
                        } else if offsetX <= -fullDistance || offsetX >= fullDistance {
                            disableAuto = false
                            if (!willAuto) {
                                #if os(iOS)
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                #endif
                                willAuto = true
                            }
                        } else  {
                            willAuto = false
                            if (!disableAuto) {
                                #if os(iOS)
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                #endif
                                disableAuto = true
                            }
                        }
                    }
                })
        }
    }
}

struct SwipeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Swipe Button")
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.pink)
            .modifier(SwipeButtonModifier(leftButtonLabel: {
                Image(systemName: "heart")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .opacity(1)
            },
            leftButtonAction: {
                
            },
            rightButtonLabel: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .opacity(1)
            },
            rightButtonAction: {
                
            },
            style: .rectangle))
            .frame(height: 150)
            .preferredColorScheme(.dark)
        
    }
}
