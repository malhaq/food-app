import 'package:flutter/material.dart';
import 'package:food_app/widgets/meal_items_content.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:food_app/models/meal.dart';

class MealItems extends StatelessWidget {
  const MealItems({
    super.key,
    required this.meal,
    required this.onSelectedMeal,
  });

  String get complexityString{
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }
  String get affordabilityString{
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }

  final Meal meal;
  final void Function(Meal meal) onSelectedMeal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      child: InkWell(
        onTap: () {
          onSelectedMeal(meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemsContent(
                          icon: Icons.schedule,
                          lable: '${meal.duration} min',
                        ),
                        const SizedBox(width: 10),
                        MealItemsContent(
                          icon: Icons.work,
                          lable: complexityString,
                        ),
                        const SizedBox(width: 10),
                        MealItemsContent(
                          icon: Icons.attach_money,
                          lable: affordabilityString,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
