struct MatchMarkers: View {
    var body: some View {
        HStack {
            VStack {
                Circle().fill(.green)
                Circle().strokeBorder(.primary, lineWidth: 2)
                    .aspectRatio(1, contentMode: .fit)
            }
            VStack {
                Circle()
                Circle().opacity(0)
            }
            
        }
    }
}