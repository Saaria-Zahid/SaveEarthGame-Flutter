import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.brown[100],
      ),
      home: const SplashScreen(),
    );
  }
}

// Splash Screen
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/bg.jpg'), // Background image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png', width: 200), // Logo placeholder
                  const SizedBox(height: 30),
                  const Text(
                    "Welcome to Save Earth Mission",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Orbitron',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
          bottom: 50,
          left: 20,
          right: 20,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
             // Optional border
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Adjusted padding
          elevation: 5, // Optional elevation
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NasaAPODScreen()),
          );
        },
        child: const Text(
          "Get Started",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold), // Bold text
        ),
            ),
          ),
        ),
        
          ],
        ),
      ),
    );
  }
}

// NASA APOD Screen
class NasaAPODScreen extends StatefulWidget {
  const NasaAPODScreen({super.key});

  @override
  _NasaAPODScreenState createState() => _NasaAPODScreenState();
}

class _NasaAPODScreenState extends State<NasaAPODScreen> {
  Map<String, dynamic>? nasaData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNasaData();
  }

  Future<void> fetchNasaData() async {
    const String apiKey = "DEMO_KEY"; // Replace with your own API key
    final String apiUrl = "https://api.nasa.gov/planetary/apod?api_key=$apiKey";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          nasaData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load NASA data');
      }
    } catch (e) {
      print('Error fetching NASA APOD data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('NASA Picture of the Day'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            
            image: AssetImage('assets/bg.jpg'), 
            

            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        nasaData?['title'] ?? 'NASA Picture of the Day',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Image.asset('assets/apod.jpg'), // Placeholder image
                      const SizedBox(height: 20),
                      Text(
                        nasaData?['explanation'] ?? 'Explanation not available',
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Date: ${nasaData?['date'] ?? ''}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '© ${nasaData?['copyright'] ?? 'NASA'}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 30),
                  
        
           SizedBox(
            width: double.infinity,
            child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
             // Optional border
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Adjusted padding
          elevation: 5, // Optional elevation
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SaveEarthMission()),
          );
        },
        child: const Text(
          "Get Started",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold), // Bold text
        ),
            ),
          ),
        
                      const SizedBox(height: 30),
        
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

// Save Earth Mission Game
class SaveEarthMission extends StatefulWidget {
  const SaveEarthMission({super.key});

  @override
  _SaveEarthMissionState createState() => _SaveEarthMissionState();
}

class _SaveEarthMissionState extends State<SaveEarthMission> {
  int earthHealth = 50;
  String selectedTopic = '';
  int currentQuestionIndex = 0;
  String impactMessage = ''; // Variable to hold impact message

  // Quiz questions and answers
 final Map<String, List<Map<String, dynamic>>> questions = {
  'CO2 Emission': [
    {
      'question': 'What is the primary source of increased CO2 levels in the atmosphere?',
      'answers': {
        'Burning of fossil fuels': 10,
        'Deforestation': -5,
        'Volcanic eruptions': -10,
        'Oceanic release': -5,
      },
      'correct': 'Burning of fossil fuels',
    },
    {
      'question': 'How have CO2 levels changed over the past 50 years according to NASA data?',
      'answers': {
        'Increased significantly': 10,
        'Remained stable': -5,
        'Fluctuated without a clear trend': -5,
        'Decreased significantly': -10,
      },
      'correct': 'Increased significantly',
    },
    {
      'question': 'What is the current average concentration of CO2 in the atmosphere as measured by NASA?',
      'answers': {
        'Over 420 ppm': 10,
        '400 ppm': -5,
        '350 ppm': -5,
        '280 ppm': -10,
      },
      'correct': 'Over 420 ppm',
    },
    {
      'question': 'Which sector is the largest contributor to CO2 emissions?',
      'answers': {
        'Transportation': 10,
        'Industry': 7,
        'Agriculture': -5,
        'Residential': -5,
      },
      'correct': 'Transportation',
    },
    {
      'question': 'What is the greenhouse effect?',
      'answers': {
        'The trapping of heat by greenhouse gases in the atmosphere': 10,
        'The cooling of the Earth’s surface': -10,
        'The reflection of sunlight by clouds': -5,
        'The absorption of UV radiation by the ozone layer': -5,
      },
      'correct': 'The trapping of heat by greenhouse gases in the atmosphere',
    },
    {
      'question': 'Which gas is the most abundant greenhouse gas in the Earth’s atmosphere?',
      'answers': {
        'Water vapor': 10,
        'Carbon dioxide': 7,
        'Methane': -5,
        'Nitrous oxide': -5,
      },
      'correct': 'Water vapor',
    },
    {
      'question': 'How does increased CO2 concentration affect ocean acidity?',
      'answers': {
        'Increases acidity': 10,
        'Decreases acidity': -10,
        'No effect': -5,
        'Varies by region': -5,
      },
      'correct': 'Increases acidity',
    },
    {
      'question': 'What is the main consequence of ocean acidification?',
      'answers': {
        'Coral bleaching': 10,
        'Increased fish populations': -10,
        'Reduced sea levels': -5,
        'Enhanced marine biodiversity': -5,
      },
      'correct': 'Coral bleaching',
    },
    {
      'question': 'Which international agreement aims to reduce CO2 emissions globally?',
      'answers': {
        'Paris Agreement': 10,
        'Kyoto Protocol': 7,
        'Montreal Protocol': -5,
        'Geneva Convention': -5,
      },
      'correct': 'Paris Agreement',
    },
    {
      'question': 'What is carbon sequestration?',
      'answers': {
        'The capture and storage of carbon from the atmosphere': 10,
        'The release of carbon into the atmosphere': -10,
        'The burning of carbon-based fuels': -5,
        'The measurement of carbon levels in the soil': -5,
      },
      'correct': 'The capture and storage of carbon from the atmosphere',
    },
  ],
  'Deforestation': [
    {
      'question': 'What is the main cause of deforestation in tropical regions?',
      'answers': {
        'Agricultural expansion': 10,
        'Mining activities': 7,
        'Urban development': -5,
        'Natural disasters': -5,
      },
      'correct': 'Agricultural expansion',
    },
    {
      'question': 'How does deforestation contribute to increased CO2 levels?',
      'answers': {
        'Both A and B': 10,
        'Trees release CO2 when they are cut down': 7,
        'Trees absorb CO2, so fewer trees mean less CO2 absorption': 7,
        'Deforestation does not affect CO2 levels': -10,
      },
      'correct': 'Both A and B',
    },
    // Add remaining deforestation questions here...
  ],
  'Flooding': [
    {
      'question': 'What is the primary cause of flooding?',
      'answers': {
        'Heavy rainfall': 10,
        'Deforestation': 7,
        'Earthquakes': -5,
        'Volcanic eruptions': -5,
      },
      'correct': 'Heavy rainfall',
    },
    {
      'question': 'How does deforestation contribute to flooding?',
      'answers': {
        'Reduces soil absorption': 10,
        'Increases soil absorption': -10,
        'No effect': -5,
        'Prevents flooding': -5,
      },
      'correct': 'Reduces soil absorption',
    },
    // Add remaining flooding questions here...
  ],
};

  void startQuiz(String topic) {
    setState(() {
      selectedTopic = topic;
      currentQuestionIndex = 0;
      earthHealth = 50; // Reset Earth health
      impactMessage = ''; // Reset impact message
    });
  }

  void handleAnswer(String selectedAnswer, String correctAnswer, int healthImpact) {
    setState(() {
      earthHealth += healthImpact;
      currentQuestionIndex++;
      impactMessage = 'If you choose this answer, the impact on Earth will be: ${healthImpact > 0 ? "Positive (+$healthImpact%)" : "Negative ($healthImpact%)"}';
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Start Game',style: TextStyle(color: Colors.white),)),
  
    
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/bg.jpg'), // Background image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Center(
              child: Text(
                "🌍 Save Earth - Space Mission 🚀",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Orbitron',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Select a topic and start your mission to save Earth!",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 40),
            selectedTopic.isEmpty ? buildTopicSelection() : buildQuizSection(),
          ],
        ),
      ),
    );
  }

Widget buildTopicSelection() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity, // 100% width
          child: buildTopicCard('CO2 Emission'),
        ),
        const SizedBox(height: 10), // Optional spacing between cards
        SizedBox(
          width: double.infinity, // 100% width
          child: buildTopicCard('Deforestation'),
        ),
        const SizedBox(height: 10), // Optional spacing between cards
        SizedBox(
          width: double.infinity, // 100% width
          child: buildTopicCard('Flooding'),
        ),
      ],
    ),
  );
}

  Widget buildTopicCard(String topic) {
    return Card(
      color: Colors.grey[800]?.withOpacity(0.9) ?? Colors.grey.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Icon(Icons.public, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              topic,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Use backgroundColor instead of primary
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              onPressed: () => startQuiz(topic),
              child: const Text('Start Quiz', style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }
  Widget buildQuizSection() {
    final questionList = questions[selectedTopic];
    if (currentQuestionIndex >= questionList!.length) {
      return buildResultSection();
    }

    final currentQuestion = questionList[currentQuestionIndex];
    final answers = currentQuestion['answers'] as Map<String, int>;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            currentQuestion['question'],
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 20),
          ...answers.entries.map((entry) {
            return GestureDetector(
              onTap: () {
                handleAnswer(entry.key, currentQuestion['correct'], entry.value);
              },
              child: buildAnswerCard(entry.key, entry.value),
            );
          }).toList(),
          const SizedBox(height: 20),
          Text(
            'Earth Health: $earthHealth%',
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 10),
          Text(
            impactMessage,
            style: const TextStyle(color: Colors.yellow, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildAnswerCard(String answer, int healthImpact) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          answer,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight:FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildResultSection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Mission Complete! Earth Health: $earthHealth%',
            style: const TextStyle(color: Colors.white, fontSize: 22),
          ),
          const SizedBox(height: 20),
          SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, // Button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
           // Optional border
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Adjusted padding
        elevation: 5, // Optional elevation
      ),
      onPressed: () {
              setState(() {
                selectedTopic = '';
                currentQuestionIndex = 0;
              });
            },
      child: const Text(
        "Restart Game",
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold), // Bold text
      ),
    ),
  ),
        ],
      ),
    );
  }
}
