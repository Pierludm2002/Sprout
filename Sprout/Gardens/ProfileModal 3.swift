private struct ProfileModal: View {
        let profile: Profile
        
        var body: some View {
            VStack(spacing: 16) {
                Image(profile.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                    .padding(8)
                    .background(Circle().fill(Color(.secondarySystemBackground)))
                
                Text(profile.prefName)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding()
        }
    }