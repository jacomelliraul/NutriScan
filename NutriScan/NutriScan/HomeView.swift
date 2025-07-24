import SwiftUI

struct HomeView: View {
    let streakDays = 7
    let glassesToday = (5, 8)
    let weeklyAverage = 87
    let calories = (consumed: 1247, goal: 2000)
    let macros = (protein: (89, 120), carbs: (156, 250), fats: (45, 70))

    var body: some View {
        VStack(spacing: 24) {
            Text("Como está sua alimentação hoje?")
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)

            // --- Início do painel de nutrição ---
            VStack(spacing: 24) {
                HStack(spacing: 16) {
                    indicator(title: "\(streakDays) dias", subtitle: "Sequência")
                    indicator(title: "\(weeklyAverage)%", subtitle: "Média semanal")
                }

                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 12)
                        .frame(width: 180, height: 180)
                    Circle()
                        .trim(from: 0, to: CGFloat(calories.consumed) / CGFloat(calories.goal))
                        .stroke(Color.green, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .frame(width: 180, height: 180)
                    VStack {
                        Text("\(calories.consumed)")
                            .font(.system(size: 36, weight: .bold))
                        Text("de \(calories.goal) kcal")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("\(calories.goal - calories.consumed) restantes")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Macronutrientes")
                        .font(.headline)
                    macroRow(name: "Proteínas", values: macros.protein, color: .blue)
                    macroRow(name: "Carboidratos", values: macros.carbs, color: .orange)
                    macroRow(name: "Gorduras", values: macros.fats, color: .pink)
                }
            }
            // --- Fim do painel de nutrição ---

            Spacer()

            Button("DETALHES") {
                // ação ao tocar
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .cornerRadius(12)
        }
        .padding()
    }

    // Indicador superior
    @ViewBuilder
    func indicator(title: String, subtitle: String) -> some View {
        VStack {
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }

    // Linha de macronutriente
    @ViewBuilder
    func macroRow(name: String, values: (current: Int, goal: Int), color: Color) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(name)
                Spacer()
                Text("\(values.current) / \(values.goal)g")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            ProgressView(value: Double(values.current), total: Double(values.goal))
                .accentColor(color)
        }
    }
}

#Preview {
    HomeView()
}
