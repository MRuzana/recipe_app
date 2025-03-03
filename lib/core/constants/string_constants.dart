//signup
const String signupTitle = "Let's create your account";

//forget password
const String fogetPasswordTitle = 'Forget password';
const String forgetPasswordSubTitle =
    "Don't worry sometimes people can forget too...enter your email and we will send you a password reset link";

//home
const String homescreenTitle = 'Good food happy mood';

final List<Map<String, dynamic>> recipeData = [
  {
    "id":"0",
    "name": "Spaghetti",
    "description":
        "Spaghetti is a long, thin, solid, cylindrical pasta. It is a staple food of traditional Italian cuisine. Like other pasta, spaghetti is made of milled wheat, water, and sometimes enriched with vitamins and minerals. Italian spaghetti is typically made from durum-wheat semolina.",
    "category": "Main Course",
    "ingredients": [
      "Spaghetti",
      "Minced beef",
      "Tomato sauce",
      "Garlic",
      "Onion"
    ],
    'instructions': [
      "Boil the spaghetti according to the package instructions.",
      "Heat olive oil in a pan and sauté onion & garlic.",
      "Add ground beef and cook until browned.",
      "Stir in tomato sauce, salt, and pepper.",
      "Simmer for 15 minutes and serve over spaghetti.",
    ],
    "image": "assets/spaghetti_bolognese.jpg",
    "preparationTime": "30 min"
  },
  {
    "id":"1",
    "name": "Chicken Curry",
    "description": "Chicken curry is a dish of chicken stewed in a spiced sauce made with onions, tomatoes, and herbs. It's a traditional Indian dish that's popular around the world. Chicken curry is a dish of chicken stewed in a spiced sauce made with onions, tomatoes, and herbs. It's a traditional Indian dish that's popular around the world Chicken curry is a dish of chicken stewed in a spiced sauce made with onions, tomatoes, and herbs. It's a traditional Indian dish that's popular around the world Chicken curry is a dish of chicken stewed in a spiced sauce made with onions, tomatoes, and herbs. It's a traditional Indian dish that's popular around the world", 

    "category": "Main Course",
    "image": "assets/chickenCurry.jpg",
    "ingredients": [
      "Chicken",
      "Coconut milk",
      "Curry powder",
      "Onions",
      "Garlic"
    ],
     "instructions": [
      "Heat oil in a pan and sauté chopped onions until golden brown.",
      "Add minced garlic and stir for 30 seconds.",
      "Add chicken pieces and cook until they turn white.",
      "Sprinkle curry powder and mix well.",
      "Pour in coconut milk and let it simmer for 25–30 minutes.",
      "Stir occasionally and cook until the sauce thickens.",
      "Serve hot with rice or naan!"
    ],
    "preparationTime": "45 min"
  },
  { 
    "id":"2",
    "name": "Kabab",
    "description": "A kebab is a dish of grilled meat that's often made with lamb or beef, but can also include chicken, fish, or goat. The word 'kebab' comes from Persian and Turkish. ",
    "category": "Appetizers",
    "image": "assets/kabab.jpg",
    "ingredients": [
      "Minced lamb or beef",
      "Garlic",
      "Onions",
      "Spices",
      "Skewers"
    ],
    "instructions": [
      "In a bowl, mix minced meat, chopped onions, garlic, and spices.",
      "Shape the mixture into small logs and insert skewers.",
      "Preheat the grill or pan.",
      "Grill the kababs, turning them occasionally, for 15-20 minutes.",
      "Serve hot with chutney or salad!"
    ],
    "preparationTime": "40 min"
  },
  {
    "id":"3",
    "name": "Pancakes",
    "description": "A pancake is a flat, thin, round cake typically made from a batter of flour, eggs, and milk, cooked on a hot griddle or frying pan on both sides, and often served for breakfast, usually topped with syrup or other sweet toppings; it can also be considered a type of batter bread. ",
    "category": "Breakfast",
    "ingredients": ["Flour", "Milk", "Eggs", "Baking powder", "Sugar"],
    "image": "assets/pancake.jpg",
    "preparationTime": "15 min",
    "instructions": [
      "In a bowl, whisk together flour, sugar, and baking powder.",
      "In another bowl, mix milk and eggs.",
      "Gradually combine the wet and dry ingredients to make a smooth batter.",
      "Heat a non-stick pan and pour a small amount of batter.",
      "Cook until bubbles form, then flip and cook the other side.",
      "Serve hot with syrup or fresh fruits!"
    ]
  },
  {
    "id":"4",
    "name": "Strawberry Cheesecake",
    "description": "Strawberry cheesecake is a dessert made with a creamy cheesecake filling, strawberries, and a crust. The strawberries can be fresh, roasted, or pureed. The crust can be made from graham crackers, shortbread, or biscuits. ",
    "image": "assets/strwberry.jpg",
    "category": "Dessert",
    "ingredients": [
      "Cream cheese",
      "Strawberries",
      "Sugar",
      "Graham crackers",
      "Butter"
    ],
    "preparationTime": "45 min",
    "instructions": [
      "Crush graham crackers and mix with melted butter.",
      "Press the mixture into a pan to form the crust.",
      "Beat cream cheese and sugar until smooth.",
      "Pour the mixture over the crust and refrigerate for 30 minutes.",
      "Top with fresh strawberries and serve chilled!"
    ]
  },
];


