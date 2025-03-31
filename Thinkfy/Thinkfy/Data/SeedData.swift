import Foundation

struct SeedData {
    static let categories: [(name: String, icon: String, color: String)] = [
        (name: "Science", icon: "atom", color: "#007AFF"),
        (name: "History", icon: "book.closed", color: "#FF9500"),
        (name: "Geography", icon: "globe", color: "#34C759"),
        (name: "Mathematics", icon: "function", color: "#FF3B30")
    ]
    
    // Helper function to shuffle options and get correct answer index
    static func shuffleOptions(options: [String], correctAnswer: String) -> (shuffledOptions: [String], correctAnswer: String) {
        var shuffledOptions = options
        shuffledOptions.shuffle()
        let correctIndex = shuffledOptions.firstIndex(of: correctAnswer)!
        return (shuffledOptions, shuffledOptions[correctIndex])
    }
    
    static let questions: [(category: String, question: String, options: [String], correctAnswer: String)] = [
        // Science Questions
        (category: "Science", question: "What is the chemical symbol for gold?", options: ["Cu", "Au", "Ag", "Fe"], correctAnswer: "Au"),
        (category: "Science", question: "Which planet is known as the Red Planet?", options: ["Venus", "Saturn", "Mars", "Jupiter"], correctAnswer: "Mars"),
        (category: "Science", question: "What is the hardest natural substance on Earth?", options: ["Iron", "Platinum", "Diamond", "Gold"], correctAnswer: "Diamond"),
        (category: "Science", question: "What is the chemical symbol for silver?", options: ["Si", "Sr", "Ag", "Au"], correctAnswer: "Ag"),
        (category: "Science", question: "Which element has the atomic number 1?", options: ["Oxygen", "Carbon", "Hydrogen", "Helium"], correctAnswer: "Hydrogen"),
        (category: "Science", question: "What is the speed of light in vacuum?", options: ["199,792 km/s", "399,792 km/s", "299,792 km/s", "499,792 km/s"], correctAnswer: "299,792 km/s"),
        (category: "Science", question: "Which gas do plants absorb from the atmosphere?", options: ["Oxygen", "Nitrogen", "Carbon dioxide", "Hydrogen"], correctAnswer: "Carbon dioxide"),
        (category: "Science", question: "What is the largest organ in the human body?", options: ["Heart", "Brain", "Liver", "Skin"], correctAnswer: "Skin"),
        (category: "Science", question: "Which planet has the most moons?", options: ["Saturn", "Mars", "Venus", "Jupiter"], correctAnswer: "Jupiter"),
        (category: "Science", question: "What is the chemical symbol for iron?", options: ["Ir", "In", "Fi", "Fe"], correctAnswer: "Fe"),
        (category: "Science", question: "Which is the most abundant gas in Earth's atmosphere?", options: ["Oxygen", "Carbon dioxide", "Nitrogen", "Hydrogen"], correctAnswer: "Nitrogen"),
        (category: "Science", question: "What is the smallest unit of matter?", options: ["Molecule", "Cell", "Electron", "Atom"], correctAnswer: "Atom"),
        (category: "Science", question: "Which metal is liquid at room temperature?", options: ["Gallium", "Cesium", "Francium", "Mercury"], correctAnswer: "Mercury"),
        (category: "Science", question: "What is the chemical symbol for lead?", options: ["Ld", "Le", "Pl", "Pb"], correctAnswer: "Pb"),
        (category: "Science", question: "Which planet is known as the Morning Star?", options: ["Mars", "Mercury", "Jupiter", "Venus"], correctAnswer: "Venus"),
        (category: "Science", question: "What is the chemical symbol for oxygen?", options: ["Ox", "O2", "O3", "O"], correctAnswer: "O"),
        (category: "Science", question: "Which is the most abundant metal in Earth's crust?", options: ["Iron", "Copper", "Zinc", "Aluminum"], correctAnswer: "Aluminum"),
        (category: "Science", question: "What is the chemical symbol for carbon?", options: ["Ca", "Co", "Cr", "C"], correctAnswer: "C"),
        (category: "Science", question: "Which planet has the Great Red Spot?", options: ["Mars", "Saturn", "Venus", "Jupiter"], correctAnswer: "Jupiter"),
        (category: "Science", question: "What is the chemical symbol for helium?", options: ["Hl", "He2", "H2", "He"], correctAnswer: "He"),
        
        // History Questions
        (category: "History", question: "Who was the first President of the United States?", options: ["Thomas Jefferson", "John Adams", "Benjamin Franklin", "George Washington"], correctAnswer: "George Washington"),
        (category: "History", question: "In which year did World War II end?", options: ["1944", "1946", "1943", "1945"], correctAnswer: "1945"),
        (category: "History", question: "Who painted the Mona Lisa?", options: ["Vincent van Gogh", "Pablo Picasso", "Michelangelo", "Leonardo da Vinci"], correctAnswer: "Leonardo da Vinci"),
        (category: "History", question: "Which ancient wonder was located in Alexandria?", options: ["Pyramids", "Gardens", "Colossus", "Lighthouse"], correctAnswer: "Lighthouse"),
        (category: "History", question: "Who was the first Emperor of China?", options: ["Sun Yat-sen", "Mao Zedong", "Kublai Khan", "Qin Shi Huang"], correctAnswer: "Qin Shi Huang"),
        (category: "History", question: "In which year did the French Revolution begin?", options: ["1799", "1779", "1809", "1789"], correctAnswer: "1789"),
        (category: "History", question: "Who was the first woman to win a Nobel Prize?", options: ["Mother Teresa", "Jane Addams", "Pearl Buck", "Marie Curie"], correctAnswer: "Marie Curie"),
        (category: "History", question: "Which civilization built Machu Picchu?", options: ["Maya", "Aztec", "Olmec", "Inca"], correctAnswer: "Inca"),
        (category: "History", question: "Who was the first Emperor of Rome?", options: ["Julius Caesar", "Nero", "Marcus Aurelius", "Augustus"], correctAnswer: "Augustus"),
        (category: "History", question: "In which year did the Berlin Wall fall?", options: ["1991", "1987", "1993", "1989"], correctAnswer: "1989"),
        (category: "History", question: "Who was the first person to circumnavigate the Earth?", options: ["Christopher Columbus", "Vasco da Gama", "Marco Polo", "Ferdinand Magellan"], correctAnswer: "Ferdinand Magellan"),
        (category: "History", question: "Which dynasty built the Great Wall of China?", options: ["Han", "Ming", "Tang", "Qin"], correctAnswer: "Qin"),
        (category: "History", question: "Who was the first woman to fly solo across the Atlantic?", options: ["Bessie Coleman", "Harriet Quimby", "Jacqueline Cochran", "Amelia Earhart"], correctAnswer: "Amelia Earhart"),
        (category: "History", question: "In which year did the American Civil War begin?", options: ["1865", "1859", "1863", "1861"], correctAnswer: "1861"),
        (category: "History", question: "Who was the first person to reach the South Pole?", options: ["Robert Scott", "Ernest Shackleton", "Richard Byrd", "Roald Amundsen"], correctAnswer: "Roald Amundsen"),
        (category: "History", question: "Which empire was ruled by Genghis Khan?", options: ["Persian", "Ottoman", "Mughal", "Mongol"], correctAnswer: "Mongol"),
        (category: "History", question: "Who was the first person to walk on the Moon?", options: ["Buzz Aldrin", "Yuri Gagarin", "John Glenn", "Neil Armstrong"], correctAnswer: "Neil Armstrong"),
        (category: "History", question: "In which year did the Renaissance begin?", options: ["15th century", "13th century", "16th century", "14th century"], correctAnswer: "14th century"),
        (category: "History", question: "Who was the first Emperor of Japan?", options: ["Hirohito", "Meiji", "Akihito", "Jimmu"], correctAnswer: "Jimmu"),
        (category: "History", question: "Which civilization invented the wheel?", options: ["Egyptian", "Chinese", "Indian", "Mesopotamian"], correctAnswer: "Mesopotamian"),
        
        // Geography Questions
        (category: "Geography", question: "What is the capital of Japan?", options: ["Seoul", "Beijing", "Bangkok", "Tokyo"], correctAnswer: "Tokyo"),
        (category: "Geography", question: "Which is the largest ocean on Earth?", options: ["Atlantic", "Indian", "Arctic", "Pacific"], correctAnswer: "Pacific"),
        (category: "Geography", question: "What is the capital of France?", options: ["London", "Berlin", "Madrid", "Paris"], correctAnswer: "Paris"),
        (category: "Geography", question: "Which is the largest continent?", options: ["Africa", "North America", "Europe", "Asia"], correctAnswer: "Asia"),
        (category: "Geography", question: "What is the capital of Brazil?", options: ["Rio de Janeiro", "São Paulo", "Salvador", "Brasília"], correctAnswer: "Brasília"),
        (category: "Geography", question: "Which is the longest river in the world?", options: ["Amazon", "Yangtze", "Mississippi", "Nile"], correctAnswer: "Nile"),
        (category: "Geography", question: "What is the capital of Australia?", options: ["Sydney", "Melbourne", "Brisbane", "Canberra"], correctAnswer: "Canberra"),
        (category: "Geography", question: "Which is the largest desert in the world?", options: ["Sahara", "Arabian", "Gobi", "Antarctic"], correctAnswer: "Antarctic"),
        (category: "Geography", question: "What is the capital of India?", options: ["Mumbai", "Kolkata", "Chennai", "New Delhi"], correctAnswer: "New Delhi"),
        (category: "Geography", question: "Which is the highest waterfall in the world?", options: ["Niagara Falls", "Victoria Falls", "Iguazu Falls", "Angel Falls"], correctAnswer: "Angel Falls"),
        (category: "Geography", question: "What is the capital of Russia?", options: ["Saint Petersburg", "Novosibirsk", "Yekaterinburg", "Moscow"], correctAnswer: "Moscow"),
        (category: "Geography", question: "Which is the largest lake by surface area?", options: ["Lake Superior", "Lake Victoria", "Lake Baikal", "Caspian Sea"], correctAnswer: "Caspian Sea"),
        (category: "Geography", question: "What is the capital of Egypt?", options: ["Alexandria", "Luxor", "Aswan", "Cairo"], correctAnswer: "Cairo"),
        (category: "Geography", question: "Which is the largest island in the world?", options: ["New Guinea", "Borneo", "Madagascar", "Greenland"], correctAnswer: "Greenland"),
        (category: "Geography", question: "What is the capital of Canada?", options: ["Toronto", "Vancouver", "Montreal", "Ottawa"], correctAnswer: "Ottawa"),
        (category: "Geography", question: "Which is the deepest ocean trench?", options: ["Puerto Rico Trench", "Java Trench", "Tonga Trench", "Mariana Trench"], correctAnswer: "Mariana Trench"),
        (category: "Geography", question: "What is the capital of South Korea?", options: ["Busan", "Incheon", "Daegu", "Seoul"], correctAnswer: "Seoul"),
        (category: "Geography", question: "Which is the largest country by land area?", options: ["Canada", "China", "United States", "Russia"], correctAnswer: "Russia"),
        (category: "Geography", question: "What is the capital of Argentina?", options: ["Santiago", "Lima", "Bogotá", "Buenos Aires"], correctAnswer: "Buenos Aires"),
        (category: "Geography", question: "Which is the largest coral reef system?", options: ["Belize Barrier Reef", "New Caledonia Barrier Reef", "Red Sea Coral Reef", "Great Barrier Reef"], correctAnswer: "Great Barrier Reef"),
        
        // Mathematics Questions
        (category: "Mathematics", question: "What is 7 x 8?", options: ["54", "58", "62", "56"], correctAnswer: "56"),
        (category: "Mathematics", question: "What is the square root of 144?", options: ["14", "10", "16", "12"], correctAnswer: "12"),
        (category: "Mathematics", question: "What is the value of π (pi) to two decimal places?", options: ["3.12", "3.16", "3.18", "3.14"], correctAnswer: "3.14"),
        (category: "Mathematics", question: "What is 15% of 200?", options: ["25", "35", "40", "30"], correctAnswer: "30"),
        (category: "Mathematics", question: "What is the sum of angles in a triangle?", options: ["160 degrees", "200 degrees", "220 degrees", "180 degrees"], correctAnswer: "180 degrees"),
        (category: "Mathematics", question: "What is 2 to the power of 5?", options: ["30", "34", "36", "32"], correctAnswer: "32"),
        (category: "Mathematics", question: "What is the area of a square with side length 5?", options: ["20", "30", "35", "25"], correctAnswer: "25"),
        (category: "Mathematics", question: "What is the next number in the sequence: 2, 4, 8, 16, ...?", options: ["24", "28", "36", "32"], correctAnswer: "32"),
        (category: "Mathematics", question: "What is the perimeter of a rectangle with length 6 and width 4?", options: ["18", "22", "24", "20"], correctAnswer: "20"),
        (category: "Mathematics", question: "What is the volume of a cube with side length 3?", options: ["24", "30", "33", "27"], correctAnswer: "27"),
        (category: "Mathematics", question: "What is the square root of 81?", options: ["8", "10", "11", "9"], correctAnswer: "9"),
        (category: "Mathematics", question: "What is 3/4 of 100?", options: ["70", "80", "85", "75"], correctAnswer: "75"),
        (category: "Mathematics", question: "What is the circumference of a circle with radius 5?", options: ["30", "32", "33", "31.4"], correctAnswer: "31.4"),
        (category: "Mathematics", question: "What is the sum of the first 10 natural numbers?", options: ["50", "60", "65", "55"], correctAnswer: "55"),
        (category: "Mathematics", question: "What is the factorial of 5?", options: ["100", "140", "160", "120"], correctAnswer: "120"),
        (category: "Mathematics", question: "What is the area of a circle with radius 4?", options: ["48", "52", "54", "50.24"], correctAnswer: "50.24"),
        (category: "Mathematics", question: "What is the next prime number after 17?", options: ["18", "20", "21", "19"], correctAnswer: "19"),
        (category: "Mathematics", question: "What is the sum of angles in a quadrilateral?", options: ["340 degrees", "380 degrees", "400 degrees", "360 degrees"], correctAnswer: "360 degrees"),
        (category: "Mathematics", question: "What is the square of 9?", options: ["80", "82", "83", "81"], correctAnswer: "81"),
        (category: "Mathematics", question: "What is the reciprocal of 4?", options: ["0.2", "0.3", "0.35", "0.25"], correctAnswer: "0.25")
    ]
} 
