//
//  BuildCoreData.swift
//  getDataTest
//
//  Created by Pamela Lim on 17/5/23.
//

// BuildCoredData.swift

import Foundation
import CoreData
import UIKit

let entityRecipe = "Recipe"
let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

func addRecipes() {

    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let appContext: NSManagedObjectContext = appDel.persistentContainer.viewContext

    // If you need to delete any existing records, say for an app refresh, then use the code below end func before you add new records.
    addRecipe1()
    addRecipe2()
    addRecipe3()
    addRecipe4()
    addRecipe5()
    addRecipe6()
    addRecipe7()
    addRecipe8()
//    addRecipe9()
//    addRecipe10()



    do { try appContext.save()
        UserDefaults.standard.set(true, forKey: "isRecipesAdded")
        UserDefaults.standard.synchronize()
    } catch _ {
        print(#function, "Error Adding Recipe Samples")
    }


    //use this to delete things
//    UserDefaults.standard.set(false, forKey: "isRecipesAdded")
//    let requestDelete8Books = NSFetchRequest<NSFetchRequestResult>(entityName: entityRecipe)
//    requestDelete8Books.returnsObjectsAsFaults = false
//    let appRecordsToDelete = try? managedObjectContext?.fetch(requestDelete8Books)
//    if (appRecordsToDelete?.count)! > 0 {
//        for recordToDelete in appRecordsToDelete! {
//            managedObjectContext?.delete(recordToDelete as! Recipe)
//            print(#function, "Deleted Record")
//            do { try managedObjectContext?.save() } catch _ { }
//        }
//    }

}


func addRecipe1() {

    if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

        // RECIPE
        let recipe = NSEntityDescription.insertNewObject(forEntityName: entityRecipe, into: managedObjectContext) as! Recipe

        recipe.name = "Garlic Butter Steak"
        recipe.serves = "1hr 8 mins"
        recipe.timeTaken = "2"
        recipe.favourite = false
        recipe.ingredients = ["1 ribeye steak, 2-inch (5-cm)-thick, preferably USDA Prime",
                              "kosher salt, to taste",
                              "freshly ground black pepper, to taste",
                              "3 tablespoons canola oil",
                              "3 tablespoons unsalted butter",
                              "3 cloves garlic, peeled and smashed",
                              "2 sprigs fresh rosemary",
                              "3 sprigs fresh thyme"]
        recipe.steps = ["1. Preheat oven to 200°F (95°C). Set a wire rack on top of a rimmed baking sheet.",
                        "2. Generously season the steak on all sides with salt and pepper.",
                        "3. Transfer the steak to the wire rack, then bake for 45–60 minutes, until the internal temperature reaches about 125°F (51°C) for medium-rare, or your desired doneness.",
                        "4. Heat the canola oil in a cast-iron skillet over high heat until smoking. (Do not use olive oil, as its smoke point is significantly lower than that of canola oil and will smoke before reaching the desired cooking temperature.)",
                        "5. Sear the steak for 30 seconds on the first side, then flip. Add the butter, garlic, rosemary, and thyme and swirl around the pan. Place the garlic and herbs on top of the steak and baste the steak with the butter using a large spoon for about 30 seconds, then flip and baste the other side for about 15 seconds. Turn the steak on its side to render off any excess fat.",
                        "6. Transfer the steak to a cutting board or wire rack to rest for about 10 minutes. (Slicing the steak before the resting period has finished will result in a lot of the juices leaking out, which may not be desirable.)",
                        "7. Slice the steak into ½-inch (1-cm) strips, then fan out the slices and serve."]


        // PHOTO: Convert a UIImage into a Data so you can write it out to Core Data.
        if let recipeImage = UIImage(named: "steak") {
            recipe.image = recipeImage.jpegData(compressionQuality: 1.0) // Save as JPEG Data object
        }


    }
}

func addRecipe2() {

    if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

        // RECIPE
        let recipe = NSEntityDescription.insertNewObject(forEntityName: entityRecipe, into: managedObjectContext) as! Recipe

        recipe.name = "Zucchini Fritter"
        recipe.serves = "20 mins"
        recipe.timeTaken = "6"
        recipe.favourite = false
        recipe.ingredients = ["2 lb zucchini, about 2 large or 5 medium",
                              "1 1/2 tsp fine sea salt, divided",
                              "2 large eggs, lightly beaten",
                              "1/2 cup chopped green onions",
                              "3/4 cup all-purpose flour",
                              "1 tsp baking powder",
                              "1/2 tsp ground black pepper",
                              "olive oil for sautéing",
                              "sour cream, to serve"]
        recipe.steps = ["1. Wash zucchini and trim off ends. Grate on the large holes of a box grater or use the grater attachment for the food processor. Place zucchini in a large mixing bowl, stir in 1 tsp salt, and set aside for 10 minutes.",
                        "2. After 10 minutes, squeeze handfuls of zucchini tightly over the sink to remove extra water. It helps to wring it out in a cheesecloth if you have one. It is impressive how much water comes out! You should end up with 3 1/2 to 4 cups of squeezed dry zucchini. Transfer to a large mixing bowl.",
                        "3. Add 1/2 cups chopped green onion and 2 lightly beaten eggs.",
                        "4. In a small bowl, stir together 3/4 cup flour with 1 tsp baking powder, 1/2 tsp salt and 1/2 tsp black pepper, or season to taste. Add flour mixture into zucchini mixture and stir until well combined.",
                        "5. Place a large heavy-bottomed cast iron or non-stick skillet over medium heat* and add 2 Tbsp olive oil. Once the oil is hot, add the zucchini mixture a heaping tablespoon at a time** and flatten out the tops slightly to make them pancake-shaped. Sauté for 3-5 minutes per side or until golden brown. If they brown too quickly, reduce the heat. Serve warm with a dollop of sour cream."]


        // PHOTO: Convert a UIImage into a Data so you can write it out to Core Data.
        if let recipeImage = UIImage(named: "zucchini fritters") {
            recipe.image = recipeImage.jpegData(compressionQuality: 1.0) // Save as JPEG Data object
        }

    }
}

func addRecipe3() {

    if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

        // RECIPE
        let recipe = NSEntityDescription.insertNewObject(forEntityName: entityRecipe, into: managedObjectContext) as! Recipe

        recipe.name = "Cacio e Pepe"
        recipe.serves = "20 mins"
        recipe.timeTaken = "4"
        recipe.favourite = false
        recipe.ingredients = ["12 ounces spaghetti",
                              "4 tablespoons unsalted butter, at room temperature",
                              "1 tablespoon extra-virgin olive oil",
                              "⅔ cup grated Pecorino Romano cheese",
                              "Kosher salt and freshly ground black pepper, to taste"]
        recipe.steps = ["1. Bring a large pot of salted water to a boil. Add the spaghetti and cook until just al dente, 8 to 10 minutes.",
                        "2. While the pasta cooks, mash the soft butter with the olive oil and Pecorino in a large bowl to form a paste.",
                        "3. When the pasta is cooked, reserve ½ cup of the pasta cooking water and drain the spaghetti. Add the spaghetti directly to the bowl with the butter mixture. Toss well to coat, adding the pasta water as needed to make a thick, creamy sauce that coats the pasta strands. Season to taste with salt and lots of freshly ground black pepper. Divide the pasta among four plates; serve immediately."]
        //        recipe.image = UIImage(named: "Cacio e Pepe")


        // PHOTO: Convert a UIImage into a Data so you can write it out to Core Data.
        if let recipeImage = UIImage(named: "Cacio e Pepe") {
            recipe.image = recipeImage.jpegData(compressionQuality: 1.0) // Save as JPEG Data object
        }

    }
}

func addRecipe4() {

    if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

        // RECIPE
        let recipe = NSEntityDescription.insertNewObject(forEntityName: entityRecipe, into: managedObjectContext) as! Recipe

        recipe.name = "Cheesy gnocchi with spinach and sausage"
        recipe.serves = "15 mins"
        recipe.timeTaken = "4"
        recipe.favourite = false
        recipe.ingredients = ["500g Garlic & Herb Pork Sausages",
                              "500g pkt Potato Gnocchi",
                              "490g jar three-cheese pasta sauce",
                              "60g pkt Australian Baby Spinach",
                              "1/3 cup (25g) finely grated parmesan"
        ]
        recipe.steps = ["1. Heat a large frying pan over medium heat. Add sausages and cook, turning, for 4-5 mins or until browned. Transfer to a plate. Thickly slice the sausages.",
                        "2. Meanwhile, cook the gnocchi in a saucepan of boiling water following packet directions. Drain, reserving 1/2 cup (125ml) of the cooking liquid.",
                        "3. Return the sausage to the frying pan with pasta sauce, spinach, gnocchi and reserved cooking liquid. Cook, stirring, until mixture is heated through. Season. Sprinkle with parmesan."]

        // PHOTO: Convert a UIImage into a Data so you can write it out to Core Data.
        if let recipeImage = UIImage(named: "Cheesy gnocchi") {
            recipe.image = recipeImage.jpegData(compressionQuality: 1.0) // Save as JPEG Data object
        }

    }
}

func addRecipe5() {

    if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

        // RECIPE
        let recipe = NSEntityDescription.insertNewObject(forEntityName: entityRecipe, into: managedObjectContext) as! Recipe

        recipe.name = "Cream of mushroom soup"
        recipe.serves = "40 mins"
        recipe.timeTaken = "6"
        recipe.favourite = false
        recipe.ingredients = ["4 tablespoons butter",
                              "1 tablespoon oil",
                              "2 onions diced",
                              "4 cloves garlic minced",
                              "1 1/2 pounds (750 g) fresh brown mushrooms sliced",
                              "4 teaspoons chopped thyme divided",
                              "1/2 cup Marsala wine (any dry red or white wine)",
                              "6 tablespoons all-purpose flour",
                              "4 cups low sodium chicken broth or stock",
                              "1-2 teaspoons salt adjust to taste",
                              "1 teaspoons black cracked pepper adjust to taste",
                              "2 beef bouillon cubes, crumbled",
                              "1 cup heavy cream or half and half (sub with evaporated milk)",
                              "Chopped fresh parsley and thyme to serve"
        ]
        recipe.steps = ["1. Heat butter and oil in a large pot over medium-high heat until melted. Sauté onion for 2 to 3 minutes until softened. Cook garlic until fragrant, about 1 minute.",
                        "2. Add mushrooms and 2 teaspoons thyme, cook for 5 minutes. Pour in wine and allow to cook for 3 minutes.",
                        "3. Sprinkle mushrooms with flour, mix well and cook for 2 minutes. Add stock, mix again and bring to a boil. Reduce heat to low-medium heat, season with salt, pepper and crumbled bouillon cubes.",
                        "4. Cover and allow to simmer for 10-15 minutes, while occasionally stirring, until thickened.",
                        "5. Reduce heat to low, stir in cream or half and half. Allow to gently simmer (do not boil). Adjust salt and pepper to your taste.",
                        "6. Mix in parsley and remaining thyme. Serve warm."]

        // PHOTO: Convert a UIImage into a Data so you can write it out to Core Data.
        if let recipeImage = UIImage(named: "Mushroom soup") {
            recipe.image = recipeImage.jpegData(compressionQuality: 1.0) // Save as JPEG Data object
        }

    }
}

func addRecipe6() {

    if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

        // RECIPE
        let recipe = NSEntityDescription.insertNewObject(forEntityName: entityRecipe, into: managedObjectContext) as! Recipe

        recipe.name = "Apricot chicken tray bake"
        recipe.serves = "55 mins"
        recipe.timeTaken = "4"
        recipe.favourite = false
        recipe.ingredients = ["695g tub apricot halves in juice",
                              "4 sprigs fresh rosemary",
                              "2 tbsp French onion soup mix",
                              "1 tbsp extra virgin olive oil",
                              "1kg Chicken Drumsticks",
                              "500g baby chat potatoes, halved",
                              "1 red onion, cut into thin wedges"
        ]
        recipe.steps = ["1. Preheat oven to 200C/180C fan-forced. Grease a large baking tray with sides. Line tray with baking paper.",
                        "2. Drain apricots, reserving 1/3 cup juice. Remove leaves from 1 rosemary sprig. Finely chop. Place soup mix, chopped rosemary, oil and reserved juice in a jug. Stir until well combined. Arrange chicken, apricots, potato and onion, in a single layer, on prepared tray. Drizzle over soup mixture. Season with salt and pepper.",
                        "3. Bake, turning chicken and adding remaining rosemary sprigs halfway, for 45 minutes or until chicken is cooked through and potato is tender. Serve."]

        // PHOTO: Convert a UIImage into a Data so you can write it out to Core Data.
        if let recipeImage = UIImage(named: "Chicken bake") {
            recipe.image = recipeImage.jpegData(compressionQuality: 1.0) // Save as JPEG Data object
        }

    }
}


func addRecipe7() {

    if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

        // RECIPE
        let recipe = NSEntityDescription.insertNewObject(forEntityName: entityRecipe, into: managedObjectContext) as! Recipe

        recipe.name = "Old-Fashioned Beef Stew"
        recipe.serves = "2 hrs 30 mins"
        recipe.timeTaken = "4"
        recipe.favourite = false
        recipe.ingredients = ["¼cup all-purpose flour",
                              "¼teaspoon freshly ground pepper",
                              "1 pound beef stewing meat, trimmed and cut into inch cubes",
                              "5 teaspoons vegetable oil",
                              "2tablespoons red wine vinegar",
                              "1cup red wine",
                              "3½ cups beef broth, homemade or low-sodium canned",
                              "2 bay leaves",
                              "1 medium onion, peeled and chopped",
                              "5 medium carrots, peeled and cut into ¼-inch rounds",
                              "2 large baking potatoes, peeled and cut into ¾-inch cubes",
                              "2 teaspoons salt"]
        recipe.steps = ["1. Combine the flour and pepper in a bowl, add the beef and toss to coat well.",
                        "2. Heat 3 teaspoons of the oil in a large pot. Add the beef a few pieces at a time; do not overcrowd. Cook, turning the pieces until beef is browned on all sides, about 5 minutes per batch; add more oil as needed between batches.",
                        "3. Remove the beef from the pot and add the vinegar and wine. Cook over medium-high heat, scraping the pan with a wooden spoon to loosen any browned bits. Add the beef, beef broth and bay leaves. Bring to a boil, then reduce to a slow simmer.",
                        "4. Cover and cook, skimming broth from time to time, until the beef is tender, about 1½ hours. Add the onions and carrots and simmer, covered, for 10 minutes. Add the potatoes and simmer until vegetables are tender, about 30 minutes more. Add broth or water if the stew is dry. Season with salt and pepper to taste. Ladle among 4 bowls and serve."]

        // PHOTO: Convert a UIImage into a Data so you can write it out to Core Data.
        if let recipeImage = UIImage(named: "beef stew") {
            recipe.image = recipeImage.jpegData(compressionQuality: 1.0) // Save as JPEG Data object
        }

    }
}


func addRecipe8() {

    if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

        // RECIPE
        let recipe = NSEntityDescription.insertNewObject(forEntityName: entityRecipe, into: managedObjectContext) as! Recipe

        recipe.name = "Easy chocolate fudge cake"
        recipe.serves = "55 mins"
        recipe.timeTaken = "8"
        recipe.favourite = false
        recipe.ingredients = ["150ml sunflower oil, plus extra for the tin",
                              "175g self-raising flour",
                              "2 tbsp cocoa powder",
                              "1 tsp bicarbonate of soda",
                              "150g caster sugar",
                              "2 tbsp golden syrup",
                              "2 large eggs, lightly beaten",
                              "150ml semi-skimmed milk",
                              "100g unsalted butter",
                              "225g icing sugar",
                              "40g cocoa powder",
                              "2½ tbsp milk"
        ]
        recipe.steps = ["1. Heat the oven to 180C/160C fan/gas 4. Oil and line the base of two 18cm sandwich tins. Sieve the flour, cocoa powder and bicarbonate of soda into a bowl. Add the caster sugar and mix well.",
                        "2. Make a well in the centre and add the golden syrup, eggs, sunflower oil and milk. Beat well with an electric whisk until smooth.",
                        "3. Pour the mixture into the two tins and bake for 25-30 mins until risen and firm to the touch. Remove from oven, leave to cool for 10 mins before turning out onto a cooling rack.",
                        "4. Co make the icing, beat the unsalted butter in a bowl until soft. Gradually sieve and beat in the icing sugar and cocoa powder, then add enough of the milk to make the icing fluffy and spreadable.",
        "5. Sandwich the two cakes together with the butter icing and cover the sides and the top of the cake with more icing."]

        // PHOTO: Convert a UIImage into a Data so you can write it out to Core Data.
        if let recipeImage = UIImage(named: "chocolate") {
            recipe.image = recipeImage.jpegData(compressionQuality: 1.0) // Save as JPEG Data object
        }

    }
}
