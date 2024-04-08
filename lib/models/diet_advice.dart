
// STORES DATA FOR POSTS FOUND IN THE NUTRITION ADVICE SCREEN, WITH A TITLE, DESCRIPTION, IMAGE, AND LINK TO AN ARTICLE
// ======================================================================================================================

class DietModel {
  String image, title, desciption, articleText, articleURL;

  DietModel(
      {required this.image,
      required this.articleText,
      required this.articleURL,
      required this.desciption,
      required this.title});
  
}
 List<DietModel> dietAvices = [
    DietModel(
        image: 'assets/dietadvice/Macros-min.jpg',
        articleText:
            'The macronutrients, appetite, and Energy Intake (2016) Annual review of nutrition. U.S. National Library of Medicine. Available at:',
        articleURL: 'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4960974',
        desciption:
            'A balanced diet that includes a mix of carbohydrates, proteins, and fats is essential for optimal health. Carbohydrates are the main source of energy for the body, and proteins are essential for building and repairing tissues. Fats are important for energy and hormone production. Consuming too much of any one macronutrient can lead to health problems, and a balanced intake is necessary for optimal health. For example, a diet that is too high in saturated fat can increase the risk of heart disease, while a diet that is too low in carbohydrates can lead to fatigue and decreased mental function.  ',
        title: 'Balanced macronutrient intake'),
    DietModel(
        image: 'assets/dietadvice/Portions-min.jpg',
        articleText:
            'Bda (2022) Portion control in weight management, British Dietetic Association (BDA). Available at:',
        articleURL:
            'https://www.bda.uk.com/resource/portion-control-in-weight-management-one-size-plate-doesn-t-fit-all.html',
        desciption:
            'Overeating is a common problem that can lead to weight gain and other health problems. Learning how to control portions can help individuals maintain a healthy weight. Portion control involves understanding appropriate serving sizes and limiting the amount of food consumed. For example, a serving of meat should be about the size of a deck of cards, while a serving of pasta should be about the size of a tennis ball. Portion control can be challenging, as many people are used to larger portion sizes. However, with practice, it is possible to learn how to control portions and maintain a healthy weight.',
        title: 'Proper portion control'),
    DietModel(
        image: 'assets/dietadvice/Water-min.jpg',
        articleText:
            'How much water do you need to stay healthy? | (2022) Mayo Clinic. - Mayo Foundation for Medical Education and Research. Available at:',
        articleURL:
            'https://www.mayoclinic.org/healthy-lifestyle/nutrition-and-healthy-eating/in-depth/water/art-20044256',
        desciption:
            'Staying hydrated is crucial for overall health, and many people do not drink enough water. Drinking water can help with digestion, boost energy levels, and prevent dehydration. The human body is made up of about 60% water, and it is essential for many bodily functions, including regulating body temperature, removing waste, and lubricating joints. Dehydration can lead to fatigue, dizziness, and other health issues. Drinking water throughout the day can help individuals stay hydrated and maintain optimal health. ',
        title: 'Importance of hydration'),
    DietModel(
        image: 'assets/dietadvice/Fibre-min.jpg',
        articleText:
            'How to get more fibre into your diet. | NHS. (2022, July 13) |Available at:',
        articleURL:
            'https://www.nhs.uk/live-well/eat-well/how-to-get-more-fibre-into-your-diet',
        desciption:
            'Fiber is an essential nutrient that aids in digestion, promotes satiety, and helps regulate blood sugar levels. Including high-fiber foods in the diet can have many health benefits. Fiber is found in plant-based foods, such as fruits, vegetables, whole grains, and legumes. It passes through the digestive system relatively intact and helps promote regular bowel movements. It can also help lower cholesterol levels, regulate blood sugar levels, and promote feelings of fullness, which can aid in weight management.',
        title: 'The role of fiber'),
    DietModel(
        image: 'assets/dietadvice/NutritionLabel-min.jpg',
        articleText: 'NHS. (2022, Sep 16). Food labels. Available at: ',
        articleURL:
            'https://www.nhs.uk/live-well/eat-well/how-to-read-food-labels',
        desciption:
            'Many people do not understand how to read food labels and may not be aware of the nutritional content of the foods they eat. Learning how to read food labels can help individuals make more informed decisions about their food choices. Food labels provide information about the serving size, calories, and nutrient content of a food product. They can also provide information about the ingredients and any potential allergens. Understanding food labels can help individuals make healthier food choices by comparing the nutrient content of different products and choosing foods that are lower in calories and higher in nutrients.',
        title: 'Understanding food labels'),
    DietModel(
        image: 'assets/dietadvice/MealPlan-min.jpg',
        articleText:
            'British Heart Foundation (no date) 12 ways to get your diet back on track, BHF.  Available at:',
        articleURL:
            'https://www.bhf.org.uk/informationsupport/heart-matters-magazine/nutrition/weight/quick-fixes',
        desciption:
            'Planning meals ahead of time can help individuals make healthier food choices and avoid impulsive, unhealthy choices. Meal planning involves deciding what to eat ahead of time and preparing meals in advance. It can also involve making a grocery list and purchasing the necessary ingredients. Meal planning can help individuals save time and money by reducing the need for last-minute food decisions, which can often lead to unhealthy choices. It can also help individuals ensure that they are getting a balanced intake of nutrients and help them avoid skipping meals. ',
        title: 'Importance of meal planning'),
    DietModel(
        image: 'assets/dietadvice/Coffee-min.jpg',
        articleText:
            'Gunnars, K. (2018) Coffee - good or bad?, Healthline. Healthline Media. Available at: ',
        articleURL:
            'https://www.healthline.com/nutrition/coffee-good-or-bad#TOC_TITLE_HDR_3',
        desciption:
            'Drinking coffee can have both health benefits and potential drawbacks, depending on individual factors such as genetics, overall health, and lifestyle. While coffee contains antioxidants and may help reduce the risk of certain diseases, such as type 2 diabetes and liver disease, excessive caffeine intake can also cause negative effects, such as anxiety, sleep disturbances, and heart palpitations.',
        title: 'Drinking coffee')
  ];