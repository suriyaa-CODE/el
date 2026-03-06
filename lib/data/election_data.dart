class ElectionData {
  // Party slogans with corresponding party names
  static final Map<String, String> partySlogans = {
    // National parties
    'achhe din': 'Bharatiya Janata Party (BJP)',
    'sabka saath sabka vikas': 'Bharatiya Janata Party (BJP)',
    'congress ka haath aam aadmi ke saath': 'Indian National Congress (INC)',
    'haath badlega halat': 'Indian National Congress (INC)',
    'kejriwal model': 'Aam Aadmi Party (AAP)',
    'paanch saal kejriwal': 'Aam Aadmi Party (AAP)',
    'jai bhim': 'Bahujan Samaj Party (BSP)',
    'samajwadi': 'Samajwadi Party (SP)',

    // Tamil Nadu parties
    'ondrinaivom velvom': 'Dravida Munnetra Kazhagam (DMK)',
    'kalaignar': 'Dravida Munnetra Kazhagam (DMK)',
    'amma': 'All India Anna Dravida Munnetra Kazhagam (AIADMK)',
    'puratchi thalaivi': 'All India Anna Dravida Munnetra Kazhagam (AIADMK)',
    'naam tamilar': 'Naam Tamilar Katchi (NTK)',
    'makkal nala': 'Pattali Makkal Katchi (PMK)',
    'desiya murpokku': 'Desiya Murpokku Dravida Kazhagam (DMDK)',
    'tamilaga vettri': 'Tamilaga Vettri Kazhagam (TVK)',
    'pirappu urimai': 'Tamilaga Vettri Kazhagam (TVK)',
  };

  // Party symbols with keywords and party names
  static final List<Map<String, String>> partySymbols = [
    // National parties
    {
      'keyword': 'lotus',
      'party': 'Bharatiya Janata Party (BJP)',
      'image': 'assets/images/symbols/Bharatiya Janata Party (BJP).jpg',
    },
    {
      'keyword': 'hand',
      'party': 'Indian National Congress (INC)',
      'image': 'assets/images/symbols/Indian National Congress.png',
    },
    {
      'keyword': 'broom',
      'party': 'Aam Aadmi Party (AAP)',
      'image': 'assets/images/symbols/Aam Aadmi Party (AAP).jpg',
    },
    {
      'keyword': 'cycle',
      'party': 'Samajwadi Party (SP)',
      'image': 'assets/images/symbols/Samajwadi Party (SP).jpg',
    },
    {
      'keyword': 'elephant',
      'party': 'Bahujan Samaj Party (BSP)',
      'image': 'assets/images/symbols/Bahujan Samaj Party (BSP).jpg',
    },
    // Tamil Nadu parties
    {
      'keyword': 'rising sun',
      'party': 'Dravida Munnetra Kazhagam (DMK)',
      'image': 'assets/images/symbols/Dravida Munnetra Kazhagam (DMK).jpg',
    },
    {
      'keyword': 'two leaves',
      'party': 'All India Anna Dravida Munnetra Kazhagam (AIADMK)',
      'image':
          'assets/images/symbols/All India Anna Dravida Munnetra Kazhagam (AIADMK).jpg',
    },
    {
      'keyword': 'tiger',
      'party': 'Naam Tamilar Katchi (NTK)',
      'image': 'assets/images/symbols/Naam Tamilar Katchi (NTK).jpg',
    },
    {
      'keyword': 'mango',
      'party': 'Pattali Makkal Katchi (PMK)',
      'image': 'assets/images/symbols/Pattali Makkal Katchi (PMK).jpg',
    },
    {
      'keyword': 'drum',
      'party': 'Desiya Murpokku Dravida Kazhagam (DMDK)',
      'image':
          'assets/images/symbols/Desiya Murpokku Dravida Kazhagam (DMDK).jpg',
    },
    {
      'keyword': 'whistle',
      'party': 'Tamilaga Vettri Kazhagam (TVK)',
      'image': 'assets/images/symbols/tvk.jpg',
    },
  ];

  // Detailed Party Profiles
  static final Map<String, String> partyProfiles = {
    'bjp':
        "Bharatiya Janata Party (BJP) - Founded in 1980, it is currently the world's largest political party. "
        "Ideology: Integral humanism and Hindutva. Key Leaders: Narendra Modi, Amit Shah. "
        "Major Achievements: Digital India, Infrastructure growth, and Ayodhya Temple construction.",
    'inc':
        "Indian National Congress (INC) - Founded in 1885, it played a central role in India's independence movement. "
        "Ideology: Social democracy and secularism. Key Leaders: Mallikarjun Kharge, Rahul Gandhi. "
        "Historical impact: Green Revolution and economic liberalization of 1991.",
    'dmk':
        "Dravida Munnetra Kazhagam (DMK) - Founded by C.N. Annadurai in 1949 after split from DK. "
        "Ideology: Dravidiansm, social justice, and state autonomy. Key Leaders: M.K. Stalin, Udhayanidhi Stalin. "
        "Legacy: Mid-day meal schemes, 1kg rice for Re.1, and social equality movements.",
    'aiadmk':
        "All India Anna Dravida Munnetra Kazhagam (AIADMK) - Founded by M.G. Ramachandran (MGR) in 1972. "
        "Ideology: Populism, social welfare, and Dravidian welfare. Key Leaders: Edappadi K. Palaniswami (EPS). "
        "Legacy: Cradle baby scheme, free laptops, and the 'Amma' brand welfare initiatives.",
    'ntk':
        "Naam Tamilar Katchi (NTK) - Founded by Seeman in 2010. "
        "Ideology: Tamil Nationalism and environmental protection. "
        "Goal: To establish self-reliance for the Tamil people and protect the language and culture.",
    'tvk':
        "Tamilaga Vettri Kazhagam (TVK) - Launched in 2024 by actor Thalapathy Vijay. "
        "Ideology: Secular Social Justice and clean governance. "
        "Goal: To provide a viable alternative to Dravidian majors in the 2026 assembly elections.",
    'pmk':
        "Pattali Makkal Katchi (PMK) - Founded by S. Ramadoss in 1989. "
        "Focus: Social justice for the Vanniyar community and rural development. "
        "Leadership: Anbumani Ramadoss.",
    'dmdk':
        "Desiya Murpokku Dravida Kazhagam (DMDK) - Founded by actor Vijayakanth in 2005. "
        "Initial Impact: Emerged as a powerful third force in 2006/2011 elections. "
        "Current Leader: Premalatha Vijayakanth.",
  };

  // Proposed Chief Minister candidates
  static final Map<String, String> proposedCMs = {
    // National parties
    'bjp': 'Narendra Modi (National Level), Annamalai (Tamil Nadu)',
    'congress': 'Rahul Gandhi (National Level), Various state-level candidates',
    'inc': 'Rahul Gandhi',
    'aap': 'Arvind Kejriwal',
    'sp': 'Akhilesh Yadav',
    'bsp': 'Mayawati',

    // Tamil Nadu parties
    'dmk': 'M.K. Stalin (Chief Minister - Tamil Nadu)',
    'aiadmk': 'Edappadi K. Palaniswami (EPS)',
    'admk': 'Edappadi K. Palaniswami (EPS)',
    'pmk': 'Anbumani Ramadoss',
    'dmdk': 'Vijayakanth (Founder), Premalatha Vijayakanth (Current Leader)',
    'ntk': 'Seeman',
    'tvk': 'Vijay (Thalapathy Vijay)',
  };

  // Party leaders/presidents
  static final Map<String, String> partyLeaders = {
    'bjp': 'J.P. Nadda (President), Narendra Modi (Primary Leader)',
    'congress': 'Mallikarjun Kharge (President), Rahul Gandhi (Primary Leader)',
    'inc': 'Mallikarjun Kharge',
    'aap': 'Arvind Kejriwal (National Convenor)',
    'sp': 'Akhilesh Yadav (President)',
    'bsp': 'Mayawati (President)',
    'dmk': 'M.K. Stalin (President)',
    'aiadmk': 'Edappadi K. Palaniswami (General Secretary)',
    'pmk': 'Anbumani Ramadoss (President)',
    'dmdk': 'Premalatha Vijayakanth (General Secretary)',
    'ntk': 'Seeman (Chief Coordinator)',
    'tvk': 'Vijay (Founder & President)',
  };

  // Election-related keywords for domain validation
  static final List<String> electionKeywords = [
    // General election keywords
    'election', 'vote', 'party', 'candidate', 'campaign', 'rally', 'manifesto',
    'politics', 'minister', 'cm', 'pm', 'slogan', 'symbol', 'prediction',
    'forecast', '2026', '2021', 'result', 'winning', 'leader', 'chief',
    'president', 'head', 'general secretary', 'history', 'details', 'about',

    // National parties
    'bjp', 'congress', 'inc', 'aap', 'lotus', 'hand', 'broom', 'cycle',
    'elephant', 'achhe', 'kejriwal', 'modi', 'rahul', 'akhilesh', 'mayawati',

    // Tamil Nadu parties and keywords
    'dmk', 'aiadmk', 'admk', 'pmk', 'dmdk', 'ntk', 'tvk', 'tamil nadu',
    'tamilnadu', 'stalin', 'kalaignar', 'karunanidhi', 'jayalalithaa', 'amma',
    'eps', 'palaniswami', 'edappadi', 'annamalai', 'seeman', 'vijayakanth',
    'anbumani', 'ramadoss', 'rising sun', 'two leaves', 'mango', 'drum',
    'tiger', 'vaagai', 'dravidian', 'dravida', 'vijay', 'thalapathy',
    'tamilaga', 'vettri', 'whistle',
  ];

  // 2021 Tamil Nadu Election Results (Analyzed from Kaggle Dataset)
  static final Map<String, dynamic> results2021 = {
    'total_seats': 234,
    'winners': {
      'DMK': 133,
      'AIADMK': 66,
      'INC': 18,
      'PMK': 5,
      'BJP': 4,
      'VCK': 4,
      'CPI(M)': 2,
      'CPI': 2,
    },
    'vote_share': {
      'DMK': '37.7%',
      'AIADMK': '33.3%',
      'NTK': '6.6%',
      'INC': '4.3%',
      'PMK': '3.8%',
      'BJP': '2.6%',
    },
  };

  // 2026 Election Prediction (Based on 2021 trends and TVK entry)
  static final String prediction2026 =
      "The 2026 Tamil Nadu Election is expected to be a multi-cornered contest. "
      "While the DMK-led alliance holds a strong base (37.7% in 2021), "
      "the entry of Thalapathy Vijay's TVK is a significant factor. "
      "Historical data shows NTK rising to 6.6% share, indicating a growing space for third-party alternatives. "
      "Prediction: A tough battle between DMK and AIADMK alliances, with TVK likely acting as a key spoiler or kingmaker "
      "by attracting youth and first-time voters away from Dravidian majors.";
}
