import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key,required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child: InkWell(
        onTap: (){},
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage), 
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width:double.infinity,
              ),
              Positioned(
                bottom:0,
                left: 0,
                right: 0,
                child:Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        ),
                      const SizedBox(height: 5,),
                      Row(children: [

                      ],
                      )

                    ],
                  ),
                ) ,
                ),
          ],
        ),
      ),
    );
  }
}