import '../data/election_data.dart';

class NLPResponse {
  final String text;
  final String? imagePath;

  NLPResponse({required this.text, this.imagePath});
}

class NLPService {
  NLPResponse processQuery(String query) {
    query = query.toLowerCase();

    // 1. Check for Detailed Party Profiles (Highest Priority for specific info)
    for (var party in ElectionData.partyProfiles.keys) {
      if (query == party ||
          query.contains('about $party') ||
          query.contains('history of $party') ||
          query.contains('info on $party')) {
        return NLPResponse(
          text: ElectionData.partyProfiles[party]!,
          imagePath: _getSymbolPathForParty(party),
        );
      }
    }

    // 2. Check for slogans
    for (var entry in ElectionData.partySlogans.entries) {
      if (query.contains(entry.key)) {
        return NLPResponse(
          text: "The slogan '${entry.key}' belongs to ${entry.value}.",
        );
      }
    }

    // 3. Check for symbols
    for (var party in ElectionData.partySymbols) {
      String partyFull = party['party']!.toLowerCase();
      bool partyMatch =
          query.contains(partyFull) ||
          (partyFull.contains('(') &&
              query.contains(
                partyFull.split('(').last.split(')').first.toLowerCase(),
              ));

      if (query.contains(party['keyword']!.toLowerCase()) ||
          (query.contains('symbol') && partyMatch)) {
        return NLPResponse(
          text: "The symbol of ${party['party']} is the ${party['keyword']}.",
          imagePath: party['image'],
        );
      }
    }

    // 4. Specific Party Insights (High Priority for TVK)
    if (query == 'tvk' ||
        query.contains('tvk info') ||
        query.contains('about tvk') ||
        query.contains('tamilaga vettri')) {
      return NLPResponse(
        text:
            ElectionData.partyProfiles['tvk']! +
            "\n\n- Symbol: Whistle" +
            "\n- Slogan: Pirappu okkum ella uyirukkum",
        imagePath: 'assets/images/symbols/tvk.jpg',
      );
    }

    // 5. Check for CM/PM and Candidates
    if (query.contains('chief minister') || query.contains('cm')) {
      if (query.contains('india')) {
        return NLPResponse(
          text:
              "India has a Prime Minister at the national level. The current Prime Minister of India is Narendra Modi. States have Chief Ministers; for example, the CM of Tamil Nadu is M.K. Stalin.",
          imagePath: 'assets/images/symbols/Bharatiya Janata Party (BJP).jpg',
        );
      }
      return NLPResponse(
        text: "The current Chief Minister of Tamil Nadu is M.K. Stalin (DMK).",
        imagePath: 'assets/images/symbols/Dravida Munnetra Kazhagam (DMK).jpg',
      );
    }

    if (query.contains('prime minister') || query.contains('pm')) {
      return NLPResponse(
        text: "The current Prime Minister of India is Narendra Modi (BJP).",
        imagePath: 'assets/images/symbols/Bharatiya Janata Party (BJP).jpg',
      );
    }

    for (var entry in ElectionData.proposedCMs.entries) {
      if (query.contains(entry.key) &&
          (query.contains('cm') ||
              query.contains('candidate') ||
              query.contains('who is'))) {
        return NLPResponse(
          text:
              "The proposed CM candidate for ${entry.key.toUpperCase()} is ${entry.value}.",
        );
      }
    }

    // 6. Check for Leaders
    for (var entry in ElectionData.partyLeaders.entries) {
      if ((query.contains('leader') || query.contains('president')) &&
          query.contains(entry.key)) {
        return NLPResponse(
          text: "The leader of ${entry.key.toUpperCase()} is ${entry.value}.",
        );
      }
    }

    // 7. Check for 2021 Results
    if (query.contains('2021') &&
        (query.contains('result') || query.contains('show'))) {
      String resultsText = "2021 Tamil Nadu Election Results:\n";
      ElectionData.results2021['winners'].forEach((party, seats) {
        resultsText += "- $party: $seats seats\n";
      });
      return NLPResponse(text: resultsText);
    }

    // 8. Check for 2026 Prediction
    if (query.contains('2026') ||
        query.contains('prediction') ||
        query.contains('next election')) {
      return NLPResponse(text: ElectionData.prediction2026);
    }

    // 9. Domain Validation
    bool isRelated = false;
    for (var keyword in ElectionData.electionKeywords) {
      if (query.contains(keyword.toLowerCase())) {
        isRelated = true;
        break;
      }
    }

    if (!isRelated) {
      return NLPResponse(
        text:
            "I answer only election-related questions. Please ask about party symbols, slogans, or candidates.",
      );
    }

    return NLPResponse(
      text:
          "I found some election-related keywords, but I couldn't find a specific answer in my knowledge base. Try asking about a specific party's symbol or slogan.",
    );
  }

  String? _getSymbolPathForParty(String partyKey) {
    for (var party in ElectionData.partySymbols) {
      if (party['party']!.toLowerCase().contains(partyKey)) {
        return party['image'];
      }
    }
    return null;
  }
}
