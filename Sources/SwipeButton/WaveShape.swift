import SwiftUI

struct WaveShape: Shape {
    var offsetX: CGFloat
    var animatableData: CGFloat {
        get { offsetX }
        set { offsetX = newValue }
    }
    var position: Position = .right
    
    enum Position {
        case left
        case right
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let height = rect.height
        let width = rect.width
        let paddingValue: CGFloat = 10
        let controlPointY: CGFloat = height > 100 ? height / 7 : (height > 60 ? height / 8 : height / 9)

        if position == .left {
            path.move(to: CGPoint(x: 0, y: 0))
            if offsetX > paddingValue {
                let toPoint1 = CGPoint(x: offsetX - paddingValue, y: height/2)
                let controlPoint1 = CGPoint(x: 0, y: controlPointY * 1.5)
                let controlPoint2 = CGPoint(x: offsetX - paddingValue, y: controlPointY)
                
                let toPoint2 = CGPoint(x: 0, y: height)
                let controlPoint3 = CGPoint(x: offsetX - paddingValue, y: height - controlPointY)
                let controlPoint4 = CGPoint(x: 0, y: height - controlPointY * 1.5)
                
                path.addCurve(to: toPoint1, control1: controlPoint1, control2: controlPoint2)
                path.addCurve(to: toPoint2, control1: controlPoint3, control2: controlPoint4)
            }
            path.addLine(to: CGPoint(x: 0, y: 0))
        } else {
            path.move(to: CGPoint(x: width, y: 0))
            if offsetX < -paddingValue {
                let toPoint1 = CGPoint(x: width + offsetX + paddingValue, y: height/2)
                let controlPoint1 = CGPoint(x: width, y: controlPointY)
                let controlPoint2 = CGPoint(x: width + offsetX + paddingValue, y: controlPointY)
                
                let toPoint2 = CGPoint(x: width, y: height)
                let controlPoint3 = CGPoint(x: width + offsetX + paddingValue, y: height - controlPointY)
                let controlPoint4 = CGPoint(x: width, y: height - controlPointY)
                
                path.addCurve(to: toPoint1, control1: controlPoint1, control2: controlPoint2)
                path.addCurve(to: toPoint2, control1: controlPoint3, control2: controlPoint4)
            }
            path.addLine(to: CGPoint(x: width, y: 0))
        }
        
        return path
    }
}


struct WaveShape_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WaveShape(offsetX: 40, position: .left)
                .fill(Color.red)
                .frame(height: 60)
                .previewLayout(.sizeThatFits)
            
            WaveShape(offsetX: 120, position: .left)
                .fill(Color.red)
                .frame(height: 60)
                .previewLayout(.sizeThatFits)

            WaveShape(offsetX: 120, position: .left)
                .fill(Color.red)
                .frame(height: 120)
                .previewLayout(.sizeThatFits)
            
            WaveShape(offsetX: 120, position: .left)
                .fill(Color.red)
                .frame(height: 260)
                .previewLayout(.sizeThatFits)

            
            WaveShape(offsetX: -120, position: .right)
                .fill(Color.blue)
                .frame(height: 160)
                .previewLayout(.sizeThatFits)

        }
    }
}
